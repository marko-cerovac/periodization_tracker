package org.unibl.etf.dao;

import org.unibl.etf.model.ExerciseType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ExerciseTypeDAO {
    public void create(ExerciseType exerciseType) throws SQLException {
        String query = "INSERT INTO exercise_types (name) VALUES (?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, exerciseType.getName());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    exerciseType.setExerciseTypeId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public Optional<ExerciseType> findById(int exerciseTypeId) throws SQLException {
        String query = "SELECT exercise_type_id, name FROM exercise_types WHERE exercise_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, exerciseTypeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToExerciseType(rs));
                }
            }
        }

        return Optional.empty();
    }

    public List<ExerciseType> findAll() throws SQLException {
        String query = "SELECT exercise_type_id, name FROM exercise_types";
        List<ExerciseType> exerciseTypes = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                exerciseTypes.add(mapResultSetToExerciseType(rs));
            }
        }

        return exerciseTypes;
    }

    public void update(ExerciseType exerciseType) throws SQLException {
        String query = "UPDATE exercise_types SET name = ? WHERE exercise_type_id = ?";
        
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, exerciseType.getName());
            stmt.setInt(2, exerciseType.getExerciseTypeId());
            stmt.executeUpdate();
        }
    }

    private ExerciseType mapResultSetToExerciseType(ResultSet rs) throws SQLException {
        return new ExerciseType(
                rs.getInt("exercise_type_id"),
                rs.getString("name"));
    }
}
