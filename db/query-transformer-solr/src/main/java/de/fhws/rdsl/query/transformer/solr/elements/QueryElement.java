package de.fhws.rdsl.query.transformer.solr.elements;

import de.fhws.rdsl.query.transformer.spi.target.JunctionElement;
import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class QueryElement extends TargetElement {

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
