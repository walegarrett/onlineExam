package com.wale.exam.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;


import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class JsonUtil {
    private static final ObjectMapper MAPPER = new ObjectMapper();


    public static <T> String toJsonStr(T o) {
        try {
            return MAPPER.writeValueAsString(o);
        } catch (JsonProcessingException e) {

        }
        return null;
    }

    public static <T> T toJsonObject(String json, Class<T> valueType) {
        try {
            return MAPPER.<T>readValue(json, valueType);
        } catch (IOException e) {

        }
        return null;
    }


    public static <T> List<T> toJsonListObject(String json, Class<T> valueType) {
        try {
            JavaType getCollectionType = MAPPER.getTypeFactory().constructParametricType(List.class, valueType);
            List<T> list = MAPPER.readValue(json, getCollectionType);
            return list;
        } catch (IOException e) {
        }
        return null;
    }

    public static <T> T toJsonObject(InputStream stream, Class<T> valueType) {
        try {
            T object = MAPPER.<T>readValue(stream, valueType);
            return object;
        } catch (IOException e) {
        }
        return null;
    }
}
