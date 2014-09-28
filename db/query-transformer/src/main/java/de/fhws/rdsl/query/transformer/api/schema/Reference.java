package de.fhws.rdsl.query.transformer.api.schema;

public class Reference extends Member {

    private Type type;
    private String opposite;

    public Reference(String name, boolean list, Type type, String opposite) {
        super(name, list);
        this.type = type;
        this.opposite = opposite;
    }

    public String getOpposite() {
        return this.opposite;
    }

    public Type getType() {
        return this.type;
    }

}