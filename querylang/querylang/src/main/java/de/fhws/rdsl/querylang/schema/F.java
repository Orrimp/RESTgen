package de.fhws.rdsl.querylang.schema;

import java.util.function.Function;
import java.util.stream.Stream;

/**
 * Provides various high-order functions.
 */
public final class F {
    /**
     * When the returned {@code Function} is passed as an argument to
     * {@link Stream#flatMap}, the result is a stream of instances of
     * {@code cls}.
     */
    public static <E> Function<Object, Stream<E>> instancesOf(Class<E> cls) {
        return o -> cls.isInstance(o) ? Stream.of((E) o) : Stream.empty();
    }
}