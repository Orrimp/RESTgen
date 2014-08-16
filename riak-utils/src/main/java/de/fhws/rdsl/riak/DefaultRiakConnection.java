package de.fhws.rdsl.riak;

import java.io.IOException;
import java.util.List;

import com.basho.riak.client.IRiakObject;
import com.basho.riak.client.raw.FetchMeta;
import com.basho.riak.client.raw.RawClient;
import com.basho.riak.client.raw.RiakResponse;
import com.basho.riak.client.raw.StoreMeta;
import com.basho.riak.client.raw.query.indexes.IndexQuery;

import de.fhws.rdsl.riak.solr.RiakSolrClient;
import de.fhws.rdsl.riak.solr.RiakSolrResponse;

public class DefaultRiakConnection implements RiakConnection {

    private RawClient client;
    private RiakSolrClient solrClient;

    public DefaultRiakConnection(RiakSolrClient solrClient, RawClient client) {
        this.client = client;
        this.solrClient = solrClient;
    }

    @Override
    public void close() throws Exception {
        // Nothing
    }

    @Override
    public RiakResponse fetch(String bucket, String key) throws IOException {
        return this.client.fetch(bucket, key);

    }

    @Override
    public void store(IRiakObject riakObject) throws IOException {
        this.client.store(riakObject);

    }

    @Override
    public RiakResponse head(String bucket, String key, FetchMeta fetchMeta) throws IOException {
        return this.client.head(bucket, key, fetchMeta);
    }

    @Override
    public void delete(String bucket, String key) throws IOException {
        this.client.delete(bucket, key);
    }

    /**
     * http://basho.com/counters-in-riak-1-4/
     */
    @Override
    public Long incrementCounter(String bucket, String counter, long increment, StoreMeta meta) throws IOException {
        return this.client.incrementCounter(bucket, counter, increment, meta);
    }

    /**
     * http://basho.com/counters-in-riak-1-4/
     */
    @Override
    public Long fetchCounter(String bucket, String counter, FetchMeta meta) throws IOException {
        return this.client.fetchCounter(bucket, counter, meta);
    }

    @Override
    public List<String> fetchIndex(IndexQuery indexQuery) throws IOException {
        return this.client.fetchIndex(indexQuery);
    }

    @Override
    public RiakSolrResponse query(String index, String query) throws IOException {
        return this.solrClient.query(index, query);
    }

    @Override
    public void deleteByQuery(String index, String query) throws IOException {
        this.solrClient.delete(index, query);

    }

    @Override
    public boolean contains(String bucket, String key) throws IOException {
        RiakResponse response = head(bucket, key, null);
        if (response.getRiakObjects().length == 0) {
            return false;
        } else {
            return true;
        }
    }

}
