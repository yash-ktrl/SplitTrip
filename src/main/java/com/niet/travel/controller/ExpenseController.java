package com.niet.travel.controller;

import com.niet.travel.dao.ExpenseDAO;
import com.niet.travel.dao.ParticipantDAO;
import com.niet.travel.model.Expense;
import com.niet.travel.model.Participant;
import com.niet.travel.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class ExpenseController {

    @Autowired
    private ExpenseDAO expenseDAO;

    @Autowired
    private ParticipantDAO participantDAO;

    @PostMapping("/trip/{tripId}/expense/add")
    public String addExpense(
            @PathVariable("tripId") int tripId,
            @RequestParam BigDecimal amount,
            @RequestParam String category,
            @RequestParam String description,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // Only approved participants can add expenses
        List<Participant> participants = participantDAO.findParticipantsByTripId(tripId);
        boolean isApproved = participants.stream()
                .anyMatch(p -> p.getUserId() == user.getId() && "APPROVED".equals(p.getStatus()));

        if (isApproved) {
            Expense expense = new Expense();
            expense.setTripId(tripId);
            expense.setPaidBy(user.getId());
            expense.setAmount(amount);
            expense.setCategory(category);
            expense.setDescription(description);
            expenseDAO.saveExpense(expense);
        }

        return "redirect:/trip/" + tripId;
    }
}
