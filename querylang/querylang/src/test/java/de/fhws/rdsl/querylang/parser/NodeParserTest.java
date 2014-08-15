package de.fhws.rdsl.querylang.parser;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.junit.Assert;
import org.junit.Test;

import de.fhws.rdsl.querylang.parser.QueryParser.ExpressionContext;
import de.fhws.rdsl.querylang.parser.QueryParser.ExpressionsContext;

public class NodeParserTest {

    @Test
    public void test01() throws IOException {

        Junction orJunction = (Junction) new NodeParser().parse(getLine(0));
        Assert.assertEquals(Junction.OR, orJunction.getType());

        MethodCall nameCall = (MethodCall) orJunction.getChildren().get(0);
        Assert.assertEquals("name", nameCall.getPath().get(0));
        Assert.assertEquals("equals", nameCall.getName());
        Assert.assertEquals(123, nameCall.getArgs().get(0).getValue());

        Junction andJunction = (Junction) orJunction.getChildren().get(1);
        Assert.assertEquals(Junction.AND, andJunction.getType());

        MethodCall addressCall = (MethodCall) andJunction.getChildren().get(0);
        Assert.assertEquals("address", addressCall.getPath().get(0));
        Assert.assertEquals("is", addressCall.getName());
        Assert.assertEquals(1249.3423, addressCall.getArgs().get(0).getValue());

        MethodCall daCall = (MethodCall) andJunction.getChildren().get(1);
        Assert.assertEquals(0, daCall.getPath().size());
        Assert.assertEquals("da", daCall.getName());
        Assert.assertEquals("hell\\\"21321", daCall.getArgs().get(0).getValue());
        Assert.assertEquals(true, daCall.getArgs().get(1).getValue());
        Assert.assertNull(daCall.getArgs().get(3).getValue());

        MethodCall funCall = (MethodCall) daCall.getArgs().get(2).getValue();
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
