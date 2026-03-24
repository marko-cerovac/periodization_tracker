package org.unibl.etf.dao;

import org.unibl.etf.model.RepetitionType;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;

public class RepetitionTypeDAO extends GenericDAO<RepetitionType> {

    @Override
    public String getTableName() {
        return "repetition_types";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "repetition_type_id";
    }

    @Override
    public RepetitionType mapRow(ResultSet rs) throws SQLException {
        return new RepetitionType(
                rs.getInt("repetition_type_id"),
                rs.getString("name"));
    }

    @Override
    public void create(RepetitionType repetitionType) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name) VALUES (?)";

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

    @Override
    public void update(RepetitionType repetitionType) throws SQLException {
        String query = "UPDATE " + getTableName() + " SET name = ? WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, repetitionType.getName());
            stmt.setInt(2, repetitionType.getRepetitionTypeId());
            stmt.executeUpdate();
        }
    }
}
