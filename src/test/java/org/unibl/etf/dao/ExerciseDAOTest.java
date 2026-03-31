package org.unibl.etf.dao;

import org.junit.jupiter.api.*;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.ExerciseType;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class ExerciseDAOTest {
    private static ExerciseDAO exerciseDAO;
    private static ExerciseTypeDAO exerciseTypeDAO;
    private static int testExerciseId;
    private static int testExerciseTypeId;

    @BeforeAll
    static void setUp() throws SQLException {
        exerciseDAO = new ExerciseDAO();
        exerciseTypeDAO = new ExerciseTypeDAO();
        
        ExerciseType exerciseType = new ExerciseType(0, "Strength");
        exerciseTypeDAO.create(exerciseType);
        testExerciseTypeId = exerciseType.getExerciseTypeId();
    }

    @Test
    @Order(1)
    @DisplayName("Create exercise - should insert and return exercise with generated ID")
    void create_shouldInsertAndReturnExerciseWithGeneratedId() throws SQLException {
        Exercise exercise = new Exercise(0, "Flying Kung-Fu Jackal Pose", "Chest exercise with barbell", testExerciseTypeId);

        exerciseDAO.create(exercise);

        assertTrue(exercise.getExerciseId() > 0, "Exercise ID should be generated");
        testExerciseId = exercise.getExerciseId();
    }

    @Test
    @Order(2)
    @DisplayName("Find by ID - should return exercise when exists")
    void findById_existingExercise_shouldReturnExercise() throws SQLException {
        Optional<Exercise> result = exerciseDAO.findById(testExerciseId);

        assertTrue(result.isPresent());
        Exercise exercise = result.get();
        assertEquals("Flying Kung-Fu Jackal Pose", exercise.getName());
        assertEquals("Chest exercise with barbell", exercise.getDescription());
        assertEquals(testExerciseTypeId, exercise.getExerciseTypeId());
    }

    @Test
    @Order(3)
    @DisplayName("Find by ID - should return empty when not exists")
    void findById_nonExistingExercise_shouldReturnEmpty() throws SQLException {
        Optional<Exercise> result = exerciseDAO.findById(999999);

        assertTrue(result.isEmpty());
    }

    @Test
    @Order(4)
    @DisplayName("Update exercise - should modify existing exercise")
    void update_shouldModifyExistingExercise() throws SQLException {
        Exercise exercise = exerciseDAO.findById(testExerciseId).orElseThrow();
        exercise.setName("Updated Flying Kung-Fu Jackal Pose");
        exercise.setDescription("Updated description");

        exerciseDAO.update(exercise);

        Exercise updated = exerciseDAO.findById(testExerciseId).orElseThrow();
        assertEquals("Updated Flying Kung-Fu Jackal Pose", updated.getName());
        assertEquals("Updated description", updated.getDescription());
    }

    @Test
    @Order(5)
    @DisplayName("Find all - should return all exercises")
    void findAll_shouldReturnAllExercises() throws SQLException {
        List<Exercise> exercises = exerciseDAO.findAll();

        assertNotNull(exercises);
        assertTrue(exercises.size() > 0);
    }

    @Test
    @Order(6)
    @DisplayName("Get exercise type - should return associated exercise type")
    void getExerciseType_shouldReturnAssociatedExerciseType() throws SQLException {
        Exercise exercise = exerciseDAO.findById(testExerciseId).orElseThrow();

        Optional<ExerciseType> result = exerciseDAO.getExerciseType(exercise);

        assertTrue(result.isPresent());
        assertEquals("Strength", result.get().getName());
    }

    @Test
    @Order(7)
    @DisplayName("Delete exercise - should remove exercise from database")
    void delete_shouldRemoveExercise() throws SQLException {
        exerciseDAO.delete(testExerciseId);

        Optional<Exercise> result = exerciseDAO.findById(testExerciseId);
        assertTrue(result.isEmpty());
    }

    @Test
    @Order(8)
    @DisplayName("Create exercise with null description - should handle null correctly")
    void create_withNullDescription_shouldHandleNull() throws SQLException {
        Exercise exercise = new Exercise(0, "Chinese One-Finger Push Up", null, testExerciseTypeId);

        exerciseDAO.create(exercise);

        int createdId = exercise.getExerciseId();
        Exercise result = exerciseDAO.findById(createdId).orElseThrow();
        assertEquals("Chinese One-Finger Push Up", result.getName());
        assertFalse(result.hasDescription());

        exerciseDAO.delete(createdId);
    }

    @AfterAll
    static void tearDown() throws SQLException {
        if (testExerciseTypeId > 0) {
            exerciseTypeDAO.delete(testExerciseTypeId);
        }
    }
}
