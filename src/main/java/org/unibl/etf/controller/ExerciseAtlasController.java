package org.unibl.etf.controller;

import org.unibl.etf.dao.ExerciseDAO;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.Target;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.layout.FlowPane;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
            Map<Exercise, ArrayList<Target>> exercisesWithTargets = new ExerciseDAO().getExercisesWithTargets();

            for (var entry : exercisesWithTargets.entrySet()) {
                Exercise exercise = entry.getKey();
                ArrayList<Target> targets = entry.getValue();
                
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/exercise_card.fxml"));
                Node card = loader.load();
                ExerciseCardController cardController = loader.getController();

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
