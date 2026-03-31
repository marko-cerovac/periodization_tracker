package org.unibl.etf.model;

public class Set {
    private int setId;
    private Integer numberOfRepetitions;
    private Integer restDuration;
    private Double weight;
    private Integer rpe;
    private Short block;
    private int exerciseId;
    private int repetitionTypeId;
    private int sessionId;

    public Set(int setId, Integer numberOfRepetitions, Integer restDuration, Double weight,
            Integer rpe, Short block, int exerciseId, int repetitionTypeId, int sessionId) {
        this.setId = setId;
        this.numberOfRepetitions = numberOfRepetitions;
        this.restDuration = restDuration;
        this.weight = weight;
        this.rpe = rpe;
        this.block = block;
        this.exerciseId = exerciseId;
        this.repetitionTypeId = repetitionTypeId;
        this.sessionId = sessionId;
    }

    public int getSetId() {
        return setId;
    }

    public Integer getNumberOfRepetitions() {
        return numberOfRepetitions;
    }

    public Integer getRestDuration() {
        return restDuration;
    }

    public Double getWeight() {
        return weight;
    }

    public Integer getRpe() {
        return rpe;
    }

    public Short getBlock() {
        return block;
    }

    public int getExerciseId() {
        return exerciseId;
    }

    public int getRepetitionTypeId() {
        return repetitionTypeId;
    }

    public int getSessionId() {
        return sessionId;
    }

    public void setSetId(int setId) {
        this.setId = setId;
    }

    public void setNumberOfRepetitions(Integer numberOfRepetitions) {
        this.numberOfRepetitions = numberOfRepetitions;
    }

    public void setRestDuration(Integer restDuration) {
        this.restDuration = restDuration;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public void setRpe(Integer rpe) {
        this.rpe = rpe;
    }

    public void setBlock(Short block) {
        this.block = block;
    }

    public void setExerciseId(int exerciseId) {
        this.exerciseId = exerciseId;
    }

    public void setRepetitionTypeId(int repetitionTypeId) {
        this.repetitionTypeId = repetitionTypeId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }

    public boolean hasNumberOfRepetitions() {
        return this.numberOfRepetitions != null;
    }

    public boolean hasRestDuration() {
        return this.restDuration != null;
    }

    public boolean hasWeight() {
        return this.weight != null;
    }

    public boolean hasRpe() {
        return this.rpe != null;
    }

    public boolean hasBlock() {
        return this.block != null;
    }

    @Override
    public String toString() {
        return "Set{id=" + setId + ", reps=" + numberOfRepetitions + ", rest=" + restDuration +
                ", weight=" + weight + ", rpe=" + rpe + ", block=" + block + ", exerciseId=" + exerciseId +
                ", repetitionTypeId=" + repetitionTypeId + ", sessionId=" + sessionId + "}";
    }
}
