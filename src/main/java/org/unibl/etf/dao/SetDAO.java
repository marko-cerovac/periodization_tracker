package org.unibl.etf.dao;

import org.unibl.etf.model.Set;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.Optional;

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
                rs.getInt("exercise_id"),
                rs.getInt("repetition_type_id"),
                rs.getInt("session_id"));
    }

    @Override
    public void create(Set set) throws SQLException {
        String query = "INSERT INTO sets " +
                "(number_of_repetitions, rest_duration, weight, rpe, block, exercise_id, repetition_type_id, session_id) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

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
                "block = ?, exercise_id = ? repetition_type_id = ?, session_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, set);
        }
    }

    public Optional<Exercise> getExercise(Set set) throws SQLException {
        return exerciseDAO.findById(set.getExerciseId());
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

        stmt.setInt(6, set.getExerciseId());
        stmt.setInt(7, set.getRepetitionTypeId());
        stmt.setInt(8, set.getSessionId());
        stmt.executeUpdate();
    }
}
