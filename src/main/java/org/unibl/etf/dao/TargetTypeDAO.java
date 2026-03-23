package org.unibl.etf.dao;

import org.unibl.etf.model.TargetType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TargetTypeDAO {

    public void create(TargetType targetType) throws SQLException {
        String query = "INSERT INTO target_types (name) VALUES (?)";

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

    public Optional<TargetType> findById(int targetTypeId) throws SQLException {
        String query = "SELECT target_type_id, name FROM target_types WHERE target_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, targetTypeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToTargetType(rs));
                }
            }
        }

        return Optional.empty();
    }

    public List<TargetType> findAll() throws SQLException {
        String query = "SELECT target_type_id, name FROM target_types";
        List<TargetType> targetTypes = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                targetTypes.add(mapResultSetToTargetType(rs));
            }
        }

        return targetTypes;
    }

    public void update(TargetType targetType) throws SQLException {
        String query = "UPDATE target_types SET name = ? WHERE target_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, targetType.getName());
            stmt.setInt(2, targetType.getTargetTypeId());
            stmt.executeUpdate();
        }
    }

    public void delete(int targetTypeId) throws SQLException {
        String query = "DELETE FROM target_types WHERE target_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, targetTypeId);
            stmt.executeUpdate();
        }
    }

    private TargetType mapResultSetToTargetType(ResultSet rs) throws SQLException {
        return new TargetType(
                rs.getInt("target_type_id"),
                rs.getString("name"));
    }
}
