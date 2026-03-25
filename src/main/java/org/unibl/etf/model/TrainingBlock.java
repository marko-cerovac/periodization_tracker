package org.unibl.etf.model;

class TrainingBlock {
    private int trainingBlockId;
    private String name;
    private String description;
    private Integer duration;
    private int userId;

    public TrainingBlock(int trainingBlockId, String name, String description, Integer duration, int userId) {
        this.trainingBlockId = trainingBlockId;
        this.name = name;
        this.description = description;
        this.duration = duration;
        this.userId = userId;
    }

    public int getTrainingBlockId() {
        return trainingBlockId;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public Integer getDuration() {
        return duration;
    }

    public int getUserId() {
        return userId;
    }

    public void setTrainingBlockId(int trainingBlockId) {
        this.trainingBlockId = trainingBlockId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public boolean hasName() {
        return name != null;
    }

    public boolean hasDescription() {
        return description != null;
    }

    public boolean hasDuration() {
        return duration != null;
    }

    public String toString() {
        return "TrainingBlock{id=" + trainingBlockId + ", name='" + name + "', description=" + description
                + "', duration=" + duration + ", userId=" + userId + "}";
    }

}
