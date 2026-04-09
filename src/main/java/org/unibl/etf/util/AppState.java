package org.unibl.etf.util;

import org.unibl.etf.model.User;

/**
 * AppState
 */
public final class AppState {
    private static volatile AppState instance;
    private User currentUser;

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

    public void logout() {
        currentUser = null;
    }
}
