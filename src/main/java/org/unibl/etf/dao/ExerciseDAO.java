package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.ExerciseType;
import org.unibl.etf.model.Target;
import org.unibl.etf.model.PPAspect;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;
import java.util.Map;
import java.util.LinkedHashMap;

public class ExerciseDAO extends GenericDAO<Exercise> {
    private static TargetDAO targetDAO = new TargetDAO();
    private static ExerciseTypeDAO exerciseTypeDAO = new ExerciseTypeDAO();
    private static PPAspectDAO ppAspectDAO = new PPAspectDAO();

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

            fillStatement(stmt, exercise);
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
            fillStatement(stmt, exercise);
            stmt.setInt(4, exercise.getExerciseId());
            stmt.executeUpdate();
        }

    }

    public Map<Exercise, ArrayList<Target>> getExercisesWithTargets() throws SQLException {
        String query = "SELECT e.*, t.target_id, t.name AS target_name, " +
                "t.latin_name AS target_latin_name, t.description AS target_description, t.target_type_id " +
                "FROM exercises e " +
                "LEFT JOIN exercise_hits_targets eht ON e.exercise_id = eht.exercise_id " +
                "LEFT JOIN targets t ON eht.target_id = t.target_id";

        Map<Exercise, ArrayList<Target>> exercises = new LinkedHashMap<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Create Exercise object from row data
                Exercise exercise = new Exercise(
                        rs.getInt("exercise_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("exercise_type_id")
                );

                // Check if target data exists (not NULL from LEFT JOIN)
                if (rs.getObject("target_name") != null) {
                    // Create Target object
                    Target target = new Target(
                            rs.getInt("target_id"),
                            rs.getString("target_name"),
                            rs.getString("target_latin_name"),
                            rs.getString("target_description"),
                            rs.getInt("target_type_id")
                    );

                    // Add target to exercises map
                    exercises.computeIfAbsent(exercise, k -> new ArrayList<>()).add(target);
                }
                // If no target data, ensure exercise is in map with empty list (if not already present)
                else {
                    exercises.putIfAbsent(exercise, new ArrayList<>());
                }
            }
        }

        return exercises;
    }

    // To improve the speed of targets fetching:
    // SELECT e.name, e.exercise_id, t.target_id, t.name AS target_name
    // FROM exercises e
    // LEFT JOIN exercise_hits_targets eht ON e.exercise_id = eht.exercise_id
    // LEFT JOIN targets t ON eht.target_id = t.target_id
    // WHERE e.exercise_id = 1
    // LIMIT 20;
    public List<Target> getTargets(Exercise exercise) throws SQLException {
        String query = "SELECT t.target_id, t.name, t.latin_name, t.description, t.target_type_id " +
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

    public Optional<ExerciseType> getExerciseType(Exercise exercise) throws SQLException {
        return exerciseTypeDAO.findById(exercise.getExerciseTypeId());
    }

    private void fillStatement(PreparedStatement stmt, Exercise exercise) throws SQLException {
        stmt.setString(1, exercise.getName());
        if (exercise.hasDescription()) {
            stmt.setString(2, exercise.getDescription());
        } else {
            stmt.setNull(2, Types.VARCHAR);
        }
        stmt.setInt(3, exercise.getExerciseTypeId());
    }
}
