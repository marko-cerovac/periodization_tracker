package org.unibl.etf.dao;

import org.unibl.etf.model.TrainingBlock;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;

/**
 * TrainingBlockDAO
 */
public class TrainingBlockDAO extends GenericDAO<TrainingBlock> {

    @Override
    public String getTableName() {
        return "training_blocks";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "training_block_id";
    }

    @Override
    public TrainingBlock mapRow(ResultSet rs) throws SQLException {
        return new TrainingBlock(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("name"),
                rs.getString("description"),
                rs.getInt("duration"),
                rs.getInt("user_id"));
    }

    @Override
    public void create(TrainingBlock trainingBlock) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name, description, duration, user_id) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            if (trainingBlock.hasName()) {
                stmt.setString(1, trainingBlock.getName());
            } else {
                stmt.setNull(1, Types.VARCHAR);
            }

            if (trainingBlock.hasDescription()) {
                stmt.setString(2, trainingBlock.getDescription());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }

            if (trainingBlock.hasDuration()) {
                stmt.setInt(3, trainingBlock.getDuration());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setInt(4, trainingBlock.getUserId());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    trainingBlock.setTrainingBlockId(generatedKeys.getInt(1));
                }
            }
            
        }
    }

    @Override
    public void update(TrainingBlock trainingBlock) throws SQLException {
        String query = "UPDATE " + getTableName() + " SET name = ?, description = ?, duration = ?, user_id = ? WHERE "
                + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            if (trainingBlock.hasName()) {
                stmt.setString(1, trainingBlock.getName());
            } else {
                stmt.setNull(1, Types.VARCHAR);
            }

            if (trainingBlock.hasDescription()) {
                stmt.setString(2, trainingBlock.getDescription());
            } else {
                stmt.setNull(2, Types.VARCHAR);
            }

            if (trainingBlock.hasDuration()) {
                stmt.setInt(3, trainingBlock.getDuration());
            } else {
                stmt.setNull(3, Types.INTEGER);
            }

            stmt.setInt(4, trainingBlock.getUserId());
            stmt.setInt(5, trainingBlock.getTrainingBlockId());
            stmt.executeUpdate();
        }
    }

}
