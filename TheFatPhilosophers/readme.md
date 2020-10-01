# TheFatPhilosofers


### Explanation

This project was made to solve the problem where the guys race to acquire two forks for eating, and think while they don't have the forks.

### How to run?

If you have **Netbeans 11**, just open it and run.
Otherwise, you need **maven** and *JRE 11+* on the path.

Simply build that with the command `mvn clean package` and then run with `mvn exec:java -Dexec.args="815"`.

Alternatively, you can run directly with java:
```
 java -cp target/TheFatPhilosophers-1.0.0.jar br.com.jpe.fat.Main 1200
```

 or

```
 "%JAVA_HOME%\bin\java" -cp target/TheFatPhilosophers-1.0.0.jar br.com.jpe.fat.Main 1300
```

Obs.: the time I'm passing as parameter is the running time for the application.

I'm packaging the binaries