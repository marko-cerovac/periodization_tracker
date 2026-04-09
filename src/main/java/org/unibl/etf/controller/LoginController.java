package org.unibl.etf.controller;

import org.unibl.etf.App;
import org.unibl.etf.util.AppState;
import org.unibl.etf.util.PasswordHasher;
import org.unibl.etf.model.User;
import org.unibl.etf.util.InvalidCredentialsException;

import java.sql.SQLException;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.unibl.etf.dao.UserDAO;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;

public class LoginController {

    @FXML
    private TextField usernameField;

    @FXML
    private PasswordField passwordField;

    @FXML
    private Label errorLabel;

    @FXML
    private void handleLogin() {
        String username = usernameField.getText();
        String password = passwordField.getText();

        // Clear previous error messages
        errorLabel.setText("");

        // Validate input fields
        if (username.isEmpty() || password.isEmpty()) {
            errorLabel.setText("Username and password cannot be empty");
            return;
        }

        UserDAO userDAO = new UserDAO();

        try {
            Optional<User> attempt = userDAO.findByUsername(username);

            User user = attempt.get();

            if (PasswordHasher.hashPassword(password).equals(user.getPassword())) {
                errorLabel.setText("");
                usernameField.clear();
                passwordField.clear();

                AppState.getInstance().setCurrentUser(user);
                loadMainView();

            } else {
                // System.out.println("The hash should be: " + user.getPassword()); // DEBUG
                // System.out.println("The hash is currently: " + PasswordHasher.hashPassword(password)); // DEBUG
                throw new InvalidCredentialsException("Wrong credentials: incorrect password for username " + username);
            }
        } catch (NoSuchElementException e) {
            errorLabel.setText("User not found: " + username);
        } catch (InvalidCredentialsException e) {
            errorLabel.setText(e.getMessage());
        } catch (SQLException e) {
            errorLabel.setText("Database error: " + e.getMessage());
        }
    }

    @FXML
    private void handleQuitting() {
        System.exit(0);
    }

    private void loadMainView() {
        try {
            FXMLLoader loader = new FXMLLoader(App.class.getResource("main_view.fxml"));
            Scene scene = new Scene(loader.load());
            Stage stage = (Stage) usernameField.getScene().getWindow();
            stage.setScene(scene);
            stage.show();
        } catch (IOException e) {
            errorLabel.setText("Error loading main view: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
