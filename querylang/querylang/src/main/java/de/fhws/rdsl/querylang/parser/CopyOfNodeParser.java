package de.fhws.rdsl.querylang.parser;
//package lsotnk.querylang.parser;
//
//import java.io.IOException;
//import java.io.InputStream;
//import java.util.stream.Collectors;
//
//import lsotnk.querylang.Arg;
//import lsotnk.querylang.Binary;
//import lsotnk.querylang.BooleanArg;
//import lsotnk.querylang.DoubleArg;
//import lsotnk.querylang.IntegerArg;
//import lsotnk.querylang.Junction;
//import lsotnk.querylang.MethodCall;
//import lsotnk.querylang.Negation;
//import lsotnk.querylang.Node;
//import lsotnk.querylang.NullArg;
//import lsotnk.querylang.Path;
//import lsotnk.querylang.StringArg;
//import lsotnk.querylang.parser.QueryParser.AndExprContext;
//import lsotnk.querylang.parser.QueryParser.CallExprContext;
//import lsotnk.querylang.parser.QueryParser.CompExprContext;
//import lsotnk.querylang.parser.QueryParser.ConstantContext;
//import lsotnk.querylang.parser.QueryParser.ExprContext;
//import lsotnk.querylang.parser.QueryParser.NotExprContext;
//import lsotnk.querylang.parser.QueryParser.OrExprContext;
//import lsotnk.querylang.parser.QueryParser.PathExprContext;
//
//import org.antlr.v4.runtime.ANTLRInputStream;
//import org.antlr.v4.runtime.CommonTokenStream;
//
//public class CopyOfNodeParser {
//
//    public Node parse(InputStream is) throws IOException {
//        QueryLexer lexer = new QueryLexer(new ANTLRInputStream(is));
//        QueryParser parser = new QueryParser(new CommonTokenStream(lexer));
//        ExprContext exprContext = parser.expr();
//        System.out.println(exprContext.toStringTree());
//        return exprContext.accept(new Visitor());
//    }
//
//    private class Visitor extends QueryBaseVisitor<Node> {
//
//        @Override
//        public Node visitConstant(ConstantContext ctx) {
//            if (ctx.INT() != null) {
//                return new IntegerArg(Integer.parseInt(ctx.INT().getText()));
//            } else if (ctx.FLOAT() != null) {
//                return new DoubleArg(Double.parseDouble(ctx.FLOAT().getText()));
//            } else if (ctx.TRUE() != null) {
//                return new BooleanArg(Boolean.TRUE);
//            } else if (ctx.FALSE() != null) {
//                return new BooleanArg(Boolean.FALSE);
//            } else if (ctx.QUOTED_STRING() != null) {
//                return new StringArg(unquoteString(ctx.QUOTED_STRING().getText()));
//            } else {
//                return new NullArg();
//            }
//        }
//
//        @Override
//        public Node visitPathExpr(PathExprContext ctx) {
//            Path path = new Path();
//            path.getParts().addAll(ctx.ID().stream().map(terminal -> terminal.getText()).collect(Collectors.toList()));
//            return path;
//        }
//
//        @Override
//        public Node visitAndExpr(AndExprContext ctx) {
//            Junction andJunction = new Junction(Junction.AND);
//            andJunction.getChildren().add(visit(ctx.expr(0)));
//            andJunction.getChildren().add(visit(ctx.expr(1)));
//            return andJunction;
//        }
//
//        @Override
//        public Node visitNotExpr(NotExprContext ctx) {
//            Negation negation = new Negation();
//            negation.setNode(visit(ctx.expr()));
//            return negation;
//        }
//
//        @Override
//        public Node visitOrExpr(OrExprContext ctx) {
//            Junction orJunction = new Junction(Junction.OR);
//            orJunction.getChildren().add(visit(ctx.expr(0)));
//            orJunction.getChildren().add(visit(ctx.expr(1)));
//            return orJunction;
//        }
//
//        @Override
//        public Node visitCompExpr(CompExprContext ctx) {
//            Binary binary = new Binary();
//            binary.setLeft(visit(ctx.expr(0)));
//            binary.setRight(visit(ctx.expr(1)));
//            return binary;
//        }
//
//        @Override
//        public Node visitCallExpr(CallExprContext ctx) {
//            MethodCall call = new MethodCall();
//            if (ctx.args() != null) {
//                for (ConstantContext constantCtx : ctx.args().constant()) {
//                    call.getArgs().add((Arg<?>) visitConstant(constantCtx));
//                }
//            }
//            call.setPath((Path) visitPathExpr(ctx.pathExpr()));
//            return call;
//        }
//    }
//
//    private String unquoteString(String original) {
//        StringBuilder unquoted = new StringBuilder();
//        char[] chs = original.toCharArray();
//        boolean ignore = false;
//        for (int i = 0; i < chs.length; i++) {
//            if (i == 0) {
//                continue;
//            }
//            if (i == chs.length - 1) {
//                continue;
//            }
//            if (chs[i] == '\\' && !ignore) {
//                ignore = true;
//                continue;
//            }
//            if (ignore) {
//                ignore = false;
//            }
//            unquoted.append(chs[i]);
//        }
//        return unquoted.toString();
//
//    }
// }
