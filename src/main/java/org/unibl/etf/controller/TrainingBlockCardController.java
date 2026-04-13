package org.unibl.etf.controller;

import java.io.IOException;

import org.unibl.etf.model.TrainingBlock;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;

/**
 * TrainingBlockCardController
 */
public class TrainingBlockCardController {
    private TrainingBlock trainingBlock;
    private MainViewController mainController;

    @FXML
    private VBox trainingBlockCard;

    @FXML
    private Label blockNameLabel;

    @FXML
    private Label blockDescriptionLabel;

    @FXML
    private Label blockDurationLabel;

    public void setMainController(MainViewController mainController) {
        this.mainController = mainController;
    }

    public void setTrainingBlock(TrainingBlock trainingBlock) {
        if (trainingBlock == null) {
            return;
        }

        this.trainingBlock = trainingBlock;
        blockNameLabel.setText(trainingBlock.getName());
        blockDescriptionLabel.setText(trainingBlock.getDescription());

        StringBuilder duration = new StringBuilder();
        duration.append("Duration: ").append(trainingBlock.getDuration()).append(" days");

        blockDurationLabel.setText(duration.toString());
    }

    @FXML
    private void handleOpening() {
        AppState.getInstance().setCurrentBlock(this.trainingBlock);

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/sessions.fxml"));
            Parent view = loader.load();
        
            // TODO: finish the sessions view and set it here
        } catch (IOException e) {
            System.err.println("Error loading sessions view: " + e.getMessage());
        }

    }

    public VBox getCardView() {
        return trainingBlockCard;
    }
}
