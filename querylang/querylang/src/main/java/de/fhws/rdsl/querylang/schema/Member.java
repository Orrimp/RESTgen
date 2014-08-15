package de.fhws.rdsl.querylang.schema;

public abstract class Member extends Element {

    private String name;
    private boolean list;
    private boolean queryable;

    public Member(String name, boolean list) {
        super();
        this.name = name;
        this.list = list;
        this.queryable = true;
    }

    public boolean isQueryable() {
        return this.queryable;
    }

    public void setQueryable(boolean queryable) {
        this.queryable = queryable;
    }

    public String getName() {
        return this.name;
    }

    public boolean isList() {
        return this.list;
    }

}