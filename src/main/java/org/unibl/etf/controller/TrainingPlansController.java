package org.unibl.etf.controller;

import javafx.scene.layout.FlowPane;

import org.unibl.etf.model.TrainingPlan;
import org.unibl.etf.dao.TrainingPlanDAO;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;

import java.util.List;
import java.io.IOException;
import java.sql.SQLException;

/**
 * TrainingPlansController
 */
public class TrainingPlansController {

    @FXML
    private FlowPane trainingPlansGrid;

    public void loadTrainingPlans() {
        try {
            List<TrainingPlan> trainingPlans = new TrainingPlanDAO().findByUserId(AppState.getInstance().getCurrentUser().getUserId());

            for (var trainingPlan : trainingPlans) {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/training_plan_card.fxml"));
                Node card = loader.load();

                TrainingPlanCardController cardCtrl = loader.getController();
                cardCtrl.setTrainingPlan(trainingPlan);

                trainingPlansGrid.getChildren().add(card);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load training plans for user: " + e);
        } catch (IOException e) {
            System.err.println("Failed to load training plans view: " + e);
            e.printStackTrace();
        }
    }
}
