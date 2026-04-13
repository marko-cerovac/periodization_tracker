package org.unibl.etf.controller;

import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.Target;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;

import java.util.List;

public class ExerciseCardController {

    @FXML
    private VBox exerciseCard;

    @FXML
    private Label exerciseName;

    @FXML
    private Label descriptionLabel;

    @FXML
    private Label targetsLabel;

    public void setExercise(Exercise exercise, List<Target> targets) {
        if (exercise == null) {
            return;
        }

        StringBuilder targetsList = new StringBuilder();
        for (var target : targets) {
            targetsList.append(target.getName() + " (" + target.getLatinName() + "), ");
        }
        
        // Only remove the trailing ", " if there are targets
        if (targetsList.length() > 0) {
            targetsList.delete(targetsList.lastIndexOf(", "), targetsList.length());
        }

        exerciseName.setText(exercise.getName());
        descriptionLabel.setText(exercise.hasDescription() ? exercise.getDescription() : "Missing description");
        targetsLabel.setText("Targets: " + (targetsList.length() > 0 ? targetsList.toString() : "No targets"));
    }

    public VBox getCardView() {
        return exerciseCard;
    }
}
