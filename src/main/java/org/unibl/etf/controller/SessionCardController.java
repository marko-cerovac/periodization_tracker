package org.unibl.etf.controller;

import org.unibl.etf.model.Session;
import org.unibl.etf.model.PPAspect;
import org.unibl.etf.dao.SessionDAO;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.Label;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * SessionCardController
 */
public class SessionCardController {
    private Session session;

    @FXML
    private Label sessionNameLabel;

    @FXML
    private Label sessionDescriptionLabel;

    @FXML
    private Label sessionPPAspectsLabel;

    public void setSession(Session session) {
        if (session == null) {
            return;
        }

        this.session = session;
        sessionNameLabel.setText(session.getName());
        sessionDescriptionLabel.setText(session.getDescription());

        try {
            StringBuilder ppAspectsText = new StringBuilder();
            List<PPAspect> ppAspects = new SessionDAO().getPPAspects(session);
            ppAspectsText.append("Physical performance aspects: ");

            for (var ppAspect : ppAspects) {
                ppAspectsText.append(ppAspect.getName()).append(", ");
            }
            ppAspectsText.delete(ppAspectsText.lastIndexOf(", "), ppAspectsText.length());

        } catch (SQLException e) {
            System.out.println("Failed to get physical performance apsects for given session: " + e);
        }
    }

    @FXML
    private void handleOpening() {
        AppState.getInstance().setCurrentSession(this.session);

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/sets_view.fxml"));
            Parent view = loader.load();

            SetsController setsCtrl = loader.getController();
            setsCtrl.loadExercises();

            AppState.getInstance().getMainController().getCenterPane().setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading exercises and sets view: " + e.getMessage());
            // e.printStackTrace();
        }
    }

    @FXML
    private void handleLogging() {
        AppState.getInstance().setCurrentSession(this.session);

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("/org/unibl/etf/log_session.fxml"));
            Parent view = loader.load();

            AppState.getInstance()
                    .getMainController()
                    .getCenterPane()
                    .setContent(view);
        } catch (IOException e) {
            System.err.println("Error loading session logging view: " + e);
        }
    }
}
