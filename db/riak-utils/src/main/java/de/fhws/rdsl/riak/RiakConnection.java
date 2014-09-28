package de.fhws.rdsl.riak;

import java.io.IOException;
import java.util.List;

import com.basho.riak.client.IRiakObject;
import com.basho.riak.client.raw.FetchMeta;
import com.basho.riak.client.raw.RiakResponse;
import com.basho.riak.client.raw.StoreMeta;
import com.basho.riak.client.raw.query.indexes.IndexQuery;

public interface RiakConnection extends AutoCloseable {

    RiakResponse fetch(String bucket, String key) throws IOException;

    RiakResponse head(String bucket, String key, FetchMeta fetchMeta) throws IOException;

    void delete(String bucket, String key) throws IOException;

    void store(IRiakObject riakObject) throws IOException;

    Long incrementCounter(String bucket, String counter, long increment, StoreMeta meta) throws IOException;

    Long fetchCounter(String bucket, String counter, FetchMeta meta) throws IOException;

    List<String> fetchIndex(IndexQuery indexQuery) throws IOException;

    RiakSolrResponse query(String index, String query) throws IOException;

    void deleteByQuery(String index, String query) throws IOException;

    boolean contains(String bucket, String key) throws IOException;

}
