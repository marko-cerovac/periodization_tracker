package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.Gender;
import org.unibl.etf.model.User;
import org.unibl.etf.model.TrainingPlan;

import java.sql.*;
import java.util.List;
import java.util.Optional;
import java.util.ArrayList;

public class UserDAO extends GenericDAO<User> {
    private static TrainingPlanDAO trainingPlanDAO = new TrainingPlanDAO();

    @Override
    public String getTableName() {
        return "users";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "user_id";
    }

    @Override
    public User mapRow(ResultSet rs) throws SQLException {
        String genderStr = rs.getString("gender");
        Gender gender = null;
        if (genderStr != null) {
            gender = Gender.valueOf(genderStr);
        }

        User user = new User(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("username"),
                null,
                gender);
        user.setPasswordHash(rs.getString("password"));
        return user;
    }

    @Override
    public void create(User user) throws SQLException {
        String query = "INSERT INTO users " +
                "(username, password, gender) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, user);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(User user) throws SQLException {
        String query = "UPDATE users " +
                "SET username = ?, password = ?, gender = ? " +
                "WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, user);
            stmt.setInt(4, user.getUserId());
            stmt.executeUpdate();
        }
    }

    public Optional<User> findByUsername(String username) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapRow(rs));

            } else {
                return Optional.empty();
            }
        }
    }

    public List<TrainingPlan> getTrainingPlans(User user) throws SQLException {
        String query = "SELECT * FROM training_plans WHERE user_id = ?";
        List<TrainingPlan> trainingPlans = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, user.getUserId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                trainingPlans.add(trainingPlanDAO.mapRow(rs));
            }
        }
        return trainingPlans;
    }

    private void fillStatement(PreparedStatement stmt, User user) throws SQLException {
        stmt.setString(1, user.getUsername());
        stmt.setString(2, user.getPassword());

        if (user.hasGender()) {
            stmt.setString(3, user.getGender().toString());
        } else {
            stmt.setNull(3, Types.VARCHAR);
        }
    }
}
