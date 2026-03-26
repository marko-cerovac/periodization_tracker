package org.unibl.etf.dao;

import org.unibl.etf.model.PPAspect;
import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;

public class PPAspectDAO extends GenericDAO<PPAspect> {

    @Override
    public String getTableName() {
        return "pp_aspects";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "pp_aspect_id";
    }

    @Override
    public PPAspect mapRow(ResultSet rs) throws SQLException {
        return new PPAspect(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("name"));
    }

    @Override
    public void create(PPAspect ppAspect) throws SQLException {
        String query = "INSERT INTO " + getTableName() + " (name) VALUES (?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, ppAspect.getName());
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    ppAspect.setPPAspectId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(PPAspect ppAspect) throws SQLException {
        String query = "UPDATE " + getTableName() + " SET name = ? WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, ppAspect.getName());
            stmt.setInt(2, ppAspect.getPPAspectId());
            stmt.executeUpdate();
        }
    }
}
