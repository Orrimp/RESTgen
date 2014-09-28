package de.fhws.rdsl.query.transformer.sql.elements;

import de.fhws.rdsl.query.transformer.spi.target.ExpressionElement;

public class NotElement extends ExpressionElement {

    private ExpressionElement expression;

    public ExpressionElement getExpression() {
        return this.expression;
    }

    public void setExpression(ExpressionElement expression) {
        this.expression = expression;
    }

}
