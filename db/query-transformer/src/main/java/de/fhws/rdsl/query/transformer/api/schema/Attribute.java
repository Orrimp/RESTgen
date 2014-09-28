package de.fhws.rdsl.query.transformer.api.schema;

public class Attribute extends Member {

    public static final int INTEGER = 1;
    public static final int FLOAT = 2;
    public static final int DATE = 3;
    public static final int STRING = 4;
    public static final int BOOLEAN = 5;

    public static final int NESTED = 128;

    private int type;
    private boolean visible;
    private boolean internal;

    public Attribute(String name, int type) {
        super(name, false);
        this.type = type;
        this.visible = true;
        this.internal = false;
    }

    public void setInternal(boolean internal) {
        this.internal = internal;
    }

    public int getType() {
        return this.type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isVisible() {
        return this.visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public boolean isInternal() {
        return this.internal;
    }

}