package org.unibl.etf.model;

import java.time.LocalDateTime;

public class SessionLog {
    private int sessionLogId;
    private LocalDateTime date;
    private Short difficulty;
    private int sessionId;
    private int userId;

    public SessionLog(int sessionLogId, LocalDateTime date, Short difficulty, int sessionId, int userId) {
        this.sessionLogId = sessionLogId;
        this.date = date;
        this.difficulty = difficulty;
        this.sessionId = sessionId;
        this.userId = userId;
    }

	public int getSessionLogId() {
		return sessionLogId;
	}

	public void setSessionLogId(int sessionLogId) {
		this.sessionLogId = sessionLogId;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public void setDate(LocalDateTime date) {
		this.date = date;
	}

	public Short getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(Short difficulty) {
		this.difficulty = difficulty;
	}

	public int getSessionId() {
		return sessionId;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

    public boolean hasDifficulty() {
        return this.difficulty != null;
    }

    @Override
    public String toString() {
        return "SessionLog{id=" + sessionLogId +
            ", date=" + date +
            ", difficulty=" + difficulty +
            ", sessionId=" + sessionId +
            ", userId=" + userId +
            "}";
    }
}
