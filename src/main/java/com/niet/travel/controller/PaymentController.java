package com.niet.travel.controller;

import com.niet.travel.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;

@Controller
public class PaymentController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/trip/{tripId}/pay")
    public String showPaymentInterface(@PathVariable int tripId, @RequestParam BigDecimal amount, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        model.addAttribute("tripId", tripId);
        model.addAttribute("amount", amount.abs()); // Send positive amount to pay
        return "mock_payment";
    }

    @PostMapping("/trip/{tripId}/pay/process")
    public String processPayment(@PathVariable int tripId, @RequestParam BigDecimal amount, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        String sql = "INSERT INTO payments (trip_id, user_id, amount) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, tripId, user.getId(), amount);

        return "redirect:/trip/" + tripId;
    }
}
