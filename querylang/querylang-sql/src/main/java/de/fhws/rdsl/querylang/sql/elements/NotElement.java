package de.fhws.rdsl.querylang.sql.elements;

import de.fhws.rdsl.querylang.elements.ExpressionElement;

public class NotElement extends ExpressionElement {

    private ExpressionElement expression;

    public ExpressionElement getExpression() {
        return this.expression;
    }

    public void setExpression(ExpressionElement expression) {
        this.expression = expression;
    }

}
