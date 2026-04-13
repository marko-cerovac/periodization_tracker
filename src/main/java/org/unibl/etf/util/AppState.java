package org.unibl.etf.util;

import org.unibl.etf.model.User;
import org.unibl.etf.model.TrainingPlan;
import org.unibl.etf.model.TrainingBlock;

/**
 * AppState
 */
public final class AppState {
    private static volatile AppState instance;
    private User currentUser;
    private TrainingPlan currentPlan;
    private TrainingBlock currentBlock;

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

    public void clearPlan() {
        this.currentPlan = null;
    }

    public void clearBlock() {
        this.currentBlock = null;
    }

    public void logout() {
        currentUser = null;
    }
}
