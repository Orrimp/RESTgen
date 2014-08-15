package de.fhws.rdsl.querylang.solr;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import com.google.common.base.Charsets;
import com.google.common.base.Joiner;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.io.Files;

import de.fhws.rdsl.querylang.DefaultQueryTransformer;
import de.fhws.rdsl.querylang.Query;
import de.fhws.rdsl.querylang.parser.DefaultNodeParser;
import de.fhws.rdsl.querylang.schema.Schema;
import de.fhws.rdsl.querylang.schema.Type;

public class SolrTransformerTest extends AbstractSolrTransformerTest {

    @Test
    public void test01() {
        doTest("personQuery01.txt", "person", Lists.newArrayList());
    }

    @Test
    public void test02() {
        doTest("addressQuery01.txt", "address", Lists.newArrayList(123));
    }

    @Test
    public void test03() {
        doTest("addressTagsQuery01.txt", "addressTags", Lists.newArrayList(123, 56), 100l, 40l);
    }

    @Test
    public void test04() {
        doTest("companyQuery01.txt", "company", Lists.newArrayList());
    }

    @Test
    public void test05() {
        doTest("carQuery01.txt", "car", Lists.newArrayList());
    }

    @Test
    public void test07() {
        doTest("queryCarcompaniesCompanycars01.txt", "CarcompaniesCompanycars", Lists.newArrayList());
    }

    @Test
    public void test08() {
        doTest("queryCarcompaniesCompanycars02.txt", "CarcompaniesCompanycars", Lists.newArrayList());
    }

    private void doTest(String fileName, String contextType, List<Object> keys) {
        doTest(fileName, contextType, keys, null, null);
    }

    private void doTest(String fileName, String contextType, List<Object> keys, Long start, Long offset) {
        String query = getQuery(fileName);
        String expected = getExpected(fileName);
        String actual = getActual(query, contextType, keys, start, offset);
        actual = URLDecoder.decode(actual);
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

    private String getActual(String text, String contextType, List<Object> keys, Long start, Long offset) {
        DefaultQueryTransformer queryTransformer = new DefaultQueryTransformer(DefaultNodeParser::new, SolrNodeTransformer::new, SolrElementTransformer::new,
                new SolrFormatterProvider(), new SolrFunctionProvider());
        Query query = new Query();
        query.setText(text);
        query.getIdentifiers().addAll(keys);
        query.setStart(start);
        query.setOffset(offset);
        List<Type> types = createTypes();
        Schema schema = new Schema(types);
        try {
            return (String) queryTransformer.transform(query, contextType, schema, Maps.newConcurrentMap()).get("solrQuery");
        } catch (IOException e) {
            throw new RuntimeException();
        }
    }

}
