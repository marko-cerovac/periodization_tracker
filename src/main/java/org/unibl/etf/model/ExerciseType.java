package org.unibl.etf.model;

public class ExerciseType {
    private int exerciseTypeId;
    private String name;

    public ExerciseType(int exerciseTypeId, String name) {
        this.exerciseTypeId = exerciseTypeId;
        this.name = name;
    }

    public int getExerciseTypeId() {
        return exerciseTypeId;
    }
    public String getName() {
        return name;
    }

    public void setExerciseTypeId(int exerciseTypeId) {
        this.exerciseTypeId = exerciseTypeId;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "ExerciseType{id=" + exerciseTypeId + ", name='" + name + "'}";
    }
}
