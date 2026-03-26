package org.unibl.etf.model;

public class Exercise {
    private int exerciseId;
    private String name;
    private String description;
    private int exerciseTypeId;

    public Exercise(int exerciseId, String name, String description, int exerciseTypeId) {
        this.exerciseId = exerciseId;
        this.name = name;
        this.description = description;
        this.exerciseTypeId = exerciseTypeId;
    }

    public int getExerciseId() {
        return exerciseId;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public int getExerciseTypeId() {
        return exerciseTypeId;
    }

    public void setExerciseId(int exerciseId) {
        this.exerciseId = exerciseId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setExerciseTypeId(int exerciseTypeId) {
        this.exerciseTypeId = exerciseTypeId;
    }

    public boolean hasDescription() {
        return description != null;
    }

    @Override
    public String toString() {
        return "Exercise{id=" + exerciseId + ", name='" + name + "', description='" + description + "', exerciseTypeId="
                + exerciseTypeId + "}";
    }

}
