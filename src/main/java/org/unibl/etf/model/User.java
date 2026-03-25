package org.unibl.etf.model;

public class User {
    private int userId;
    private String username;
    private Integer age;
    private Gender gender;
    private Double weight;
    private Double height;

    public User(int userId, String username, int age, Gender gender, Double weight, Double height) {
        this.userId = userId;
        this.username = username;
        this.age = age;
        this.gender = gender;
        this.weight = weight;
        this.height = height;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public Integer getAge() {
        return age;
    }

    public Gender getGender() {
        return gender;
    }

    public Double getWeight() {
        return weight;
    }

    public Double getHeight() {
        return height;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public boolean hasAge() {
        return age != null;
    }

    public boolean hasGender() {
        return gender != null;
    }

    public boolean hasWeight() {
        return weight != null;
    }

    public boolean hasHeight() {
        return height != null;
    }

    @Override
    public String toString() {
        return "User{id=" + userId + ", username='" + username + "', age=" + age + ", gender='" + gender
                + "', weight=" + weight + ", height=" + height + "}";
    }
}
