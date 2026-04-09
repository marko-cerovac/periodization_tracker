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
    private void showTrainingPlansView() {
        loadView("training_plans.fxml");
    }

    @FXML
    private void showLogSessionsView() {
        loadView("log_sessions.fxml");
    }

    @FXML
    private void showProgressView() {
        loadView("progress.fxml");
    }

    @FXML
    private void showExerciseAtlasView() {
        loadView("exercise_atlas.fxml");
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
            profileCtrl.setMainController(this);

            centerPane.setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading profile view: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void showDefaultView() {
        // Restore the main view content
        if (defaultMainView != null) {
            centerPane.setContent(defaultMainView);
        }
    }

    private void loadView(String fxmlPath) {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource(fxmlPath));
            Parent newView = loader.load();

            ScrollPane scrollWrapper = new ScrollPane();
            scrollWrapper.setContent(newView);
            scrollWrapper.setFitToWidth(true);

            // replace the center pane, or create a new one
            // if it doesn't exist for some reason
            if (mainSplitPane.getItems().size() > 1) {
                mainSplitPane.getItems().set(1, scrollWrapper);
            } else {
                mainSplitPane.getItems().add(scrollWrapper);
            }
        } catch (IOException e) {
            System.err.println("Error loading view: " + fxmlPath);
            e.printStackTrace();
        }
    }
}
