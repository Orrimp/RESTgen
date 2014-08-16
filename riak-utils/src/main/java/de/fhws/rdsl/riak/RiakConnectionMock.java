package de.fhws.rdsl.riak;

import static com.google.common.collect.Maps.newHashMap;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.basho.riak.client.DefaultRiakObject;
import com.basho.riak.client.IRiakObject;
import com.basho.riak.client.query.indexes.RiakIndexes;
import com.basho.riak.client.raw.FetchMeta;
import com.basho.riak.client.raw.RiakResponse;
import com.basho.riak.client.raw.StoreMeta;
import com.basho.riak.client.raw.query.indexes.IndexQuery;

import de.fhws.rdsl.riak.solr.RiakSolrResponse;

public class RiakConnectionMock implements RiakConnection {

    private Map<String, IRiakObject> objects = newHashMap();
    private Map<String, Long> counters = newHashMap();

    public RiakConnectionMock() {
        this.objects.put("testing.key1", new RiakObjectMock("testing", "key1"));
        this.objects.put("testing.key2", new RiakObjectMock("testing", "key2"));
    }

    @Override
    public void close() throws Exception {
    }

    @Override
    public RiakResponse fetch(String bucket, String key) throws IOException {
        IRiakObject object = this.objects.get(bucket + "." + key);
        return new RiakResponse(new byte[0], object == null ? new IRiakObject[0] : new IRiakObject[] { object });
    }

    @Override
    public RiakResponse head(String bucket, String key, FetchMeta fetchMeta) throws IOException {
        return fetch(bucket, key);
    }

    @Override
    public void delete(String bucket, String key) throws IOException {
        this.objects.remove(bucket + "." + key);

    }

    @Override
    public void store(IRiakObject riakObject) throws IOException {
        this.objects.put(riakObject.getBucket() + "." + riakObject.getKey(), riakObject);
    }

    @Override
    public Long incrementCounter(String bucket, String counter, long increment, StoreMeta meta) throws IOException {
        String key = bucket + "." + counter;
        if (!this.counters.containsKey(key)) {
            this.counters.put(key, 0L);
        }
        Long value = this.counters.get(key);
        value = value + increment;
        this.counters.put(key, value);
        return value;
    }

    @Override
    public Long fetchCounter(String bucket, String counter, FetchMeta meta) throws IOException {
        return this.counters.get(bucket + "." + counter);
    }

    static class RiakObjectMock extends DefaultRiakObject {

        public RiakObjectMock(String bucket, String key) {
            super(bucket, key, null, null, new Date(), "application/json", new byte[0], Collections.EMPTY_LIST, Collections.EMPTY_MAP, new RiakIndexes(), false);
        }

    }

    @Override
    public List<String> fetchIndex(IndexQuery indexQuery) throws IOException {
        return Collections.emptyList();
    }

    @Override
    public RiakSolrResponse query(String index, String query) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public void deleteByQuery(String index, String query) throws IOException {
        // TODO Auto-generated method stub

    }

    @Override
    public boolean contains(String bucket, String key) throws IOException {
        return this.objects.containsKey(bucket + "." + key);
    }
}