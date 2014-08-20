package de.fhws.rdsl.riak;

import java.io.IOException;

import com.basho.riak.client.raw.RawClient;
import com.basho.riak.client.raw.pbc.PBClientConfig;
import com.basho.riak.client.raw.pbc.PBRiakClientFactory;

public class DefaultRiakSource implements RiakSource {

    private String host = null;
    private int port = 10017;
    private int poolSize = 5;
    private int queryPoolSize = 5;
    private int queryPort = 10018;

    protected RawClient client = null;
    protected RiakSolrClient solrClient = null;

    public int getQueryPoolSize() {
        return this.queryPoolSize;
    }

    public int getQueryPort() {
        return this.queryPort;
    }

    public void setQueryPoolSize(int queryPoolSize) {
        this.queryPoolSize = queryPoolSize;
    }

    public void setQueryPort(int queryPort) {
        this.queryPort = queryPort;
    }

    public String getHost() {
        return this.host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public int getPort() {
        return this.port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public int getPoolSize() {
        return this.poolSize;
    }

    public void setPoolSize(int poolSize) {
        this.poolSize = poolSize;
    }

    @Override
    public synchronized RiakConnection getConnection() {
        try {
            return new DefaultRiakConnection(buildSolrClient(), buildClient());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    protected RawClient buildClient() throws IOException {
        if (this.client == null) {
            PBClientConfig config = new PBClientConfig.Builder().withHost(this.host).withPort(this.port).withPoolSize(this.poolSize).build();
            this.client = PBRiakClientFactory.getInstance().newClient(config);
        }
        return this.client;
    }

    protected RiakSolrClient buildSolrClient() {
        if (this.solrClient == null) {
            this.solrClient = new DefaultRiakSolrClient(this.host, this.queryPort);
        }
        return this.solrClient;
    }

    @Override
    public void dispose() {
        if (this.client != null) {
            this.client.shutdown();
        }
        if (this.solrClient != null) {
            try {
                this.solrClient.close();
            } catch (Throwable e) {
                // nothing
            }
        }
    }

}
