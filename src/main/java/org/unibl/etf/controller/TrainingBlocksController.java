package org.unibl.etf.controller;

import org.unibl.etf.dao.TrainingPlanDAO;
import org.unibl.etf.model.TrainingBlock;
import org.unibl.etf.model.TrainingPlan;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.FlowPane;
import javafx.scene.Node;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * TrainingBlocksController
 */
public class TrainingBlocksController {

    @FXML
    private FlowPane trainingBlocksGrid;

    public void loadTrainingBlocks(TrainingPlan parrentPlan) {
        try {
            List<TrainingBlock> trainingBlocks = new TrainingPlanDAO().getTrainingBlocks(parrentPlan);

            for (var trainingBlock : trainingBlocks) {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/training_block_card.fxml"));
                Node card = loader.load();

                TrainingBlockCardController cardCtrl = loader.getController();
                cardCtrl.setTrainingBlock(trainingBlock);

                trainingBlocksGrid.getChildren().add(card);
            }
        } catch (SQLException e) {
            System.err.println("Failed to load training plans for user: " + e);
        } catch (IOException e) {
            System.err.println("Failed to load training plans view: " + e);
            e.printStackTrace();
        }
    }
}
