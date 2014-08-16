package de.fhws.rdsl.riak.solr;

import java.io.Closeable;
import java.io.IOException;

public interface RiakSolrClient extends Closeable {

    RiakSolrResponse query(String index, String solrQuery) throws IOException;

    void delete(String index, String solrQuery) throws IOException;

    void putHook(String index) throws IOException;

}