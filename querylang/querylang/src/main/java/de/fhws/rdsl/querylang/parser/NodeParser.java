package de.fhws.rdsl.querylang.parser;

import java.io.IOException;
import java.io.Reader;

public interface NodeParser {

    Node parse(Reader is) throws IOException;

}