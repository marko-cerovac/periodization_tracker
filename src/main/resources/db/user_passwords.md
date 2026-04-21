# User passwords script

This script is used to generate the __password hashes__
for the users of the database.
Compile it _manually_ and use it _manually_.

```java
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Map;
import java.util.LinkedHashMap;

public class UserPasswords {
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes(StandardCharsets.UTF_8));

            return Base64.getEncoder().encodeToString(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String args[]) {

        Map<String, String> users = new LinkedHashMap<>();

        users.putIfAbsent("anatoly_pisarenko", hashPassword("anatoly"));
        users.putIfAbsent("vasily_alexeev", hashPassword("vasily"));
        users.putIfAbsent("asen_zlatev", hashPassword("asen"));
        users.putIfAbsent("naim_suleymanoglu", hashPassword("naim"));
        users.putIfAbsent("piros_dimas", hashPassword("piros"));
        users.putIfAbsent("valerios_leonidis", hashPassword("valerios"));

        users.forEach((k, v) -> System.out.println("username: " + k + ", hash: " + v));
    }
}
```
