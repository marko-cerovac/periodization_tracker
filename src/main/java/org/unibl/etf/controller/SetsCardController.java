package org.unibl.etf.controller;

import org.unibl.etf.dao.ExerciseTypeDAO;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.ExerciseType;
import org.unibl.etf.model.Set;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

/**
 * SetsCardController
 */
public class SetsCardController {
    @FXML
    private VBox exerciseCard;

    @FXML
    private Label exerciseNameLabel;

    @FXML
    private Label exerciseDescriptionLabel;

    @FXML
    private Label exerciseTypeLabel;

    @FXML
    private GridPane setGrid;

    public void setExerciseAndSets(Exercise exercise, List<Set> sets) {
        exerciseNameLabel.setText("Exercise: " + exercise.getName());
        exerciseDescriptionLabel.setText("Description: " + exercise.getDescription());

        try {
            Optional<ExerciseType> exerciseType = new ExerciseTypeDAO().findById(exercise.getExerciseTypeId());

            exerciseType.ifPresentOrElse(
                    val -> exerciseTypeLabel.setText("Exercise type: " + val.getName()),
                    () -> exerciseTypeLabel.setText("Exercise type: None"));
        } catch (SQLException e) {
            System.err.println("Couldn't fetch exercise type for the given exercise: " + e);
        }

        int row = 1;

        setGrid.add(new Label("Reps"), 0, 0);
        setGrid.add(new Label("Rest"), 1, 0);
        setGrid.add(new Label("Weight"), 2, 0);
        setGrid.add(new Label("RPE"), 3, 0);
        setGrid.add(new Label("Exercise Block"), 4, 0);

        for (var set : sets) {
            Label repsLabel = new Label(set.getNumberOfRepetitions() != null ? set.getNumberOfRepetitions().toString() : "");
            Label restLabel = new Label(set.getRestDuration() != null ? set.getRestDuration().toString() : "");
            Label weightLabel = new Label(set.getWeight() != null ? set.getWeight().toString() : "");
            Label rpeLabel = new Label(set.getRpe() != null ? set.getRpe().toString() : "");
            Label exerciseBlockLabel = new Label(set.getBlock() != null ? set.getBlock().toString() : "");

            setGrid.add(repsLabel, 0, row);
            setGrid.add(restLabel, 1, row);
            setGrid.add(weightLabel, 2, row);
            setGrid.add(rpeLabel, 3, row);
            setGrid.add(exerciseBlockLabel, 4, row);

            row++;
        }
    }

    public VBox getExerciseCard() {
        return exerciseCard;
    }
}
