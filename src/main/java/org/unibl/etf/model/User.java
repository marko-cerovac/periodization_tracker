package org.unibl.etf.model;

import org.unibl.etf.util.PasswordHasher;

public class User {
    private int userId;
    private String username;
    private String password;
    private Gender gender;

    public User(int userId, String username, String password, Gender gender) {
        this.userId = userId;
        this.username = username;
        this.password = password != null ? PasswordHasher.hashPassword(password) : null;
        this.gender = gender;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public Gender getGender() {
        return gender;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = PasswordHasher.hashPassword(password);
    }

    /**
     * Stores an already-hashed password directly, without hashing again.
     * Use this when reconstructing a User from a database row.
     *
     * @param hash the pre-computed password hash
     */
    public void setPasswordHash(String hash) {
        this.password = hash;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public boolean hasGender() {
        return gender != null;
    }

    @Override
    public String toString() {
        return "User{id=" + userId +
                ", username='" + username +
                "', password='" + password +
                "', gender = '" + gender +
                "'}";
    }
}
