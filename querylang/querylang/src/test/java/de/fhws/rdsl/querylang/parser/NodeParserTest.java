package de.fhws.rdsl.querylang.parser;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.junit.Assert;
import org.junit.Test;

import de.fhws.rdsl.querylang.antlr.QueryLexer;
import de.fhws.rdsl.querylang.antlr.QueryParser;
import de.fhws.rdsl.querylang.antlr.QueryParser.ExpressionContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.ExpressionsContext;

public class NodeParserTest {

    @Test
    public void test01() throws IOException {

        JunctionNode orJunction = (JunctionNode) new DefaultNodeParser().parse(getLine(0));
        Assert.assertEquals(JunctionNode.OR, orJunction.getType());

        FunctionNode nameCall = (FunctionNode) orJunction.getChildren().get(0);
        Assert.assertEquals("name", nameCall.getPath().get(0));
        Assert.assertEquals("equals", nameCall.getName());
        Assert.assertEquals(new Integer(123), ((IntegerLiteralNode) nameCall.getArgs().get(0)).getValue());

        JunctionNode andJunction = (JunctionNode) orJunction.getChildren().get(1);
        Assert.assertEquals(JunctionNode.AND, andJunction.getType());

        FunctionNode addressCall = (FunctionNode) andJunction.getChildren().get(0);
        Assert.assertEquals("address", addressCall.getPath().get(0));
        Assert.assertEquals("is", addressCall.getName());
        Assert.assertEquals(new Double(1249.3423), ((FloatLiteralNode) addressCall.getArgs().get(0)).getValue());

        FunctionNode daCall = (FunctionNode) andJunction.getChildren().get(1);
        Assert.assertEquals(0, daCall.getPath().size());
        Assert.assertEquals("da", daCall.getName());
        Assert.assertEquals("hell\\\"21321", ((StringLiteralNode) daCall.getArgs().get(0)).getValue());
        Assert.assertEquals(true, ((BooleanLiteralNode) daCall.getArgs().get(1)).getValue());
        Assert.assertTrue(daCall.getArgs().get(3) instanceof NullLiteralNode);

        FunctionNode funCall = (FunctionNode) daCall.getArgs().get(2);
        Assert.assertEquals(0, funCall.getPath().size());
        Assert.assertEquals("fun", funCall.getName());
        Assert.assertEquals(0, funCall.getArgs().size());

    }

    private ExpressionContext getLine(int nr) throws IOException {
        try (InputStream is = getClass().getResourceAsStream("/expressions.txt")) {
            QueryLexer lexer = new QueryLexer(new ANTLRInputStream(is));
            QueryParser parser = new QueryParser(new CommonTokenStream(lexer));
            ExpressionsContext context = parser.expressions();
            return context.expression(nr);
        }
    }

}
