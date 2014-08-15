package de.fhws.rdsl.querylang.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.JunctionElement;

public class StatementElement extends Element {
    private SelectElement select;
    private List<JoinElement> joins = Lists.newArrayList();
    private JunctionElement filter;
    private OrderElement order;
    private Long start;
    private Long offset;

    public Long getOffset() {
        return this.offset;
    }

    public void setOffset(Long offset) {
        this.offset = offset;
    }

    public Long getStart() {
        return this.start;
    }

    public void setStart(Long start) {
        this.start = start;
    }

    public void setOrder(OrderElement order) {
        this.order = order;
    }

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

    public OrderElement getOrder() {
        return this.order;
    }

}