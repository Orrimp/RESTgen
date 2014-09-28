package de.fhws.rdsl.query.transformer.sql.elements;

import java.util.List;

import com.google.common.collect.Lists;

import de.fhws.rdsl.query.transformer.spi.target.JunctionElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class StatementElement extends TargetElement {
    private SelectElement select;
    private List<JoinElement> joins = Lists.newArrayList();
    private JunctionElement filter;
    private OrderElement order;
    private Long start;
    private Long size;

    public Long getSize() {
        return this.size;
    }

    public void setSize(Long size) {
        this.size = size;
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