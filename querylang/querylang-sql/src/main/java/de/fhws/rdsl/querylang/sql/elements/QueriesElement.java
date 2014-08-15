package de.fhws.rdsl.querylang.sql.elements;

import de.fhws.rdsl.querylang.elements.Element;

public class QueriesElement extends Element {

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
