package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.SessionLog;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

public class SessionLogDAO extends GenericDAO<SessionLog> {

    @Override
    public String getTableName() {
        return "session_logs";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "session_log_id";
    }

    @Override
    public SessionLog mapRow(ResultSet rs) throws SQLException {
        return new SessionLog(
                rs.getInt("session_log_id"),
                rs.getObject("date", LocalDateTime.class),
                rs.getShort("difficulty"),
                rs.getInt("session_id"),
                rs.getInt("user_id"));
    }

    @Override
    public void create(SessionLog sessionLog) throws SQLException {
        String query = "INSERT INTO session_logs (date, difficulty, session_id, user_id) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, sessionLog);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    sessionLog.setSessionLogId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(SessionLog sessionLog) throws SQLException {
        String query = "UPDATE session_logs " +
            "SET date = ?, difficulty = ?, session_id = ?, user_id = ? " +
            "WHERE session_log_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, sessionLog);
            stmt.setInt(5, sessionLog.getSessionLogId());
            stmt.executeUpdate();
        }
    }

    public List<SessionLog> findByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM session_logs WHERE user_id = ?";
        List<SessionLog> sessionLogs = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                sessionLogs.add(mapRow(rs));
            }
        }
        return sessionLogs;
    }

    private void fillStatement(PreparedStatement stmt, SessionLog sessionLog) throws SQLException {
        stmt.setObject(1, sessionLog.getDate());

        if (sessionLog.hasDifficulty()) {

            stmt.setShort(2, sessionLog.getDifficulty());
        } else {
            stmt.setNull(2, Types.TINYINT);
        }

        stmt.setInt(3, sessionLog.getSessionId());
        stmt.setInt(4, sessionLog.getUserId());
    }
}
