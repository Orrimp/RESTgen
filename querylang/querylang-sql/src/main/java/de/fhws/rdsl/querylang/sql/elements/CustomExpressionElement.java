package de.fhws.rdsl.querylang.sql.elements;

public class CustomExpressionElement extends ExpressionElement {
    private String text;

    public CustomExpressionElement(String text) {
        super();
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public void setText(String text) {
        this.text = text;
    }
}