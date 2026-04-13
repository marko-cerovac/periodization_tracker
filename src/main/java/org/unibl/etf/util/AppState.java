package org.unibl.etf.util;

import org.unibl.etf.model.User;
import org.unibl.etf.model.TrainingPlan;
import org.unibl.etf.model.TrainingBlock;
import org.unibl.etf.controller.MainViewController;
import org.unibl.etf.model.Session;

/**
 * AppState
 */
public final class AppState {
    private MainViewController mainController;
    private static volatile AppState instance;
    private User currentUser;
    private TrainingPlan currentPlan;
    private TrainingBlock currentBlock;
    private Session currentSession;

    private AppState() {}

    public static synchronized AppState getInstance() {
        if (instance == null) {
            instance = new AppState();
        }
        return instance;
    }

    public void setCurrentUser(User user) {
        this.currentUser = user;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentPlan(TrainingPlan plan) {
        this.currentPlan = plan;
    }

    public TrainingPlan getCurrentPlan() {
        return this.currentPlan;
    }

    public void setCurrentBlock(TrainingBlock block) {
        this.currentBlock = block;
    }

    public TrainingBlock getCurrentBlock() {
        return this.currentBlock;
    }

    public void setCurrentSession(Session session) {
        this.currentSession = session;
    }

    public Session getSession() {
        return this.currentSession;
    }

    public void clearPlan() {
        this.currentPlan = null;
    }

    public void clearBlock() {
        this.currentBlock = null;
    }

    public void clearSession() {
        this.currentSession = null;
    }

    public void logout() {
        currentUser = null;
    }

	public MainViewController getMainController() {
		return mainController;
	}

	public void setMainController(MainViewController mainController) {
		this.mainController = mainController;
	}

	public static void setInstance(AppState instance) {
		AppState.instance = instance;
	}

	public Session getCurrentSession() {
		return currentSession;
	}
}
