package de.fhws.rdsl.query.transformer.sql.elements;

import de.fhws.rdsl.query.transformer.spi.target.TargetElement;

public class QueriesElement extends TargetElement {

    private StatementElement query;
    private StatementElement countQuery;

    public StatementElement getCountQuery() {
        return this.countQuery;
    }

    public StatementElement getQuery() {
        return this.query;
    }

    public void setCountQuery(StatementElement countQuery) {
        this.countQuery = countQuery;
    }

    public void setQuery(StatementElement query) {
        this.query = query;
    }

}
