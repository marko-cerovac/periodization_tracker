package org.unibl.etf.util;

/**
 * AppState
 */
public final class AppState {
    private static volatile AppState instance;
    private int userId;
    private String username;

    private AppState(int userId) {
        this.userId = userId;
    }

    public static void init(int userId) {
        instance = new AppState(userId);
    }

    public static void clear() {
        instance.userId = 0;
        instance.username = null;
    }

    public static synchronized AppState getInstance() {
        return instance;
    }

    public int getLoggedInUserId() {
        return userId;
    }

    public String getLoggedInUserName() {
        return username;
    }
}
