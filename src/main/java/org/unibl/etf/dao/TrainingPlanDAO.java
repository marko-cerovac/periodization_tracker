package org.unibl.etf.dao;

import org.unibl.etf.model.TrainingBlock;
import org.unibl.etf.model.TrainingPlan;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

/**
 * TrainingPlanDAO
 */
public class TrainingPlanDAO extends GenericDAO<TrainingPlan> {
    private static TrainingBlockDAO trainingBlockDAO = new TrainingBlockDAO();

    @Override
    public String getTableName() {
        return "training_plans";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "training_plan_id";
    }

    @Override
    public TrainingPlan mapRow(ResultSet rs) throws SQLException {
        return new TrainingPlan(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("name"),
                rs.getString("description"),
                rs.getInt("user_id"));
    }

    @Override
    public void create(TrainingPlan trainingPlan) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name, description, user_id) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, trainingPlan);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    trainingPlan.setTrainingPlanId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(TrainingPlan trainingPlan) throws SQLException {
        String query = "UPDATE " + getTableName() + " SET name = ?, description = ?, user_id = ? WHERE "
                + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, trainingPlan);
            stmt.setInt(4, trainingPlan.getTrainingPlanId());
            stmt.executeUpdate();
        }
    }

    public List<TrainingPlan> findByUserId(int userId) throws SQLException {
        String query = "SELECT * FROM training_plans WHERE user_id = ?";
        List<TrainingPlan> trainingPlans = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                trainingPlans.add(mapRow(rs));
            }
        }
        return trainingPlans;
    }

    public List<TrainingBlock> getTrainingBlocks(TrainingPlan trainingPlan) throws SQLException {
        String query = "SELECT tb.training_block_id, tb.name, tb.description, tb.duration, tb.user_id " +
                "FROM training_plan_has_training_blocks tphtb " +
                "JOIN training_blocks tb on tphtb.training_block_id = tb.training_block_id " +
                "WHERE tphtb.training_plan_id = ?";

        List<TrainingBlock> trainingBlocks = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, trainingPlan.getTrainingPlanId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                trainingBlocks.add(trainingBlockDAO.mapRow(rs));
            }
        }
        return trainingBlocks;
    }

    private void fillStatement(PreparedStatement stmt, TrainingPlan trainingPlan) throws SQLException {
        if (trainingPlan.getName() != null) {
            stmt.setString(1, trainingPlan.getName());
        } else {
            stmt.setNull(1, Types.VARCHAR);
        }

        if (trainingPlan.hasDescription()) {
            stmt.setString(2, trainingPlan.getDescription());
        } else {
            stmt.setNull(2, Types.VARCHAR);
        }

        stmt.setInt(3, trainingPlan.getUserId());
    }
}
