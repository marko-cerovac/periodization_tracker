package org.unibl.etf.controller;

import java.util.Map;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.unibl.etf.dao.SetDAO;
import org.unibl.etf.model.Exercise;
import org.unibl.etf.model.Set;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.VBox;
import javafx.scene.Node;

/**
 * SetsController
 */
public class SetsController {

    @FXML
    private VBox exerciseList;

    public void loadExercises() {
        try {
            Map<Exercise, List<Set>> exercises = new SetDAO()
                    .getSetsAndExercisesPerSession(
                            AppState.getInstance()
                                    .getCurrentSession()
                                    .getSessionId());

            for (Map.Entry<Exercise, List<Set>> entry : exercises.entrySet()) {
                Exercise exercise = entry.getKey();
                List<Set> sets = entry.getValue();

                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/sets_card.fxml"));
                Node card = loader.load();

                SetsCardController cardCtrl = loader.getController();
                cardCtrl.setExerciseAndSets(exercise, sets);

                exerciseList.getChildren().add(card);
            }

        } catch (SQLException e) {
            System.err.println("Failed to load exercises for session: " + e);
        } catch (IOException e) {
            System.err.println("Failed to load exercises and sets view: " + e);
            e.printStackTrace();
        }
    }
}
