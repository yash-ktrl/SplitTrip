package com.niet.travel.controller;

import com.niet.travel.dao.ExpenseDAO;
import com.niet.travel.dao.ParticipantDAO;
import com.niet.travel.dao.TripDAO;
import com.niet.travel.model.Expense;
import com.niet.travel.model.Participant;
import com.niet.travel.model.TripNote;
import com.niet.travel.model.Trip;
import com.niet.travel.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class TripController {

    @Autowired
    private TripDAO tripDAO;
    @Autowired
    private ParticipantDAO participantDAO;
    @Autowired
    private ExpenseDAO expenseDAO;
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/trip/create")
    public String showCreateTripForm(HttpSession session) {
        if (session.getAttribute("user") == null) return "redirect:/login";
        return "create_trip";
    }

    @PostMapping("/trip/create")
    public String createTrip(
            @RequestParam String title, @RequestParam String tripType,
            @RequestParam String destination, @RequestParam(required = false) String origin,
            @RequestParam String startDate, @RequestParam String endDate,
            @RequestParam(required = false) String hotelDetails,
            @RequestParam(required = false) String activities,
            @RequestParam(required = false) String description,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Trip trip = new Trip();
        trip.setCreatorId(user.getId());
        trip.setTitle(title);
        trip.setTripType(tripType);
        trip.setDestination(destination);
        trip.setOrigin(origin);
        trip.setStartDate(Date.valueOf(startDate));
        trip.setEndDate(Date.valueOf(endDate));
        trip.setHotelDetails(hotelDetails);
        trip.setActivities(activities);
        trip.setDescription(description);

        int tripId = tripDAO.saveTrip(trip);
        participantDAO.addParticipant(tripId, user.getId(), "APPROVED");

        return "redirect:/trip/" + tripId;
    }

    @GetMapping("/trip/{id}")
    public String viewTrip(@PathVariable int id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Trip trip = tripDAO.findById(id);
        if (trip == null) return "redirect:/";

        List<Participant> participants = participantDAO.findParticipantsByTripId(id);
        List<Expense> expenses = expenseDAO.findExpensesByTripId(id);

        boolean isParticipant = participants.stream().anyMatch(p -> p.getUserId() == user.getId());
        boolean isApproved = participants.stream().anyMatch(p -> p.getUserId() == user.getId() && "APPROVED".equals(p.getStatus()));
        boolean isCreator = trip.getCreatorId() == user.getId();

        model.addAttribute("trip", trip);
        model.addAttribute("participants", participants);
        model.addAttribute("expenses", expenses);
        model.addAttribute("isParticipant", isParticipant);
        model.addAttribute("isApproved", isApproved);
        model.addAttribute("isCreator", isCreator);

        // Notes
        List<TripNote> notes = jdbcTemplate.query(
            "SELECT n.*, u.username FROM trip_notes n JOIN users u ON n.user_id = u.id WHERE n.trip_id = ? ORDER BY n.created_at DESC",
            new RowMapper<TripNote>() {
                public TripNote mapRow(ResultSet rs, int rowNum) throws SQLException {
                    TripNote note = new TripNote();
                    note.setId(rs.getInt("id"));
                    note.setTripId(rs.getInt("trip_id"));
                    note.setUserId(rs.getInt("user_id"));
                    note.setUsername(rs.getString("username"));
                    note.setContent(rs.getString("content"));
                    note.setCreatedAt(rs.getTimestamp("created_at"));
                    return note;
                }
            }, id);
        model.addAttribute("notes", notes);

        // Split algorithm
        List<Participant> approved = participants.stream()
                .filter(p -> "APPROVED".equals(p.getStatus()))
                .collect(Collectors.toList());

        int numStudents = approved.size();
        BigDecimal totalExpense = expenses.stream()
                .map(Expense::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("totalExpense", totalExpense);

        if (numStudents > 0) {
            BigDecimal perPerson = totalExpense.divide(new BigDecimal(numStudents), 2, java.math.RoundingMode.HALF_UP);
            model.addAttribute("perPerson", perPerson);

            Map<Integer, BigDecimal> balances = new HashMap<>();
            for (Participant p : approved) {
                BigDecimal paid = expenses.stream()
                        .filter(e -> e.getPaidBy() == p.getUserId())
                        .map(Expense::getAmount)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);

                String paidSql = "SELECT COALESCE(SUM(amount), 0) FROM payments WHERE trip_id = ? AND user_id = ?";
                BigDecimal settled = jdbcTemplate.queryForObject(paidSql, BigDecimal.class, trip.getId(), p.getUserId());
                paid = paid.add(settled);

                balances.put(p.getUserId(), paid.subtract(perPerson));
            }
            model.addAttribute("balances", balances);
        }

        return "trip_details";
    }

    @PostMapping("/trip/{id}/join")
    public String joinTrip(@PathVariable int id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && !participantDAO.isParticipant(id, user.getId())) {
            participantDAO.addParticipant(id, user.getId(), "PENDING");
        }
        return "redirect:/trip/" + id;
    }

    @PostMapping("/trip/{tripId}/approve")
    public String approveParticipant(@PathVariable int tripId, @RequestParam int userId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Trip trip = tripDAO.findById(tripId);
        if (user != null && trip != null && trip.getCreatorId() == user.getId()) {
            participantDAO.updateStatus(tripId, userId, "APPROVED");
        }
        return "redirect:/trip/" + tripId;
    }

    @PostMapping("/trip/{tripId}/note")
    public String addNote(@PathVariable int tripId, @RequestParam String content, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && content != null && !content.trim().isEmpty()) {
            jdbcTemplate.update("INSERT INTO trip_notes (trip_id, user_id, content) VALUES (?, ?, ?)", tripId, user.getId(), content.trim());
        }
        return "redirect:/trip/" + tripId;
    }
}
