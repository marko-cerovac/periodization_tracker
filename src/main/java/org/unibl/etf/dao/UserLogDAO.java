package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.UserLog;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

/**
 * UserLogDAO
 */
public class UserLogDAO extends GenericDAO<UserLog> {

    @Override
    public String getTableName() {
        return "user_logs";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "user_log_id";
    }

    @Override
    public UserLog mapRow(ResultSet rs) throws SQLException {
        return new UserLog(
                rs.getInt("user_log_id"),
                rs.getObject("date", LocalDateTime.class),
                rs.getInt("age"),
                rs.getDouble("weight"),
                rs.getDouble("height"),
                rs.getDouble("bodyfat_percentage"),
                rs.getShort("satisfaction"),
                rs.getInt("user_id"));
    }

    @Override
    public void create(UserLog userLog) throws SQLException {
        String query = "INSERT INTO user_logs " +
                "(date, age, weight, height, bodyfat_percentage, satisfaction, user_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, userLog);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    userLog.setUserLogId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(UserLog userLog) throws SQLException {
        String query = "UPDATE user_logs " +
            "SET date = ?, age = ?, weight = ?, height = ?, bodyfat_percentage = ?, satisfaction = ?, user_id = ? " +
            "WHERE user_log_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, userLog);
            stmt.setInt(8, userLog.getUserLogId());
            stmt.executeUpdate();
        }
    }

    public List<UserLog> findByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM user_logs WHERE user_id = ?";
        List<UserLog> userLogs = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                userLogs.add(mapRow(rs));
            }
        }
        return userLogs;
    }

    private void fillStatement(PreparedStatement stmt, UserLog userLog) throws SQLException {
        stmt.setObject(1, userLog.getDate());

        if (userLog.hasAge()) {
            stmt.setInt(2, userLog.getAge());
        } else {
            stmt.setNull(2, Types.INTEGER);
        }

        if (userLog.hasWeight()) {
            stmt.setDouble(3, userLog.getWeight());
        } else {
            stmt.setNull(3, Types.DOUBLE);
        }

        if (userLog.hasHeight()) {
            stmt.setDouble(4, userLog.getHeight());
        } else {
            stmt.setNull(4, Types.DOUBLE);
        }

        if (userLog.hasBodyfatPercentage()) {
            stmt.setDouble(5, userLog.getBodyfatPercentage());
        } else {
            stmt.setNull(5, Types.DOUBLE);
        }

        if (userLog.hasSatisfaction()) {
            stmt.setInt(6, userLog.getSatisfaction());
        } else {
            stmt.setNull(6, Types.TINYINT);
        }

        stmt.setInt(7, userLog.getUserId());
    }
}
