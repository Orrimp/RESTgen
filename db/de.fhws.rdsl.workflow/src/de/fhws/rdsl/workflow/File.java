package de.fhws.rdsl.workflow;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class File {

	private String pckg;
	private String name;
	private String content;

	public String getContent() {
		return this.content;
	}

	public String getName() {
		return this.name;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPckg() {
		return this.pckg;
	}

	public void setPckg(String pckg) {
		this.pckg = pckg;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.SHORT_PREFIX_STYLE);
	}

}
