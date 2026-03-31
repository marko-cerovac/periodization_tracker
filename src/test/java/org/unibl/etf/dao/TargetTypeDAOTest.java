package org.unibl.etf.dao;

import org.junit.jupiter.api.*;
import org.unibl.etf.model.TargetType;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class TargetTypeDAOTest {
    private static TargetTypeDAO targetTypeDAO;
    private static int testTargetTypeId;

    @BeforeAll
    static void setUp() {
        targetTypeDAO = new TargetTypeDAO();
    }

    @Test
    @Order(1)
    @DisplayName("Create target type - should insert and return target type with generated ID")
    void create_shouldInsertAndReturnTargetTypeWithGeneratedId() throws SQLException {
        TargetType targetType = new TargetType(0, "Strength");

        targetTypeDAO.create(targetType);

        assertTrue(targetType.getTargetTypeId() > 0, "Target type ID should be generated");
        testTargetTypeId = targetType.getTargetTypeId();
    }

    @Test
    @Order(2)
    @DisplayName("Find by ID - should return target type when exists")
    void findById_existingTargetType_shouldReturnTargetType() throws SQLException {
        Optional<TargetType> result = targetTypeDAO.findById(testTargetTypeId);

        assertTrue(result.isPresent());
        TargetType targetType = result.get();
        assertEquals("Strength", targetType.getName());
    }

    @Test
    @Order(3)
    @DisplayName("Find by ID - should return empty when not exists")
    void findById_nonExistingTargetType_shouldReturnEmpty() throws SQLException {
        Optional<TargetType> result = targetTypeDAO.findById(999999);

        assertTrue(result.isEmpty());
    }

    @Test
    @Order(4)
    @DisplayName("Update target type - should modify existing target type")
    void update_shouldModifyExistingTargetType() throws SQLException {
        TargetType targetType = targetTypeDAO.findById(testTargetTypeId).orElseThrow();
        targetType.setName("UpdatedStrength");

        targetTypeDAO.update(targetType);

        TargetType updated = targetTypeDAO.findById(testTargetTypeId).orElseThrow();
        assertEquals("UpdatedStrength", updated.getName());
    }

    @Test
    @Order(5)
    @DisplayName("Find all - should return all target types")
    void findAll_shouldReturnAllTargetTypes() throws SQLException {
        List<TargetType> targetTypes = targetTypeDAO.findAll();

        assertNotNull(targetTypes);
        assertTrue(targetTypes.size() > 0);
    }

    @Test
    @Order(6)
    @DisplayName("Delete target type - should remove target type from database")
    void delete_shouldRemoveTargetType() throws SQLException {
        targetTypeDAO.delete(testTargetTypeId);

        Optional<TargetType> result = targetTypeDAO.findById(testTargetTypeId);
        assertTrue(result.isEmpty());
    }
}
