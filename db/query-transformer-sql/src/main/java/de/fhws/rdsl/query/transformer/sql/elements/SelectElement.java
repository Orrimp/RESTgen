package de.fhws.rdsl.query.transformer.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.query.transformer.spi.target.PropertyElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class SelectElement extends TargetElement {
    private boolean distinct;
    private boolean count;
    private List<PropertyElement> properties = Lists.newArrayList();
    private String fromTable;
    private String fromTableAlias;

    public boolean isCount() {
        return this.count;
    }

    public void setCount(boolean count) {
        this.count = count;
    }

    public String getFromTable() {
        return this.fromTable;
    }

    public void setFromTable(String fromTable) {
        this.fromTable = fromTable;
    }

    public String getFromTableAlias() {
        return this.fromTableAlias;
    }

    public void setFromTableAlias(String fromTableAlias) {
        this.fromTableAlias = fromTableAlias;
    }

    public boolean isDistinct() {
        return this.distinct;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public List<PropertyElement> getProperties() {
        return this.properties;
    }
}