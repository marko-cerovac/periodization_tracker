package org.unibl.etf.dao;

import org.unibl.etf.model.RepetitionType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.Optional;
import java.util.List;
import java.util.ArrayList;

public class RepetitionTypeDAO {
    public void create(RepetitionType repetitionType) throws SQLException {
        String query = "INSERT INTO repetition_types (name) VALUES (?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, repetitionType.getName());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    repetitionType.setRepetitionTypeId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public Optional<RepetitionType> findById(int repetitionTypeId) throws SQLException {
        String query = "SELECT repetition_type_id, name FROM repetition_types WHERE repetition_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, repetitionTypeId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToRepetitionType(rs));
                }
            }
        }

        return Optional.empty();
    }

    public List<RepetitionType> findAll() throws SQLException {
        String query = "SELECT repetition_type_id, name FROM repetition_types";
        List<RepetitionType> repetitionTypes = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                repetitionTypes.add(mapResultSetToRepetitionType(rs));
            }
        }

        return repetitionTypes;
    }

    public void update(RepetitionType repetitionType) throws SQLException {
        String query = "UPDATE repetition_types SET name = ? WHERE repetition_type_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, repetitionType.getName());
            stmt.setInt(2, repetitionType.getRepetitionTypeId());
            stmt.executeUpdate();
        }
    }

    private RepetitionType mapResultSetToRepetitionType(ResultSet rs) throws SQLException {
        return new RepetitionType(
                rs.getInt("repetition_type_id"),
                rs.getString("name"));
    }
}
