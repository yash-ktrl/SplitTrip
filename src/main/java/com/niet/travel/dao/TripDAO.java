package com.niet.travel.dao;

import com.niet.travel.model.Trip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@Repository
public class TripDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Trip> tripRowMapper = new RowMapper<Trip>() {
        @Override
        public Trip mapRow(ResultSet rs, int rowNum) throws SQLException {
            Trip trip = new Trip();
            trip.setId(rs.getInt("id"));
            trip.setCreatorId(rs.getInt("creator_id"));
            trip.setCreatorName(rs.getString("creator_name"));
            trip.setTitle(rs.getString("title"));
            trip.setTripType(rs.getString("trip_type"));
            trip.setDestination(rs.getString("destination"));
            trip.setOrigin(rs.getString("origin"));
            trip.setStartDate(rs.getDate("start_date"));
            trip.setEndDate(rs.getDate("end_date"));
            trip.setHotelDetails(rs.getString("hotel_details"));
            trip.setActivities(rs.getString("activities"));
            trip.setDescription(rs.getString("description"));
            trip.setStatus(rs.getString("status"));
            trip.setCreatedAt(rs.getTimestamp("created_at"));
            trip.setParticipantCount(rs.getInt("participant_count"));
            return trip;
        }
    };

    public List<Trip> findAllTrips() {
        String sql = "SELECT t.*, u.full_name AS creator_name, " +
                     "(SELECT COUNT(*) FROM trip_participants tp WHERE tp.trip_id = t.id AND tp.status = 'APPROVED') AS participant_count " +
                     "FROM trips t JOIN users u ON t.creator_id = u.id ORDER BY t.created_at DESC";
        return jdbcTemplate.query(sql, tripRowMapper);
    }

    public Trip findById(int id) {
        String sql = "SELECT t.*, u.full_name AS creator_name, " +
                     "(SELECT COUNT(*) FROM trip_participants tp WHERE tp.trip_id = t.id AND tp.status = 'APPROVED') AS participant_count " +
                     "FROM trips t JOIN users u ON t.creator_id = u.id WHERE t.id = ?";
        List<Trip> trips = jdbcTemplate.query(sql, tripRowMapper, id);
        return trips.isEmpty() ? null : trips.get(0);
    }

    public int saveTrip(Trip trip) {
        String sql = "INSERT INTO trips (creator_id, title, trip_type, destination, origin, start_date, end_date, hotel_details, activities, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, new String[]{"ID"});
            ps.setInt(1, trip.getCreatorId());
            ps.setString(2, trip.getTitle());
            ps.setString(3, trip.getTripType());
            ps.setString(4, trip.getDestination());
            ps.setString(5, trip.getOrigin());
            ps.setDate(6, trip.getStartDate());
            ps.setDate(7, trip.getEndDate());
            ps.setString(8, trip.getHotelDetails());
            ps.setString(9, trip.getActivities());
            ps.setString(10, trip.getDescription());
            return ps;
        }, keyHolder);
        return keyHolder.getKey().intValue();
    }
}
