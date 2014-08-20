package de.fhws.rdsl.riak;

import java.io.IOException;
import java.util.List;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.junit.Assert;
import org.junit.Test;

import de.fhws.rdsl.riak.DefaultRiakSolrClient;
import de.fhws.rdsl.riak.Doc;
import de.fhws.rdsl.riak.RiakSolrClient;
import de.fhws.rdsl.riak.RiakSolrResponse;

public class RiakSolrClientTest {

    private String host = "riak";
    private int port = 10018;
    private String bucket = "solrtests3";

    @Test
    public void test01() throws ClientProtocolException, IOException, JSONException {
        String key = createKey();
        putTestData(key);
        try (RiakSolrClient client = new DefaultRiakSolrClient(this.host, this.port)) {
            String query = "name:" + key;
            System.out.println(query);
            client.putHook(this.bucket);
            {
                RiakSolrResponse response = client.query(this.bucket, "q=" + query);
                Assert.assertEquals(1, response.getNumFound());
                List<Doc> docs = response.getDocs();
                Assert.assertEquals(1, docs.size());
                Assert.assertEquals(key, docs.get(0).getId());
                Assert.assertEquals(key, docs.get(0).getFields().getString("name"));
            }
            // Now delete
            {
                client.delete(this.bucket, query);
                RiakSolrResponse response = client.query(this.bucket, "q=" + query);
                Assert.assertEquals(0, response.getNumFound());
            }

        }
    }

    private void putTestData(String key) throws ClientProtocolException, IOException {
        HttpClient client = new DefaultHttpClient();
        HttpPut put = new HttpPut("http://" + this.host + ":" + this.port + "/riak/" + this.bucket + "/" + key);
        put.setEntity(new StringEntity("{\"name\": \"" + key + "\"}", ContentType.APPLICATION_JSON));
        System.out.println(client.execute(put));
        HttpClientUtils.closeQuietly(client);
    }

    private String createKey() {
        return "testing" + System.currentTimeMillis();
    }

}
