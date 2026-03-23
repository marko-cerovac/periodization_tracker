package org.unibl.etf.model;

public class RepetitionType {
    private int repetitionTypeId;
    private String name;

    public RepetitionType(int repetitionTypeId, String name) {
        this.repetitionTypeId = repetitionTypeId;
        this.name = name;
    }

    public int getRepetitionTypeId() {
        return repetitionTypeId;
    }
    public String getName() {
        return name;
    }

    public void setRepetitionTypeId(int repetitionTypeId) {
        this.repetitionTypeId = repetitionTypeId;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "RepetitionType{id=" + repetitionTypeId + ", name='" + name + "'}";
    }
}
