package de.fhws.rdsl.querylang.schema;

public class Reference extends Member {

    private RootResourceType resourceType;
    private ReferenceType referenceType;
    private String opposite;

    public Reference(String name, boolean list, RootResourceType resourceType, ReferenceType referenceType, String opposite) {
        super(name, list);
        this.resourceType = resourceType;
        this.referenceType = referenceType;
        this.opposite = opposite;
    }

    public String getOpposite() {
        return this.opposite;
    }

    public ReferenceType getReferenceType() {
        return this.referenceType;
    }

    public RootResourceType getResourceType() {
        return this.resourceType;
    }

}