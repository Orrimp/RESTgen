package de.fhws.rdsl.query.transformer.spi;

import java.io.IOException;
import java.io.Reader;

import de.fhws.rdsl.query.transformer.spi.source.SourceNode;

public interface QueryParser {

    SourceNode parse(Reader is) throws IOException;

}