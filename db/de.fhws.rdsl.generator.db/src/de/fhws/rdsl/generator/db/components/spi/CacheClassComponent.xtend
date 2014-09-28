package de.fhws.rdsl.generator.db.components.spi

import de.fhws.rdsl.workflow.JavaClass
import de.fhws.rdsl.generator.db.workflow.AbstractComponent

class CacheClassComponent extends AbstractComponent {

	override protected createJavaClass() {
		return new JavaClass => [
			name = "Cache"
			pckg = dbSpiPckg
			content = '''
				public interface «name» {
				
					boolean put(CacheEntry<?>... entries);
				
					boolean remove(CacheKey... keys);
				
					<T> CacheEntry<T> get(CacheKey key);
				
					public static class CacheEntry<T> {
				
						private CacheKey key;
						private T value;
				
						public CacheEntry(CacheKey key, T value) {
							super();
							this.key = key;
							this.value = value;
						}
				
						public CacheKey getKey() {
							return this.key;
						}
				
						public T getValue() {
							return this.value;
						}
				
					}
				
					public static class CacheKey {
				
						private Object bucket;
						private Object key;
				
						public CacheKey(Object bucket, Object key) {
							super();
							this.bucket = bucket;
							this.key = key;
						}
				
						public Object getBucket() {
							return this.bucket;
						}
				
						public Object getKey() {
							return this.key;
						}
				
					}
				
				}
			'''
		]
	}

}
