package org.unibl.etf.controller;

import java.sql.SQLException;
import java.time.LocalDateTime;

import org.unibl.etf.dao.SessionLogDAO;
import org.unibl.etf.model.SessionLog;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;

/**
 * LogSessionController
 */
public class LogSessionController {

    @FXML
    private Label sessionNameLabel;

    @FXML
    private Label sessionDescriptionLabel;

    @FXML
    private Slider difficultySlider;

    @FXML
    private DatePicker datePicker;

    @FXML
    private Spinner<Integer> hourSpinner;

    @FXML
    private Spinner<Integer> minuteSpinner;

    @FXML
    private Label successMessageLabel;

    @FXML
    private Label errorMessageLabel;

    @FXML
    public void initialize() {
        sessionNameLabel.setText(AppState.getInstance().getCurrentSession().getName());
        sessionDescriptionLabel.setText(AppState.getInstance().getCurrentSession().getDescription());
        hourSpinner.setValueFactory(new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 23, 12));
        minuteSpinner.setValueFactory(new SpinnerValueFactory.IntegerSpinnerValueFactory(0, 59, 0));
    }

    @FXML
    void handleSubmit() {
        LocalDateTime dateTime = datePicker
                .getValue()
                .atTime(hourSpinner.getValue(), minuteSpinner.getValue());
        Double difficulty = difficultySlider.getValue();

        try {
            SessionLog sessionLog = new SessionLog(
                    0,
                    dateTime,
                    difficulty.shortValue(),
                    AppState.getInstance().getCurrentSession().getSessionId(),
                    AppState.getInstance().getCurrentUser().getUserId());

            new SessionLogDAO().create(sessionLog);

            successMessageLabel.setVisible(true);
        } catch (SQLException e) {
            successMessageLabel.setVisible(false);
            errorMessageLabel.setVisible(true);
            System.err.println("Unable to create a session log: " + e);
        }
    }

    @FXML
    private void handleCancel() {
        successMessageLabel.setVisible(false);
        errorMessageLabel.setVisible(false);
        AppState.getInstance().getMainController().showDefaultView();
    }
}
