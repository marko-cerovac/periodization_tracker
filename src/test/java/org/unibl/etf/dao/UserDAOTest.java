package org.unibl.etf.dao;

import org.junit.jupiter.api.*;
import org.unibl.etf.model.Gender;
import org.unibl.etf.model.User;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class UserDAOTest {
    private static UserDAO userDAO;
    private static int testUserId;

    @BeforeAll
    static void setUp() {
        userDAO = new UserDAO();
    }

    @Test
    @Order(1)
    @DisplayName("Create user - should insert and return user with generated ID")
    void create_shouldInsertAndReturnUserWithGeneratedId() throws SQLException {
        User user = new User(0, "testuser", 25, Gender.Male, 75.5, 180.0);

        userDAO.create(user);

        assertTrue(user.getUserId() > 0, "User ID should be generated");
        testUserId = user.getUserId();
    }

    @Test
    @Order(2)
    @DisplayName("Find by ID - should return user when exists")
    void findById_existingUser_shouldReturnUser() throws SQLException {
        Optional<User> result = userDAO.findById(testUserId);

        assertTrue(result.isPresent());
        User user = result.get();
        assertEquals("testuser", user.getUsername());
        assertEquals(25, user.getAge());
        assertEquals(Gender.Male, user.getGender());
        assertEquals(75.5, user.getWeight());
        assertEquals(180.0, user.getHeight());
    }

    @Test
    @Order(3)
    @DisplayName("Find by ID - should return empty when not exists")
    void findById_nonExistingUser_shouldReturnEmpty() throws SQLException {
        Optional<User> result = userDAO.findById(999999);

        assertTrue(result.isEmpty());
    }

    @Test
    @Order(4)
    @DisplayName("Update user - should modify existing user")
    void update_shouldModifyExistingUser() throws SQLException {
        User user = userDAO.findById(testUserId).orElseThrow();
        user.setUsername("updateduser");
        user.setAge(30);

        userDAO.update(user);

        User updated = userDAO.findById(testUserId).orElseThrow();
        assertEquals("updateduser", updated.getUsername());
        assertEquals(30, updated.getAge());
    }

    @Test
    @Order(5)
    @DisplayName("Find all - should return all users")
    void findAll_shouldReturnAllUsers() throws SQLException {
        List<User> users = userDAO.findAll();

        assertNotNull(users);
        assertTrue(users.size() > 0);
    }

    @Test
    @Order(6)
    @DisplayName("Delete user - should remove user from database")
    void delete_shouldRemoveUser() throws SQLException {
        userDAO.delete(testUserId);

        Optional<User> result = userDAO.findById(testUserId);
        assertTrue(result.isEmpty());
    }

    @Test
    @Order(7)
    @DisplayName("Find by ID - should return correct user data from database")
    void findById_existingUser_shouldReturnCorrectData() throws SQLException {
        Optional<User> result = userDAO.findById(1);

        assertTrue(result.isPresent());
        User user = result.get();
        assertEquals("anatoly_pisarenko", user.getUsername());
        assertEquals(28, user.getAge());
        assertEquals(Gender.Male, user.getGender());
        assertEquals(109.2, user.getWeight());
        assertEquals(181.1, user.getHeight());
    }

    @Test
    @Order(8)
    @DisplayName("Create user with nullable fields - should handle nulls correctly")
    void create_withNullableFields_shouldHandleNulls() throws SQLException {
        User user = new User(0, "nulluser", 0, null, null, null);

        userDAO.create(user);

        int createdId = user.getUserId();
        User result = userDAO.findById(createdId).orElseThrow();
        assertEquals("nulluser", result.getUsername());
        assertFalse(result.hasGender());
        assertFalse(result.hasWeight());
        assertFalse(result.hasHeight());

        userDAO.delete(createdId);
    }
}
