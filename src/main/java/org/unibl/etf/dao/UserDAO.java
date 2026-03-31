package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;
import org.unibl.etf.model.Gender;
import org.unibl.etf.model.User;

import java.sql.*;

class UserDAO extends GenericDAO<User> {
    @Override
    public String getTableName() {
        return "users";
    }

    @Override
    public String getPrimaryKeyColumn() {
        return "user_id";
    }

    @Override
    public User mapRow(ResultSet rs) throws SQLException {
        String genderStr = rs.getString("gender");
        Gender gender = null;
        if (genderStr != null) {
            gender = Gender.valueOf(genderStr);
        }

        return new User(
                rs.getInt(getPrimaryKeyColumn()),
                rs.getString("username"),
                rs.getObject("age", Integer.class),
                gender,
                rs.getObject("weight", Double.class),
                rs.getObject("height", Double.class));
    }

    @Override
    public void create(User user) throws SQLException {
        String query = "INSERT INTO " + getTableName()
                + " (username, age, gender, weight, height) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            fillStatement(stmt, user);
            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
            }
        }
    }

    @Override
    public void update(User user) throws SQLException {
        String query = "UPDATE " + getTableName()
                + " SET username = ?, age = ?, gender = ?, weight = ?, height = ? WHERE " + getPrimaryKeyColumn()
                + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(query)) {
            fillStatement(stmt, user);
            stmt.setInt(6, user.getUserId());
            stmt.executeUpdate();
        }
    }

    private void fillStatement(PreparedStatement stmt, User user) throws SQLException {
        stmt.setString(1, user.getUsername());

        if (user.hasAge()) {
            stmt.setInt(2, user.getAge());
        } else {
            stmt.setNull(2, Types.INTEGER);
        }
        if (user.hasGender()) {
            stmt.setString(3, user.getGender().toString());
        } else {
            stmt.setNull(3, Types.VARCHAR);
        }

        if (user.hasWeight()) {
            stmt.setDouble(4, user.getWeight());
        } else {
            stmt.setNull(4, Types.DOUBLE);
        }

        if (user.hasHeight()) {
            stmt.setDouble(5, user.getHeight());
        } else {
            stmt.setNull(5, Types.DOUBLE);
        }
    }
}
