package de.fhws.rdsl.workflow;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class Context {

	private Map<String, Object> map = Maps.newHashMap();
	private List<File> files = Lists.newArrayList();

	public Object get(String key) {
		return this.map.get(key);
	}

	public <T> T get(String key, Class<T> clazz) {
		return (T) this.map.get(key);
	}

	public String getString(String key) {
		return String.valueOf(this.map.get(key));
	}

	public void put(String key, Object obj) {
		this.map.put(key, obj);
	}

	public void addFile(File file) {
		this.files.add(file);
	}

	public List<File> getFiles() {
		return Collections.unmodifiableList(this.files);
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}

}
