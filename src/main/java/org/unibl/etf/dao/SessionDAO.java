package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.Session;
import org.unibl.etf.model.PPAspect;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class SessionDAO extends GenericDAO<Session> {
    private static PPAspectDAO ppAspectDAO = new PPAspectDAO();

    @Override
    public String getTableName() {
        return "sessions";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "session_id";
    }

    @Override
    public Session mapRow(ResultSet rs) throws SQLException {
        return new Session(
                rs.getInt("session_id"),
                rs.getString("name"),
                rs.getString("description"));
    }

    @Override
    public void create(Session session) throws SQLException {
        String query = "INSERT INTO sessions " +
                "(name, description) VALUES (?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, session);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    session.setSessionId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(Session session) throws SQLException {
        String query = "UPDATE session " +
                "SET name = ?, description = ? "
                + "WHERE session_id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, session);
            stmt.setInt(3, session.getSessionId());
            stmt.executeUpdate();
        }
    }

    public List<PPAspect> getPPAspects(Session session) throws SQLException {
        String query = "SELECT ppa.pp_aspect_id, ppa.name" +
                "FROM session_targets_pp_aspects stppa" +
                "JOIN pp_aspects ppa on stppa.pp_aspect_id = ppa.pp_aspect_id" +
                "WHERE stppa.session_id = ?";
        List<PPAspect> ppAspects = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, session.getSessionId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ppAspects.add(ppAspectDAO.mapRow(rs));
            }
        }
        return ppAspects;
    }

    private void fillStatement(PreparedStatement stmt, Session session) throws SQLException {
        stmt.setString(1, session.getName());
        if (session.hasDescription()) {
            stmt.setString(2, session.getDescription());
        } else {
            stmt.setNull(2, Types.VARCHAR);
        }
    }
}
