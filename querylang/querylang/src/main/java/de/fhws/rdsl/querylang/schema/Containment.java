package de.fhws.rdsl.querylang.schema;

public class Containment extends Member {

    private SubResourceType resourceType;
    private String opposite;

    public Containment(String name, boolean list, SubResourceType resourceType, String opposite) {
        super(name, list);
        this.resourceType = resourceType;
        this.opposite = opposite;
    }

    public String getOpposite() {
        return this.opposite;
    }

    public SubResourceType getResourceType() {
        return this.resourceType;
    }

}