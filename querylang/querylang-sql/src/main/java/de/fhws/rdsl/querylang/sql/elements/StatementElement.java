package de.fhws.rdsl.querylang.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.Element;

public class StatementElement extends Element {
    private SelectElement select;
    private List<JoinElement> joins = Lists.newArrayList();
    private JunctionElement filter;

    public SelectElement getSelect() {
        return this.select;
    }

    public void setSelect(SelectElement select) {
        this.select = select;
    }

    public List<JoinElement> getJoins() {
        return this.joins;
    }

    public JunctionElement getFilter() {
        return this.filter;
    }

    public void setFilter(JunctionElement filter) {
        this.filter = filter;
    }

}