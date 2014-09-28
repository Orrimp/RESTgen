package de.fhws.rdsl.riak;

import java.io.IOException;

import org.json.JSONException;
import org.json.JSONObject;

import com.basho.riak.client.IRiakObject;
import com.basho.riak.client.RiakLink;
import com.basho.riak.client.builders.RiakObjectBuilder;

public class RiakUtils {

    private static final String UTF8 = "UTF-8";

    public static boolean contains(JSONObject object, String field) {
        try {
            Object dummy = object.get(field);
            if (dummy == JSONObject.NULL) {
                return false;
            } else {
                return true;
            }
        } catch (JSONException e) {
            return false;
        }
    }

    public static RiakLink findLink(IRiakObject riakObject, String tag) {
        if (riakObject == null) {
            return null;
        }
        for (RiakLink link : riakObject) {
            if (link.getTag().equals(tag)) {
                return link;
            }
        }
        return null;
    }

    public static JSONObject buildJSON(JSONObject jsonObject, String path) throws JSONException {
        JSONObject pathObject = null;
        try {
            pathObject = jsonObject.getJSONObject(path);
        } catch (JSONException e) {
        }
        if (pathObject == null) {
            pathObject = new JSONObject();
            jsonObject.put(path, pathObject);
        }
        return pathObject;
    }

    public static IRiakObject newRiakObject(String bucket, String key, JSONObject jsonObject, JSONConverter jsonConverter) throws JSONException {
        IRiakObject riakObject = RiakObjectBuilder.newBuilder(bucket, key).withContentType("application/json")
                .withValue(jsonConverter.toBytes(jsonObject, UTF8)).build();
        return riakObject;
    }

    public static IRiakObject updateRiakObject(IRiakObject base, JSONObject jsonObject, JSONConverter jsonConverter) throws JSONException {
        return RiakObjectBuilder.from(base).withValue(jsonConverter.toBytes(jsonObject, UTF8)).build();
    }

    public static JSONObject fetchJSON(IRiakObject riakObject, JSONConverter jsonConverter) throws IOException {
        if (riakObject != null) {
            byte[] bytes = riakObject.getValue();
            if (bytes == null || bytes.length == 0) {
                return null;
            } else {
                return jsonConverter.fromBytes(bytes, UTF8);
            }
        } else {
            return null;
        }
    }

}
