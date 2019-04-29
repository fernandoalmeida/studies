build:
	cd src/main/java && \
        rm -f *.class && \
	javac-coursera -cp \
	/usr/local/algs4/algs4.jar \
	*.java
run: build
	cd ${PWD}/src/main/java && java-coursera Percolation
build-test:
	cd src/test/java && \
        rm -f *.class && \
	javac-coursera -cp \
	${PWD}/src/test/java:/usr/local/algs4/algs4.jar:/usr/local/algs4/drjava.jar \
	*.java
test: build-test
	cd ${PWD}/src/main/java && java-coursera PercolationTest
