RESTgen
=======

This projekts allows to generate RESTful Jersey source code defined by a model. It uses Xtend and Xtend features to generate the source code. 


## Using RESTgen

1. Clone or download a copy of the Rajawali source code.
2. Install Xtext and Xtend Plugins in Eclipse.
2. Import the RESTgen project into Eclipse.
2.1 You need all four projects
2.2 The main project is "com.rest.rdsl" which contains the "RestDsl.xtext" 
2.3 Right click on the file and select Run as "Generating Xtext Artifacts" to genearte files for the Generators
2.4 Wait!
3. Run as Eclipse Appliation
3.1 Create a Java project in the new Eclipse instance
3.2 Add a file with the extension ".rdsl" and confirm the xtext nature. 
4. Define the REST model, save the file and wait for the stuff to be generated.


