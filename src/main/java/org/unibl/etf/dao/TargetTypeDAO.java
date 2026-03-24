package org.unibl.etf.dao;

import org.unibl.etf.model.TargetType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;

public class TargetTypeDAO extends GenericDAO<TargetType> {

    @Override
    public String getTableName() {
        return "target_types";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "target_type_id";
    }

    @Override
    public TargetType mapRow(ResultSet rs) throws SQLException {
        return new TargetType(
                rs.getInt("target_type_id"),
                rs.getString("name"));
    }

    @Override
    public void create(TargetType targetType) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name) VALUES (?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, targetType.getName());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    targetType.setTargetTypeId(generatedKeys.getInt(1));
                }
            }
        }
    }
    
    @Override
    public void update(TargetType targetType) throws SQLException {
        String query = "UPDATE " + getTableName() +" SET name = ? WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, targetType.getName());
            stmt.setInt(2, targetType.getTargetTypeId());
            stmt.executeUpdate();
        }
    }
}
