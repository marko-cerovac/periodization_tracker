package org.unibl.etf.dao;

import org.unibl.etf.model.Set;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.Optional;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.LinkedHashMap;

public class SetDAO extends GenericDAO<Set> {
    private static ExerciseDAO exerciseDAO = new ExerciseDAO();

    @Override
    public String getTableName() {
        return "sets";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "set_id";
    }

    @Override
    public Set mapRow(ResultSet rs) throws SQLException {
        return new Set(
                rs.getInt("set_id"),
                rs.getInt("number_of_repetitions"),
                rs.getInt("rest_duration"),
                rs.getDouble("weight"),
                rs.getInt("rpe"),
                rs.getShort("block"),
                rs.getBoolean("is_done"),
                rs.getInt("exercise_id"),
                rs.getInt("repetition_type_id"),
                rs.getInt("session_id"));
    }

    @Override
    public void create(Set set) throws SQLException {
        String query = "INSERT INTO sets " +
                "(number_of_repetitions, rest_duration, weight, rpe, block, is_done, exercise_id, repetition_type_id, session_id) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            fillStatement(stmt, set);

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    set.setSetId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(Set set) throws SQLException {
        String query = "UPDATE sets SET " +
                "number_of_repetitions = ?, rest_duration = ?, weight = ?, rpe = ?, " +
                "block = ?, is_done = ?, exercise_id = ? repetition_type_id = ?, session_id = ?" +
                " WHERE set_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, set);
            stmt.setInt(10, set.getSetId());
        }
    }

    public Optional<Exercise> getExercise(Set set) throws SQLException {
        return exerciseDAO.findById(set.getExerciseId());
    }

    public Map<Exercise, List<Set>> getSetsAndExercisesPerSession(int session_id) throws SQLException {
        String query = "SELECT e.name, e.description, " +
                "e.exercise_type_id, s.repetition_type_id, s.session_id, " +
                "s.number_of_repetitions, s.rest_duration, s.weight, " +
                "s.set_id, s.rpe, s.block, e.exercise_id " +
                "FROM exercises e " +
                "LEFT JOIN sets s ON e.exercise_id = s.exercise_id " +
                "WHERE s.session_id = ?";

        Map<Exercise, List<Set>> sets = new LinkedHashMap<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, session_id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Exercise exercise = new Exercise(
                        rs.getInt("exercise_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getInt("exercise_type_id"));

                Set set = new Set(
                        rs.getInt("set_id"),
                        rs.getObject("number_of_repetitions", Integer.class),
                        rs.getObject("rest_duration", Integer.class),
                        rs.getObject("weight", Double.class),
                        rs.getObject("rpe", Integer.class),
                        rs.getObject("block", Short.class),
                        false,
                        rs.getInt("exercise_id"),
                        rs.getInt("repetition_type_id"),
                        rs.getInt("session_id"));

                sets.computeIfAbsent(exercise, k -> new ArrayList<>()).add(set);
            }
        }
        return sets;
    }

    public List<Set> findBySessionId(int sessionId) throws SQLException {
        String query = "SELECT * FROM sets WHERE session_id = ?";
        List<Set> sets = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, sessionId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                sets.add(mapRow(rs));
            }
        }
        return sets;
    }

    private void fillStatement(PreparedStatement stmt, Set set) throws SQLException {
        if (set.hasNumberOfRepetitions()) {
            stmt.setInt(1, set.getNumberOfRepetitions());
        } else {
            stmt.setNull(1, Types.INTEGER);
        }

        if (set.hasRestDuration()) {
            stmt.setInt(2, set.getRestDuration());
        } else {
            stmt.setNull(2, Types.INTEGER);
        }

        if (set.hasWeight()) {
            stmt.setDouble(3, set.getWeight());
        } else {
            stmt.setNull(3, Types.DOUBLE);
        }

        if (set.hasRpe()) {
            stmt.setInt(4, set.getRpe());
        } else {
            stmt.setNull(4, Types.INTEGER);
        }

        if (set.hasBlock()) {
            stmt.setShort(5, set.getBlock());
        } else {
            stmt.setNull(5, Types.TINYINT);
        }

        stmt.setBoolean(6, set.getIsDone());
        stmt.setInt(7, set.getExerciseId());
        stmt.setInt(8, set.getRepetitionTypeId());
        stmt.setInt(9, set.getSessionId());
        stmt.executeUpdate();
    }
}
