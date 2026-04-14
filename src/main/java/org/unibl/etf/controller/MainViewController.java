package org.unibl.etf.controller;

import java.io.IOException;

import org.unibl.etf.util.AppState;

// import org.unibl.etf.util.AppState;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.SplitPane;

/**
 * MainViewController
 */
public class MainViewController {

    @FXML
    private SplitPane mainSplitPane;

    @FXML
    private ScrollPane centerPane;
    
    private Node defaultMainView;

    @FXML
    private void initialize() {
        AppState.getInstance().setMainController(this);
    }

    @FXML
    private void showTrainingPlansView() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/training_plans.fxml"));
            Parent view = loader.load();

            if (defaultMainView == null) {
                defaultMainView = centerPane.getContent();
            }

            TrainingPlansController plansCtrl = loader.getController();

            plansCtrl.loadTrainingPlans();

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading training plans view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    private void showLogSessionsView() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/log_sessions.fxml"));
            Parent view = loader.load();

            if (defaultMainView == null) {
                defaultMainView = centerPane.getContent();
            }

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading log sessions view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    private void showProgressView() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/log_progress.fxml"));
            Parent view = loader.load();

            if (defaultMainView == null) {
                defaultMainView = centerPane.getContent();
            }

            LogProgressController logCtrl = loader.getController();

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading progress log view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    private void showExerciseAtlasView() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/exercise_atlas.fxml"));
            Parent view = loader.load();

            if (defaultMainView == null) {
                defaultMainView = centerPane.getContent();
            }

            ExerciseAtlasController atlasCtrl = loader.getController();

            atlasCtrl.loadExercises();

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading exercise atlas view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @FXML
    private void showProfileView() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/profile.fxml"));
            Parent view = loader.load();

            if (defaultMainView == null) {
                defaultMainView = centerPane.getContent();
            }

            ProfileController profileCtrl = loader.getController();

            profileCtrl.setUsernameLabel(AppState.getInstance().getCurrentUser().getUsername());

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading profile view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public ScrollPane getCenterPane() {
        return centerPane;
    }

    public void showDefaultView() {
        // Restore the main view content
        if (defaultMainView != null) {
            centerPane.setContent(defaultMainView);
        }
    }
}
