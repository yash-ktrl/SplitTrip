package com.niet.travel.controller;

import com.niet.travel.dao.TripDAO;
import com.niet.travel.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @Autowired
    private TripDAO tripDAO;

    @GetMapping("/")
    public String index(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Show trips the user created or joined
            model.addAttribute("allTrips", tripDAO.findAllTrips());
            return "dashboard";
        }
        return "index"; // Landing page for guests
    }
}
