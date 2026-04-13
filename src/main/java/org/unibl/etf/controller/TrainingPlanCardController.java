package org.unibl.etf.controller;

import java.io.IOException;

import org.unibl.etf.model.TrainingPlan;
// import org.unibl.etf.util.AppState;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.VBox;
import javafx.scene.Parent;
import javafx.scene.control.Label;

/**
 * TraininPlanCardController
 */
public class TrainingPlanCardController {
    private TrainingPlan trainingPlan;
    private MainViewController mainController;

    @FXML
    private VBox trainingPlanCard;

    @FXML
    private Label planNameLabel;

    @FXML
    private Label planDescriptionLabel;

    public void setMainController(MainViewController controller) {

        this.mainController = controller;
    }

    public void setTrainingPlan(TrainingPlan trainingPlan) {
        if (trainingPlan == null) {
            return;
        }

        this.trainingPlan = trainingPlan;
        planNameLabel.setText(trainingPlan.getName());
        planDescriptionLabel.setText(trainingPlan.getDescription());
    }

    @FXML
    private void handleOpening() {
        AppState.getInstance().setCurrentPlan(this.trainingPlan);

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/training_blocks.fxml"));
            Parent view = loader.load();

            TrainingBlocksController blocksCtrl = loader.getController();
            blocksCtrl.loadTrainingBlocks(this.trainingPlan);

            mainController.getCenterPane().setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading training blocks view: " + e.getMessage());
            // e.printStackTrace();
        }
    }

    public VBox getCardView() {
        return trainingPlanCard;
    }
}
