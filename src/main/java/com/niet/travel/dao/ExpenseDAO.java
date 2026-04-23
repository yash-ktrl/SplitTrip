package com.niet.travel.dao;

import com.niet.travel.model.Expense;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ExpenseDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Expense> expenseRowMapper = new RowMapper<Expense>() {
        @Override
        public Expense mapRow(ResultSet rs, int rowNum) throws SQLException {
            Expense expense = new Expense();
            expense.setId(rs.getInt("id"));
            expense.setTripId(rs.getInt("trip_id"));
            expense.setPaidBy(rs.getInt("paid_by"));
            expense.setPaidByName(rs.getString("username"));
            expense.setAmount(rs.getBigDecimal("amount"));
            expense.setCategory(rs.getString("category"));
            expense.setDescription(rs.getString("description"));
            expense.setDateAdded(rs.getTimestamp("date_added"));
            return expense;
        }
    };

    public List<Expense> findExpensesByTripId(int tripId) {
        String sql = "SELECT e.*, u.username FROM expenses e JOIN users u ON e.paid_by = u.id WHERE e.trip_id = ? ORDER BY e.date_added DESC";
        return jdbcTemplate.query(sql, expenseRowMapper, tripId);
    }

    public void saveExpense(Expense expense) {
        String sql = "INSERT INTO expenses (trip_id, paid_by, amount, category, description) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, expense.getTripId(), expense.getPaidBy(), expense.getAmount(), expense.getCategory(), expense.getDescription());
    }
}
