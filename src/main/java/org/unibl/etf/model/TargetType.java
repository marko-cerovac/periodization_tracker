package org.unibl.etf.model;

/**
 * TargetType
 */
public class TargetType {
    private int targetTypeId;
    private String name;

    public TargetType(int targetTypeId, String name) {
        this.targetTypeId = targetTypeId;
        this.name = name;
    }

    public int getTargetTypeId() { return targetTypeId; }
    public String getName() { return name; }

    public void setTargetTypeId(int targetTypeId) { this.targetTypeId = targetTypeId; }
    public void setName(String name) { this.name = name; }

    @Override
    public String toString() {
        return "TargetType{id=" + targetTypeId + ", name='" + name + "'}";
    }
}
