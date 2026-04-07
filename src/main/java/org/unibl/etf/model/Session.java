package org.unibl.etf.model;

public class Session {
    private int sessionId;
    private String name;
    private String description;

    public Session(int sessionId, String name, String description) {
        this.sessionId = sessionId;
        this.name = name;
        this.description = description;
    }

    public int getSessionId() {
        return sessionId;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean hasDescription() {
        return this.description != null;
    }

    @Override
    public String toString() {
        return "Session{id=" + sessionId + ", name='" + name + "', description='" + description + "'}";
    }
}
