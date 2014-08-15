package de.fhws.rdsl.querylang.solr.elements;

import de.fhws.rdsl.querylang.elements.Element;
import de.fhws.rdsl.querylang.elements.JunctionElement;

public class QueryElement extends Element {

    private JunctionElement query;
    private Long start;
    private Long offset;

    public Long getOffset() {
        return this.offset;
    }

    public JunctionElement getQuery() {
        return this.query;
    }

    public void setOffset(Long offset) {
        this.offset = offset;
    }

    public void setQuery(JunctionElement query) {
        this.query = query;
    }

    public void setStart(Long start) {
        this.start = start;
    }

    public Long getStart() {
        return this.start;
    }

}
