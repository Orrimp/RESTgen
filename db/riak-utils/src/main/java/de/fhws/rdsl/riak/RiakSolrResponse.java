package de.fhws.rdsl.riak;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class RiakSolrResponse {
    private long numFound;
    private List<Doc> docs;

    public RiakSolrResponse(long numFound, List<Doc> docs) {
        super();
        this.numFound = numFound;
        this.docs = docs;
    }

    public List<Doc> getDocs() {
        return this.docs;
    }

    public long getNumFound() {
        return this.numFound;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}