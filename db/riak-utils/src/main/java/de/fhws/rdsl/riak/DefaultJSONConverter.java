package de.fhws.rdsl.riak;

import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

public class DefaultJSONConverter implements JSONConverter {

    @Override
    public JSONObject fromBytes(byte[] bytes, String encoding) {
        try {
            JSONTokener tokener = new JSONTokener(new InputStreamReader(new ByteArrayInputStream(bytes), encoding));
            JSONObject root = new JSONObject(tokener);
            return root;
        } catch (UnsupportedEncodingException | JSONException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public byte[] toBytes(JSONObject jsonObject, String encoding) {
        try {
            StringWriter stringWriter = new StringWriter();
            jsonObject.write(stringWriter);
            return stringWriter.toString().getBytes(encoding);
        } catch (UnsupportedEncodingException | JSONException e) {
            throw new RuntimeException(e);
        }
    }

}
