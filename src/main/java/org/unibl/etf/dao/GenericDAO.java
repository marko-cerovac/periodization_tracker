package org.unibl.etf.dao;

import org.unibl.etf.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Generic base class for DAO implementations.
 *
 * <p>Provides default implementations for {@link #findById}, {@link #findAll},
 * and {@link #delete}, which follow the same pattern for every entity.
 * Subclasses must implement {@link #create} and {@link #update} since those
 * require entity-specific column mappings.</p>
 *
 * @param <T> the entity type this DAO manages
 */
abstract class GenericDAO<T> {

    /**
     * @return the database table name (e.g. {@code "target_types"})
     */
    protected abstract String getTableName();

    /**
     * @return the primary key column name (e.g. {@code "target_type_id"})
     */
    protected abstract String getPrimaryKeyColumn();

    /**
     * Maps the current row of the given ResultSet to an entity object.
     * The cursor is already positioned on the row — do not call {@code next()}.
     *
     * @param rs the ResultSet positioned on the current row
     * @return the mapped entity
     * @throws SQLException if a column cannot be read
     */
    protected abstract T mapRow(ResultSet rs) throws SQLException;

    /**
     * Inserts a new entity into the database and populates its generated ID.
     *
     * @param entity the entity to insert
     * @throws SQLException if a database access error occurs
     */
    public abstract void create(T entity) throws SQLException;

    /**
     * Updates an existing entity in the database.
     *
     * @param entity the entity to update, identified by its ID field
     * @throws SQLException if a database access error occurs
     */
    public abstract void update(T entity) throws SQLException;

    /**
     * Fetches a single entity by its primary key.
     *
     * @param id the primary key value
     * @return an {@link Optional} containing the entity, or empty if not found
     * @throws SQLException if a database access error occurs
     */
    public Optional<T> findById(int id) throws SQLException {
        String query = "SELECT * FROM " + getTableName() + " WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
        }

        return Optional.empty();
    }

    /**
     * Fetches all entities from the table.
     *
     * @return a list of all entities, or an empty list if the table is empty
     * @throws SQLException if a database access error occurs
     */
    public List<T> findAll() throws SQLException {
        String query = "SELECT * FROM " + getTableName();
        List<T> results = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                results.add(mapRow(rs));
            }
        }

        return results;
    }

    /**
     * Deletes an entity by its primary key.
     *
     * @param id the primary key value of the entity to delete
     * @throws SQLException if a database access error occurs
     */
    public void delete(int id) throws SQLException {
        String query = "DELETE FROM " + getTableName() + " WHERE " + getPrimaryKeyColumn() + " = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
