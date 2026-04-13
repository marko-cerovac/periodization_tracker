package org.unibl.etf.controller;

import org.unibl.etf.dao.UserDAO;
import org.unibl.etf.util.AppState;
import org.unibl.etf.util.PasswordHasher;

import java.io.IOException;
import java.sql.SQLException;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.stage.Stage;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;

/**
 * ProfileController
 */
public class ProfileController {
    private MainViewController mainController;

    @FXML
    private Label usernameLabel;

    @FXML
    private PasswordField newPasswordField;

    @FXML
    private Button submitNewPasswordButton;

    public void setUsernameLabel(String username) {
        usernameLabel.setText(username);
    }

    @FXML
    private void handleShowNewPasswordField() {
        newPasswordField.setVisible(true);
        submitNewPasswordButton.setVisible(true);
    }

    @FXML
    private void handleSubmitNewPassword() {
        String newPassword = newPasswordField.getText();
        AppState.getInstance()
                .getCurrentUser()
                .setPassword(PasswordHasher.hashPassword(newPassword));

        UserDAO userDAO = new UserDAO();

        try {
            userDAO.update(AppState.getInstance().getCurrentUser());
        } catch (SQLException e) {
            System.err.println("Failed to update user password: " + e);
        }

        newPasswordField.setVisible(false);
        submitNewPasswordButton.setVisible(false);
    }

    @FXML
    private void handleDeleteProfile() {
        UserDAO userDAO = new UserDAO();

        try {
            userDAO.delete(AppState.getInstance().getCurrentUser().getUserId());
        } catch (SQLException e) {
            System.err.println("Failed to delete user: " + e);
            return;
        }

        returnToLoginScreen();
    }

    public void setMainController(MainViewController controller) {
        this.mainController = controller;
    }

    @FXML
    private void handleBack() {
        mainController.showDefaultView();
    }
    

    private void returnToLoginScreen() {
        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/login.fxml"));
            Parent loginRoot = loader.load();

            Stage stage = (Stage) usernameLabel.getScene().getWindow();

            Scene loginScene = new Scene(loginRoot);
            stage.setScene(loginScene);

            stage.centerOnScreen();
            stage.show();

        } catch (IOException e) {
            System.err.println("Failed to return to login screen.");
            e.printStackTrace();
        }
    }
}
