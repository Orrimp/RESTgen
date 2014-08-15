package de.fhws.rdsl.querylang.sql.elements;


public class EqualsElement extends ExpressionElement {
    private ExpressionElement left;
    private ExpressionElement right;

    public ExpressionElement getLeft() {
        return this.left;
    }

    public ExpressionElement getRight() {
        return this.right;
    }

    public void setLeft(ExpressionElement left) {
        this.left = left;
    }

    public void setRight(ExpressionElement right) {
        this.right = right;
    }
}