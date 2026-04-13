package org.unibl.etf.controller;

import org.unibl.etf.dao.ExerciseDAO;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.Target;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.layout.FlowPane;

import java.util.List;
import java.io.IOException;
import java.sql.SQLException;

/**
 * ExerciseAtlasController
 */
public class ExerciseAtlasController {

    @FXML
    private FlowPane exerciseGrid;

    public void loadExercises() {
        try {
            List<Exercise> exercises = new ExerciseDAO().findAll();

            for (var exercise : exercises) {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/exercise_card.fxml"));
                Node card = loader.load();
                ExerciseCardController cardController = loader.getController();

                // get targets for this exercise
                List<Target> targets = new ExerciseDAO().getTargets(exercise);
                cardController.setExercise(exercise, targets);

                exerciseGrid.getChildren().add(card);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load exercises: " + e);
        } catch (IOException e) {
            System.err.println("Failed to load exercise atlas view: " + e);
            e.printStackTrace();
        }
    }
}
