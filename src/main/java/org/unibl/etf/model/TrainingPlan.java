package org.unibl.etf.model;

class TrainingPlan {
    private int trainingPlanId;
    private String name;
    private String description;
    private int userId;

    public TrainingPlan(int trainingPlanId, String name, String description, int userId) {
        this.trainingPlanId = trainingPlanId;
        this.name = name;
        this.description = description;
        this.userId = userId;
    }

    public int getTrainingPlanId() {
        return trainingPlanId;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public int getUserId() {
        return userId;
    }

    public void setTrainingPlanId(int trainingPlanId) {
        this.trainingPlanId = trainingPlanId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String toString() {
        return "TrainingPlan{id=" + trainingPlanId + ", name='" + name + "', description='" + description + "', userId="
                + userId + "}";
    }

}
