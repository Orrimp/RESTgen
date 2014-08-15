package de.fhws.rdsl.querylang.sql;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.net.URL;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import com.google.common.base.Charsets;
import com.google.common.base.Joiner;
import com.google.common.collect.Lists;
import com.google.common.io.Files;

import de.fhws.rdsl.querylang.Element;
import de.fhws.rdsl.querylang.ElementToStringTransformerContext;
import de.fhws.rdsl.querylang.NodeToElementTransformerContext;
import de.fhws.rdsl.querylang.parser.Node;
import de.fhws.rdsl.querylang.parser.NodeParser;
import de.fhws.rdsl.querylang.schema.Type;
import de.fhws.rdsl.querylang.schema.Utils;

public class SQLTransformerTest extends AbstractSQLTransformerTest {

    @Test
    public void test01() {
        doTest("querytest01.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test02() {
        doTest("querytest02.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test03() {
        doTest("querytest03.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test04() {
        doTest("querytest04.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test05() {
        doTest("querytest05.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test06() {
        doTest("querytest06.txt", "company", Lists.newArrayList("123"));
    }

    @Test
    public void test07() {
        doTest("querytest07.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test08() {
        doTest("querytest08.txt", "PersonManagedCompanyManager", Lists.newArrayList("123"));
    }

    @Test
    public void test09() {
        doTest("querytest09.txt", "address", Lists.newArrayList("123"));
    }

    @Test
    public void test10() {
        doTest("querytest10.txt", "AddressTags", Lists.newArrayList("123", "789"));
    }

    @Test
    public void test11() {
        doTest("querytest11.txt", "dummy1", Lists.newArrayList("123", "789"));
    }

    private void doTest(String fileName, String contextType, List<Object> keys) {
        String query = getQuery(fileName);
        String expected = getExpected(fileName);
        String actual = getActual(query, contextType, keys);
        System.out.println("========" + fileName + "================");
        System.out.println("Query: " + query);
        System.out.println("\nExpected:\n" + expected);
        System.out.println("\nActual:\n" + actual);
        Assert.assertEquals(expected, actual);
    }

    private String getQuery(String fileName) {
        URL url = getClass().getResource("/" + fileName);
        try {
            return Files.readFirstLine(new File(url.getFile()), Charsets.UTF_8);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private String getExpected(String fileName) {
        URL url = getClass().getResource("/" + fileName);
        try {
            List<String> lines = Files.readLines(new File(url.getFile()), Charsets.UTF_8);
            lines.remove(0);
            lines.remove(0);
            return Joiner.on('\n').join(lines);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private String getActual(String query, String contextType, List<Object> keys) {
        List<Type> types = createTypes();
        NodeParser parser = new NodeParser();
        List<Node> nodes;
        try {
            nodes = parser.parse(new StringReader(query));
            NodeToElementTransformerContext nodeContext = new NodeToElementTransformerContext(Utils.findTypeByName(contextType, types), types, keys, new SQLFunctionProvider());
            SQLNodeToElementConverter nodeToElementConverter = new SQLNodeToElementConverter();
            Element element = nodeToElementConverter.getElement(nodes.get(0), nodeContext);
            ElementToStringTransformerContext elementContext = new ElementToStringTransformerContext(new SQLFormatterProvider());
            SQLElementToStringConverter elementToStringConverter = new SQLElementToStringConverter();
            return elementToStringConverter.getString(element, elementContext);
        } catch (IOException e) {
            throw new RuntimeException();
        }

    }

}
