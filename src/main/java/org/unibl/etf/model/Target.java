package org.unibl.etf.model;

public class Target {
    private int targetId;
    private String name;
    private String latinName;
    private String description;
    private int targetTypeId;

    public Target(int targetId, String name, String latinName, String description, int targetTypeId) {
        this.targetId = targetId;
        this.name = name;
        this.latinName = latinName;
        this.description = description;
        this.targetTypeId = targetTypeId;
    }

    public int getTargetId() {
        return targetId;
    }

    public String getName() {
        return name;
    }

    public String getLatinName() {
        return latinName;
    }

    public String getDescription() {
        return description;
    }

    public int getTargetTypeId() {
        return targetTypeId;
    }

    public void setTargetId(int targetId) {
        this.targetId = targetId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLatinName(String latinName) {
        this.latinName = latinName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setTargetTypeId(int targetTypeId) {
        this.targetTypeId = targetTypeId;
    }

    public boolean hasLatinName() {
        return latinName != null;
    }

    public boolean hasDescription() {
        return description != null;
    }

    @Override
    public String toString() {
        return "Target{id=" + targetId + ", name='" + name + "', latinName='" + latinName +
                "', description='" + description + "', targetTypeId=" + targetTypeId + "}";
    }
}
