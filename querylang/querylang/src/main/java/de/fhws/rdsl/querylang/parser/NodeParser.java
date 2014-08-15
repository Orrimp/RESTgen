package de.fhws.rdsl.querylang.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.List;
import java.util.stream.Collectors;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import de.fhws.rdsl.querylang.parser.QueryParser.ArgContext;
import de.fhws.rdsl.querylang.parser.QueryParser.ArgsContext;
import de.fhws.rdsl.querylang.parser.QueryParser.CallContext;
import de.fhws.rdsl.querylang.parser.QueryParser.ExpressionContext;
import de.fhws.rdsl.querylang.parser.QueryParser.FactorContext;
import de.fhws.rdsl.querylang.parser.QueryParser.ParensContext;
import de.fhws.rdsl.querylang.parser.QueryParser.TermContext;

public class NodeParser {

    public List<Node> parse(Reader is) throws IOException {
        QueryLexer lexer = new QueryLexer(new ANTLRInputStream(is));
        QueryParser parser = new QueryParser(new CommonTokenStream(lexer));
        return parser.expressions().expression().stream().map(expression -> parse(expression)).collect(Collectors.toList());
    }

    public Node parse(ExpressionContext expressionContext) {
        if (expressionContext.term().size() > 1) {
            Junction orJunction = new Junction(Junction.OR);
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
            Junction andJunction = new Junction(Junction.AND);
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
        } else {
            return parse(factorContext.parens());
        }
    }

    private Node parse(ParensContext parensContext) {
        return parse(parensContext.expression());
    }

    protected MethodCall createMethodCall(String name) {
        MethodCall methodCall = new MethodCall();
        methodCall.setName(name);
        return methodCall;
    }

    private Node parse(CallContext callContext) {
        List<String> parts = callContext.path().ID().stream().map(terminal -> terminal.getText()).collect(Collectors.toList());
        MethodCall methodCall = createMethodCall(parts.get(parts.size() - 1));
        for (int i = 0; i < parts.size() - 1; i++) {
            methodCall.getPath().add(parts.get(i));
        }
        if (callContext.args() != null) {
            methodCall.getArgs().addAll(parse(callContext.args()));
        }
        return methodCall;
    }

    private List<Arg<?>> parse(ArgsContext argsContext) {
        return argsContext.arg().stream().map(argContext -> parse(argContext)).collect(Collectors.toList());
    }

    private Arg<?> parse(ArgContext argContext) {
        if (argContext.INT() != null) {
            return new IntegerArg(Integer.parseInt(argContext.INT().getText()));
        } else if (argContext.FLOAT() != null) {
            return new DoubleArg(Double.parseDouble(argContext.FLOAT().getText()));
        } else if (argContext.TRUE() != null) {
            return new BooleanArg(Boolean.TRUE);
        } else if (argContext.FALSE() != null) {
            return new BooleanArg(Boolean.FALSE);
        } else if (argContext.QUOTED_STRING() != null) {
            return new StringArg(unquoteString(argContext.QUOTED_STRING().getText()));
        } else if (argContext.NULL() != null) {
            return new NullArg();
        } else {
            return new NodeArg(parse(argContext.expression()));
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
