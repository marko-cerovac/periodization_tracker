package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.ExerciseType;
import org.unibl.etf.model.Target;
import org.unibl.etf.model.PPAspect;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class ExerciseDAO extends GenericDAO<Exercise> {
    private static TargetDAO targetDAO;
    private static ExerciseTypeDAO exerciseTypeDAO;
    private static PPAspectDAO ppAspectDAO;

    @Override
    public String getTableName() {
        return "exercises";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "exercise_id";
    }

    @Override
    public Exercise mapRow(ResultSet rs) throws SQLException {
        return new Exercise(
                rs.getInt("exercise_id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getInt("exercise_type_id"));
    }

    @Override
    public void create(Exercise exercise) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name, description, exercise_type_id) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, exercise.getName());
            if (exercise.hasDescription()) {
                stmt.setString(2, exercise.getDescription());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }
            stmt.setInt(3, exercise.getExerciseTypeId());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    exercise.setExerciseId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(Exercise exercise) throws SQLException {
        String query = "UPDATE " + getTableName()
                + " SET name = ?, description = ?, exercise_type_id = ?"
                + " WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, exercise.getName());

            if (exercise.hasDescription()) {
                stmt.setString(2, exercise.getDescription());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }
            stmt.setInt(3, exercise.getExerciseTypeId());
            stmt.setInt(4, exercise.getExerciseId());
            stmt.executeUpdate();
        }

    }

    public List<Target> getTargets(Exercise exercise) throws SQLException {
        String query = "SELECT t.target_id, t.name, t.lain_name, t.description, t.target_type_id " +
            "FROM exercise_hits_targets eht " +
            "JOIN targets t ON eht.target_id = t.target_id " +
            "WHERE eht.exercise_id = ?";

        List<Target> targets = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, exercise.getExerciseId());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                targets.add(targetDAO.mapRow(rs));
            }
        }
        return targets;
    }

    public List<PPAspect> getPPAspects(Exercise exercise) throws SQLException {
        String query = "SELECT ppa.pp_aspect_id, ppa.name FROM exercise_targets_pp_aspects etppa " +
                "JOIN pp_aspects ppa ON etppa.pp_aspect_id = ppa.pp_aspect_id " +
                "WHERE etppa.exercise_id = ?";
        List<PPAspect> ppAspects = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, exercise.getExerciseId());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ppAspects.add(ppAspectDAO.mapRow(rs));
            }
        }
        return ppAspects;
    }
}
