package de.fhws.rdsl.querylang.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.elements.Element;

public class JoinElement extends Element {
    private String table;
    private String tableAlias;
    private List<EqualsElement> properties = Lists.newArrayList();

    public String getTable() {
        return this.table;
    }

    public String getTableAlias() {
        return this.tableAlias;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public void setTableAlias(String tableAlias) {
        this.tableAlias = tableAlias;
    }

    public List<EqualsElement> getProperties() {
        return this.properties;
    }

}