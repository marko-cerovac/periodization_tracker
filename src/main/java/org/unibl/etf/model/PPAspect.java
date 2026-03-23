package org.unibl.etf.model;

public class PPAspect {
    private int PPAspectId;
    private String name;

    public PPAspect(int PPAspectId, String name) {
        this.PPAspectId = PPAspectId;
        this.name = name;
    }

    public int getPPAspectId() {
        return PPAspectId;
    }
    public String getName() {
        return name;
    }

    public void setPPAspectId(int PPAspectId) {
        this.PPAspectId = PPAspectId;
    }
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "PPAspect{id=" + PPAspectId + ", name='" + name + "'}";
    }
}
