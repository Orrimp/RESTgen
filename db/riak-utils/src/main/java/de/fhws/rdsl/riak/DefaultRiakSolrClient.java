package de.fhws.rdsl.riak;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DefaultRiakSolrClient implements RiakSolrClient {

    protected String host;
    protected int port;
    protected Logger log = LoggerFactory.getLogger(getClass());

    public DefaultRiakSolrClient(String host, int port) {
        super();
        this.host = host;
        this.port = port;
    }

    @Override
    public RiakSolrResponse query(String index, String solrQuery) throws IOException {
        String uriString = "http://" + this.host + ":" + this.port + "/solr/" + index + "/select?wt=json&" + solrQuery;
        try {
            HttpClient client = buildClient();
            this.log.debug("Solr Query via {}", uriString);
            URI uri = new URI(uriString);
            HttpUriRequest request = new HttpGet(uri);
            HttpResponse response = client.execute(request);
            byte[] bytes = consume(response.getEntity().getContent());
            return buildResponse(bytes);
        } catch (URISyntaxException | IOException | JSONException e) {
            throw new IOException("A problem occured querying " + uriString, e);
        }
    }

    @Override
    public void delete(String index, String solrQuery) throws IOException {
        String uriString = "http://" + this.host + ":" + this.port + "/solr/" + index + "/update?commit=true";
        String xmlDoc = "<delete><query>" + solrQuery + "</query></delete>";
        try {
            HttpClient client = buildClient();
            this.log.debug("Solr Delete Query via {}", uriString);
            URI uri = new URI(uriString);
            HttpPost request = new HttpPost(uri);
            request.setEntity(new StringEntity(xmlDoc, ContentType.APPLICATION_XML));
            HttpResponse response = client.execute(request);
            int statusCode = response.getStatusLine().getStatusCode();
            if (!(statusCode >= 200 && statusCode < 300)) {
                throw new IOException("Returned with status code " + statusCode);
            }
        } catch (URISyntaxException e) {
            throw new IOException("A problem occured querying " + uriString, e);
        }

    }

    @Override
    public void putHook(String index) throws IOException {
        String uriString = "http://" + this.host + ":" + this.port + "/buckets/" + index + "/props";
        String data = "{\"props\":{\"precommit\":[{\"mod\":\"riak_search_kv_hook\",\"fun\":\"precommit\"}]}}";
        HttpClient client = buildClient();
        HttpPut put = new HttpPut(uriString);
        put.setEntity(new StringEntity(data, ContentType.APPLICATION_JSON));
        HttpResponse response = client.execute(put);
        int statusCode = response.getStatusLine().getStatusCode();
        if (!(statusCode >= 200 && statusCode < 300)) {
            throw new IOException("Returned with status code " + statusCode);
        }

    }

    protected HttpClient buildClient() {
        return new DefaultHttpClient();
    }

    @Override
    public void close() {
        // nothing
    }

    private static final RiakSolrResponse buildResponse(byte[] bytes) throws UnsupportedEncodingException, JSONException {
        JSONObject object = fromBytes(bytes);
        JSONObject responseObject = object.getJSONObject("response");
        long numFound = responseObject.getLong("numFound");
        JSONArray docsArray = responseObject.getJSONArray("docs");
        List<Doc> docs = new ArrayList<Doc>();
        for (int i = 0; i < docsArray.length(); i++) {
            String id = String.valueOf(docsArray.getJSONObject(i).get("id"));
            JSONObject fieldsObject = docsArray.getJSONObject(i).getJSONObject("fields");
            docs.add(new Doc(id, fieldsObject));
        }
        return new RiakSolrResponse(numFound, docs);
    }

    private static final JSONObject fromBytes(byte[] bytes) throws JSONException, UnsupportedEncodingException {
        JSONTokener tokener = new JSONTokener(new InputStreamReader(new ByteArrayInputStream(bytes), "UTF-8"));
        JSONObject root = new JSONObject(tokener);
        return root;
    }

    private static final byte[] consume(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream(512);
        int b = -1;
        while ((b = is.read()) != -1) {
            baos.write(b);
        }
        is.close();
        return baos.toByteArray();
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }

}
