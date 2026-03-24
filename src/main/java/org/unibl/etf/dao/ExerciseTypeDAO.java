package org.unibl.etf.dao;

import org.unibl.etf.model.ExerciseType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;

public class ExerciseTypeDAO extends GenericDAO<ExerciseType> {

    @Override
    public String getTableName() {
        return "exercise_types";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "exercise_type_id";
    }

    @Override
    public ExerciseType mapRow(ResultSet rs) throws SQLException {
        return new ExerciseType(
                rs.getInt("exercise_type_id"),
                rs.getString("name"));
    }

    @Override
    public void create(ExerciseType exerciseType) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name) VALUES (?)";

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

    @Override
    public void update(ExerciseType exerciseType) throws SQLException {
        String query = "UPDATE " + getTableName() + " SET name = ? WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, exerciseType.getName());
            stmt.setInt(2, exerciseType.getExerciseTypeId());
            stmt.executeUpdate();
        }
    }
}
