package org.unibl.etf.model;

import java.time.LocalDateTime;

public class UserLog {
    private int userLogId;
    private LocalDateTime date;
    private Integer age;
    private Double weight;
    private Double height;
    private Double bodyfatPercentage;
    private Short satisfaction;
    private int userId;

    public UserLog(
            int userLogId,
            LocalDateTime date,
            Integer age,
            Double weight,
            Double height,
            Double bodyfatPercentage,
            Short satisfaction,
            int userId) {
        this.userLogId = userLogId;
        this.date = date;
        this.age = age;
        this.weight = weight;
        this.height = height;
        this.bodyfatPercentage = bodyfatPercentage;
        this.satisfaction = satisfaction;
        this.userId = userId;
    }

    public int getUserLogId() {
        return userLogId;
    }

    public void setUserLogId(int userLogId) {
        this.userLogId = userLogId;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public Double getBodyfatPercentage() {
        return bodyfatPercentage;
    }

    public void setBodyfatPercentage(Double bodyfatPercentage) {
        this.bodyfatPercentage = bodyfatPercentage;
    }

    public Short getSatisfaction() {
        return satisfaction;
    }

    public void setSatisfaction(Short satisfaction) {
        this.satisfaction = satisfaction;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean hasAge() {
        return age != null;
    }

    public boolean hasWeight() {
        return weight != null;
    }

    public boolean hasHeight() {
        return height != null;
    }

    public boolean hasBodyfatPercentage() {
        return bodyfatPercentage != null;
    }

    public boolean hasSatisfaction() {
        return satisfaction != null;
    }

    @Override
    public String toString() {
        return "UserLog{id=" + userLogId +
                ", date=" + date +
                ", age=" + age +
                ", weight=" + weight +
                ", height=" + height +
                ", bodyfatPercentage=" + bodyfatPercentage +
                ", satisfaction=" + satisfaction +
                ", userId" + userId +
                "}";
    }
}
