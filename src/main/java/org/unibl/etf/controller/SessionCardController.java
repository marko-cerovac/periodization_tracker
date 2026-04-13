package org.unibl.etf.controller;

import org.unibl.etf.model.Session;
import org.unibl.etf.model.PPAspect;
import org.unibl.etf.dao.SessionDAO;
import org.unibl.etf.util.AppState;

import javafx.fxml.FXML;
import javafx.scene.control.Label;

import java.sql.SQLException;
import java.util.List;

/**
 * SessionCardController
 */
public class SessionCardController {
    private Session session;
    private MainViewController mainController;

    @FXML
    private Label sessionNameLabel;

    @FXML
    private Label sessionDescriptionLabel;

    @FXML
    private Label sessionPPAspectsLabel;

    public void setMainController(MainViewController mainController) {
        this.mainController = mainController;
    }

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

        // TODO
    }

    @FXML
    private void handleLogging() {
        // TODO
    }
}
