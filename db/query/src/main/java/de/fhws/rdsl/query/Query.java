package de.fhws.rdsl.query;

import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.google.common.collect.Lists;

public class Query {

	private String language;
	private String text;
	private String order;
	private Long start;
	private Long size;
	private boolean orderDesc;
	private List<Object> identifiers = Lists.newArrayList();

	public void setIdentifiers(List<Object> identifiers) {
		this.identifiers = identifiers;
	}

	public List<Object> getIdentifiers() {
		return this.identifiers;
	}

	public void setOrderDesc(boolean orderDesc) {
		this.orderDesc = orderDesc;
	}

	public boolean isOrderDesc() {
		return this.orderDesc;
	}

	public Long getSize() {
		return this.size;
	}

	public Long getStart() {
		return this.start;
	}

	public String getText() {
		return this.text;
	}

	public String getOrder() {
		return this.order;
	}

	public String getLanguage() {
		return this.language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	public void setStart(Long start) {
		this.start = start;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}

}
