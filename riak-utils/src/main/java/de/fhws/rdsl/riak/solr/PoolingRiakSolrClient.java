package de.fhws.rdsl.riak.solr;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.http.client.HttpClient;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.PoolingClientConnectionManager;

/**
 * Blocks after a while. Incorrect implementation!
 */
public class PoolingRiakSolrClient extends DefaultRiakSolrClient {

    private HttpClient client;
    private int poolSize;

    public PoolingRiakSolrClient(String host, int port, int poolSize) {
        super(host, port);
        this.poolSize = poolSize;
    }

    @Override
    protected HttpClient buildClient() {
        if (this.client == null) {
            SchemeRegistry schemeRegistry = new SchemeRegistry();
            schemeRegistry.register(new Scheme("http", this.port, new PlainSocketFactory()));
            PoolingClientConnectionManager manager = new PoolingClientConnectionManager(schemeRegistry);
            manager.setDefaultMaxPerRoute(this.poolSize);
            manager.setMaxTotal(this.poolSize);
            this.log.debug("Riak Solr Client built with host = {}, port = {}, poolSize = {}", this.host, this.port, this.poolSize);
            this.client = new DefaultHttpClient(manager);
        }
        return this.client;
    }

    @Override
    public void close() {
        super.close();
        HttpClientUtils.closeQuietly(this.client);
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
