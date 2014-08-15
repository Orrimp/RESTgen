package de.fhws.rdsl.querylang.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.List;
import java.util.stream.Collectors;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import de.fhws.rdsl.querylang.antlr.QueryLexer;
import de.fhws.rdsl.querylang.antlr.QueryParser;
import de.fhws.rdsl.querylang.antlr.QueryParser.ArgContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.ArgsContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.CallContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.ExpressionContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.FactorContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.LiteralContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.ParensContext;
import de.fhws.rdsl.querylang.antlr.QueryParser.TermContext;

public class DefaultNodeParser implements NodeParser {

    /*
     * (non-Javadoc)
     *
     * @see de.fhws.rdsl.querylang.parser.NodeParser#parse(java.io.Reader)
     */
    @Override
    public Node parse(Reader is) throws IOException {
        QueryLexer lexer = new QueryLexer(new ANTLRInputStream(is));
        QueryParser parser = new QueryParser(new CommonTokenStream(lexer));
        return parser.expressions().expression().stream().map(expression -> parse(expression)).collect(Collectors.toList()).get(0);
    }

    public Node parse(ExpressionContext expressionContext) {
        if (expressionContext.term().size() > 1) {
            JunctionNode orJunction = new JunctionNode(JunctionNode.OR);
            for (TermContext termContext : expressionContext.term()) {
                orJunction.getChildren().add(parse(termContext));
            }
            return orJunction;
        } else {
            return parse(expressionContext.term(0));
        }
    }

    private Node parse(TermContext termContext) {
        if (termContext.factor().size() > 1) {
            JunctionNode andJunction = new JunctionNode(JunctionNode.AND);
            for (FactorContext factorContext : termContext.factor()) {
                andJunction.getChildren().add(parse(factorContext));
            }
            return andJunction;
        } else {
            return parse(termContext.factor(0));
        }
    }

    private Node parse(FactorContext factorContext) {
        if (factorContext.call() != null) {
            return parse(factorContext.call());
        } else if (factorContext.literal() != null) {
            return parse(factorContext.literal());
        } else {
            return parse(factorContext.parens());
        }
    }

    private Node parse(ParensContext parensContext) {
        return parse(parensContext.expression());
    }

    protected FunctionNode createMethodCall(String name) {
        FunctionNode methodCall = new FunctionNode();
        methodCall.setName(name);
        return methodCall;
    }

    private Node parse(CallContext callContext) {
        List<String> parts = callContext.path().ID().stream().map(terminal -> terminal.getText()).collect(Collectors.toList());
        FunctionNode methodCall = createMethodCall(parts.get(parts.size() - 1));
        for (int i = 0; i < parts.size() - 1; i++) {
            methodCall.getPath().add(parts.get(i));
        }
        if (callContext.args() != null) {
            methodCall.getArgs().addAll(parse(callContext.args()));
        }
        return methodCall;
    }

    private List<Node> parse(ArgsContext argsContext) {
        return argsContext.arg().stream().map(argContext -> parse(argContext)).collect(Collectors.toList());
    }

    private Node parse(ArgContext argContext) {
        return parse(argContext.factor());
    }

    private LiteralNode<?> parse(LiteralContext literalContext) {
        if (literalContext.INT() != null) {
            return new IntegerLiteralNode(Integer.parseInt(literalContext.INT().getText()));
        } else if (literalContext.FLOAT() != null) {
            return new FloatLiteralNode(Double.parseDouble(literalContext.FLOAT().getText()));
        } else if (literalContext.TRUE() != null) {
            return new BooleanLiteralNode(Boolean.TRUE);
        } else if (literalContext.FALSE() != null) {
            return new BooleanLiteralNode(Boolean.FALSE);
        } else if (literalContext.QUOTED_STRING() != null) {
            return new StringLiteralNode(unquoteString(literalContext.QUOTED_STRING().getText()));
        } else if (literalContext.NULL() != null) {
            return new NullLiteralNode();
        } else {
            throw new RuntimeException();
        }
    }

    private String unquoteString(String original) {
        StringBuilder unquoted = new StringBuilder();
        char[] chs = original.toCharArray();
        boolean ignore = false;
        for (int i = 0; i < chs.length; i++) {
            if (i == 0) {
                continue;
            }
            if (i == chs.length - 1) {
                continue;
            }
            if (chs[i] == '\\' && !ignore) {
                ignore = true;
                continue;
            }
            if (ignore) {
                ignore = false;
            }
            unquoted.append(chs[i]);
        }
        return unquoted.toString();

    }
}
