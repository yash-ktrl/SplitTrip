package com.niet.travel.dao;

import com.niet.travel.model.Participant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ParticipantDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Participant> participantRowMapper = new RowMapper<Participant>() {
        @Override
        public Participant mapRow(ResultSet rs, int rowNum) throws SQLException {
            Participant p = new Participant();
            p.setTripId(rs.getInt("trip_id"));
            p.setUserId(rs.getInt("user_id"));
            p.setUsername(rs.getString("username"));
            p.setStatus(rs.getString("status"));
            return p;
        }
    };

    public List<Participant> findParticipantsByTripId(int tripId) {
        String sql = "SELECT p.*, u.username FROM trip_participants p JOIN users u ON p.user_id = u.id WHERE p.trip_id = ?";
        return jdbcTemplate.query(sql, participantRowMapper, tripId);
    }

    public void addParticipant(int tripId, int userId, String status) {
        String sql = "INSERT INTO trip_participants (trip_id, user_id, status) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, tripId, userId, status);
    }

    public void updateStatus(int tripId, int userId, String status) {
        String sql = "UPDATE trip_participants SET status = ? WHERE trip_id = ? AND user_id = ?";
        jdbcTemplate.update(sql, status, tripId, userId);
    }
    
    public boolean isParticipant(int tripId, int userId) {
        String sql = "SELECT count(*) FROM trip_participants WHERE trip_id = ? AND user_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tripId, userId);
        return count != null && count > 0;
    }
}
