package com.niet.travel.controller;

import com.niet.travel.dao.TripDAO;
import com.niet.travel.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

@Controller
public class AdminController {

    @Autowired
    private TripDAO tripDAO;
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/admin")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/";
        }
        
        model.addAttribute("allTrips", tripDAO.findAllTrips());
        
        String usersSql = "SELECT id, username, full_name, role FROM users";
        List<Map<String, Object>> usersList = jdbcTemplate.queryForList(usersSql);
        model.addAttribute("usersList", usersList);
        
        String expensesSql = "SELECT e.amount, e.category, e.date_added, u.username as paid_by, t.title as trip_title FROM expenses e JOIN users u ON e.paid_by = u.id JOIN trips t ON e.trip_id = t.id ORDER BY e.date_added DESC";
        List<Map<String, Object>> globalExpenses = jdbcTemplate.queryForList(expensesSql);
        model.addAttribute("globalExpenses", globalExpenses);

        return "admin_dashboard";
    }
}
