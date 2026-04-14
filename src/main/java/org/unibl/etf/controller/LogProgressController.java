package org.unibl.etf.controller;

import org.unibl.etf.dao.UserLogDAO;
import org.unibl.etf.model.UserLog;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import javafx.scene.control.Slider;
import javafx.scene.control.Label;

import java.time.LocalDateTime;
import java.sql.*;

/**
 * LogProgressController
 */
public class LogProgressController {

    @FXML
    private TextField ageField;

    @FXML
    private TextField heightField;

    @FXML
    private TextField weightField;

    @FXML
    private TextField bodyfatField;

    @FXML
    private Slider satisfactionSlider;

    @FXML
    private Label successMessageLabel;

    @FXML
    private Label errorMessageLabel;

    @FXML
    private void handleSubmit() {
            successMessageLabel.setText("");
            errorMessageLabel.setText("");

        try {
            Integer age = Integer.parseInt(ageField.getText());
            Double height = Double.parseDouble(heightField.getText());
            Double weight = Double.parseDouble(weightField.getText());
            Double bodyfat = Double.parseDouble(bodyfatField.getText());
            Double satisfaction = satisfactionSlider.getValue();

            UserLog userLog = new UserLog(
                    0,
                    LocalDateTime.now(),
                    age,
                    weight,
                    height,
                    bodyfat,
                    satisfaction.shortValue(),
                    AppState.getInstance().getCurrentUser().getUserId());

            new UserLogDAO().create(userLog);

            ageField.clear();
            heightField.clear();
            weightField.clear();;
            bodyfatField.clear();

            successMessageLabel.setText("Logged succesfully!");


        } catch (NumberFormatException e) {
            System.err.println("Can't parse text into an integer: " + e);
            successMessageLabel.setText("");
            errorMessageLabel.setText("Invalid value in one of the fields!");
        } catch (SQLException e) {
            System.err.println("Can't create a user log: " + e);
            successMessageLabel.setText("");
            errorMessageLabel.setText("Failed to create a log!");
        }
    }

    @FXML
    private void handleCancel() {
        successMessageLabel.setText("");
        errorMessageLabel.setText("");
        AppState.getInstance().getMainController().showDefaultView();
    }
}
