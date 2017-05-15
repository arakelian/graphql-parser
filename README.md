# graphql-parser

Low-level GraphQL parser and lexer generated using ANTLR grammar.

The grammar was [originally based on](https://github.com/graphql-java/graphql-java/blob/master/src/main/antlr/Graphql.g4) the GraphQL grammar defined by the [graphql-java](https://github.com/graphql-java/graphql-java) project.

This project separates the lexer and parser grammars, and has additional changes to enable better runtime validation.

## Installation

The library is available on Maven Central

### Maven

Add the following to your `pom.xml`:

```xml
<repositories>
    <repository>
        <id>central</id>
        <name>Central Repository</name>
        <url>http://repo.maven.apache.org/maven2</url>
        <releases>
            <enabled>true</enabled>
        </releases>
    </repository>
</repositories>

...

<dependency>
    <groupId>com.arakelian</groupId>
    <artifactId>graphql-parser</artifactId>
    <version>1.0.8</version>
    <scope>test</scope>
</dependency>
```

### Gradle

Add the following to your `build.gradle`:

```groovy
repositories {
  mavenCentral()
}

dependencies {
  testCompile 'com.arakelian:graphql-parser:1.0.8'
}
```

## Licence

Apache Version 2.0
