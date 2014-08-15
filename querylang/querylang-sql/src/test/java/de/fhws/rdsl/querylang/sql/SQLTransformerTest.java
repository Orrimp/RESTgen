package de.fhws.rdsl.querylang.sql;

import java.io.File;
import java.io.IOException;
import java.net.URL;
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

public class SQLTransformerTest extends AbstractSQLTransformerTest {

    @Test
    public void test01() {
        doTest("queryPerson01.txt", "person", Lists.newArrayList(), 40l, 10l, "name");
    }

    @Test
    public void test02() {
        doTest("queryAddress01.txt", "address", Lists.newArrayList(123), 40l, 10l, null);
    }

    @Test
    public void test03() {
        doTest("queryAddressTags01.txt", "AddressTags", Lists.newArrayList(123, 789), 40l, 10l, null);
    }

    @Test
    public void test04() {
        doTest("queryCompany01.txt", "company", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test05() {
        doTest("queryCar01.txt", "car", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test06() {
        doTest("queryPerson02.txt", "person", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test07() {
        doTest("queryAddress02.txt", "address", Lists.newArrayList(123), 40l, 10l, null);
    }

    @Test
    public void test08() {
        doTest("queryPerson03.txt", "person", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test09() {
        doTest("queryCompany02.txt", "company", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test10() {
        doTest("queryPerson04.txt", "person", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test11() {
        doTest("queryCompany03.txt", "company", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test12() {
        doTest("queryCompany04.txt", "company", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test13() {
        doTest("queryCarcompaniesCompanycars01.txt", "CarcompaniesCompanycars", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test14() {
        doTest("queryCarcompaniesCompanycars02.txt", "CarcompaniesCompanycars", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test15() {
        doTest("queryCarcompaniesCompanycars03.txt", "CarcompaniesCompanycars", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test16() {
        doTest("queryCarcompaniesCompanycars04.txt", "CarcompaniesCompanycars", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test17() {
        doTest("queryCarcompaniesCompanycars05.txt", "CarcompaniesCompanycars", Lists.newArrayList(), 40l, 10l, null);
    }

    @Test
    public void test18() {
        doTest("queryAddress03.txt", "address", Lists.newArrayList("123"), 40l, 10l, null);
    }

    @Test
    public void test19() {
        doTest("queryAddress04.txt", "address", Lists.newArrayList("123"), 40l, 10l, null);
    }

    @Test
    public void test20() {
        doTest("queryAddress05.txt", "address", Lists.newArrayList("123"), 40l, 10l, null);
    }

    // @Test
    // public void test01() {
    // doTest("querytest01.txt", "person", Lists.newArrayList(), 40l, 10l,
    // null);
    // }
    //
    // @Test
    // public void test02() {
    // doTest("querytest02.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test03() {
    // doTest("querytest03.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test04() {
    // doTest("querytest04.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test05() {
    // doTest("querytest05.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test06() {
    // doTest("querytest06.txt", "company", Lists.newArrayList("123"));
    // }
    //
    // @Test
    // public void test07() {
    // doTest("querytest07.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test08() {
    // doTest("querytest08.txt", "PersonManagedCompanyManager",
    // Lists.newArrayList());
    // }
    //
    // @Test
    // public void test09() {
    // doTest("querytest09.txt", "address", Lists.newArrayList("123"), 0l, 10l,
    // "addresses.code");
    // }
    //
    // @Test
    // public void test10() {
    // doTest("querytest10.txt", "AddressTags", Lists.newArrayList("123",
    // "789"));
    // }
    //
    // @Test
    // public void test11() {
    // doTest("querytest11.txt", "dummy1", Lists.newArrayList("123", "789"));
    // }
    //
    // @Test
    // public void test12() {
    // doTest("querytest12.txt", "PersonManagedCompanyManager",
    // Lists.newArrayList());
    // }
    //
    // @Test
    // public void test13() {
    // doTest("querytest13.txt", "person", Lists.newArrayList());
    // }
    //
    // @Test
    // public void test14() {
    // doTest("querytest14.txt", "address", Lists.newArrayList(567));
    // }
    //
    // @Test
    // public void test15() {
    // doTest("querytest15.txt", "person", Lists.newArrayList());
    // }

    private void doTest(String fileName, String contextType, List<Object> keys) {
        doTest(fileName, contextType, keys, null, null, null);
    }

    private void doTest(String fileName, String contextType, List<Object> keys, Long start, Long offset, String order) {
        String query = getQuery(fileName);
        String expected = getExpected(fileName);
        String actual = getActual(query, contextType, keys, "sqlQuery", start, offset, order);
        String actualCount = getActual(query, contextType, keys, "sqlCountQuery", start, offset, order);
        System.out.println("========" + fileName + "================");
        System.out.println("Query: " + query);
        System.out.println("\nExpected:\n" + expected);
        System.out.println("\nActual:\n" + actual);
        System.out.println("\nCountQuery:\n" + actualCount);
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

    private String getActual(String text, String contextType, List<Object> keys, String mapKey, Long start, Long offset, String order) {
        DefaultQueryTransformer queryTransformer = new DefaultQueryTransformer(DefaultNodeParser::new, SQLNodeTransformer::new, SQLElementTransformer::new,
                new SQLFormatterProvider(), new SQLFunctionProvider());
        Query query = new Query();
        query.setText(text);
        query.getIdentifiers().addAll(keys);
        query.setStart(start);
        query.setOffset(offset);
        query.setOrder(order);
        List<Type> types = createTypes();
        Schema schema = new Schema(types);
        try {
            return (String) queryTransformer.transform(query, contextType, schema, Maps.newHashMap()).get(mapKey);
        } catch (IOException e) {
            throw new RuntimeException();
        }

    }

}
