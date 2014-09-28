package de.fhws.rdsl.riak;

import org.json.JSONObject;

public interface JSONConverter {

    JSONObject fromBytes(byte[] bytes, String encoding);

    byte[] toBytes(JSONObject jsonObject, String encoding);

}
