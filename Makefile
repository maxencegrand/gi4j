JAVAC=javac
JAR=jar
FLAGS=-Xlint:unchecked
SRC_PATH=src/main/java/
CLASSPATH=./lib/pddl4j-4.0.jar:./lib/generator-1.0.jar
SRC=${wildcard ${SRC_PATH}fr/uga/amlsi/gi4plan/*.java} \
	${wildcard ${SRC_PATH}fr/uga/amlsi/gi4plan/automata/*.java} \
	${wildcard ${SRC_PATH}fr/uga/amlsi/gi4plan/gi/*.java} \
	${wildcard ${SRC_PATH}fr/uga/amlsi/gi4plan/gi/regular/*.java}


PACKAGES= fr.uga.amlsi.gi4plan fr.uga.amlsi.gi4plan.automata fr.uga.amlsi.gi4plan.gi fr.uga.amlsi.gi4plan.gi.regular
CLASSES=${SRC:src/%.java=%.class}

install: build javadoc

all: build

init: clean
	@mkdir build
	@mkdir build/classes

compile: init
	@echo "Compile"
	@$(JAVAC) -O -Xpkginfo:always -d build/classes -classpath $(CLASSPATH) -sourcepath $(SRC_PATH) ${SRC}

build: compile
	@echo "Build"
	@touch MANIFEST.MF
	@echo "Main-Class: fr.uga.amlsi.gi4plan.App" > MANIFEST.MF
	@echo "Class-Path: ${CLASSPATH} classes" >> MANIFEST.MF
	@mkdir ./build/lib
	@cp -r ./lib/*.jar ./build/lib
	@${JAR} cvfm build/gi4plan-1.0.jar MANIFEST.MF -C build/classes .

javadoc: build
	mkdir build/javadoc
	javadoc -cp ${SRC_PATH}:${CLASSPATH} -d build/javadoc ${PACKAGES}

clean:
	@echo "Clean"
	@rm -rf build/classes
	@rm -rf build
	@rm -f MANIFEST.MF
