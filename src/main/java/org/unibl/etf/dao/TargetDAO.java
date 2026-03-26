package org.unibl.etf.dao;

import java.sql.*;

import org.unibl.etf.model.Target;
import org.unibl.etf.util.DatabaseConnection;

// ExerciseType.java
// RepetitionType.java
// TargetType.java
//
// Target.java
//
// TrainingBlock.java
// TrainingPlan.java
// User.java

public class TargetDAO extends GenericDAO<Target> {

    @Override
    public String getTableName() {
        return "targets";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "target_id";
    }

    @Override
    public Target mapRow(ResultSet rs) throws SQLException {
        return new Target(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("name"),
                rs.getObject("latin_name", String.class),
                rs.getObject("description", String.class),
                rs.getInt("target_type_id"));
    }

    @Override
    public void create(Target target) throws SQLException {
        String query = "INSERT INTO "
                + getTableName()
                + " (name, latin_name, description, target) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, target.getName());

            if (target.hasLatinName()) {
                stmt.setString(2, target.getLatinName());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }

            if (target.hasDescription()) {
                stmt.setString(3, target.getDescription());
            } else {
                stmt.setNull(3, Types.VARCHAR);
            }
            stmt.setInt(4, target.getTargetTypeId());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    target.setTargetId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(Target target) throws SQLException {
        String query = "UPDATE " + getTableName()
                + " SET name = ?, latin_name = ?, description = ?, target_type_id = ? WHERE "
                + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, target.getName());

            if (target.getLatinName() != null) {
                stmt.setString(2, target.getLatinName());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }

            if (target.getDescription() != null) {
                stmt.setString(3, target.getDescription());
            } else {
                stmt.setNull(3, Types.VARCHAR);
            }
            stmt.setInt(4, target.getTargetTypeId());
            stmt.setInt(5, target.getTargetId());
            stmt.executeUpdate();
        }
    }
}
