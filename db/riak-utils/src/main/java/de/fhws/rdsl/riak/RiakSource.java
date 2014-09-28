package de.fhws.rdsl.riak;


public interface RiakSource {

    RiakConnection getConnection();

    void dispose();

}
