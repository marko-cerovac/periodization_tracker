package org.unibl.etf.controller;

import org.unibl.etf.dao.TrainingBlockDAO;
import org.unibl.etf.model.Session;
import org.unibl.etf.model.TrainingBlock;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.FlowPane;
import javafx.scene.Node;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * SessionsController
 */
public class SessionsController {

    @FXML
    private FlowPane sessionsGrid;
    
    public void loadSessions(TrainingBlock parrentBlock) {
        try {
            List<Session> sessions = new TrainingBlockDAO().getSessions(parrentBlock);

            for (var session : sessions) {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/session_card.fxml"));
                Node card = loader.load();

                SessionCardController cardCtrl = loader.getController();
                cardCtrl.setSession(session);

                sessionsGrid.getChildren().add(card);
            }

        } catch (SQLException e) {
            System.err.println("Failed to load sessions for training block: " + e);
        } catch (IOException e) {
            System.err.println("Failed to load sessions for training block: " + e);
            e.printStackTrace();
        }
    }
}
