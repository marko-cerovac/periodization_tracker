package org.unibl.etf;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

import org.unibl.etf.util.PasswordHasher;

public class App extends Application {

    @Override
    public void start(Stage stage) throws IOException {

        System.out.println("Hash for anatoly123: " + PasswordHasher.hashPassword("anatoly123"));
        System.out.println("Hash for vasily123: " + PasswordHasher.hashPassword("vaily123"));

        FXMLLoader fxmlLoader = new FXMLLoader(getClass().getResource("login.fxml"));
        Scene scene = new Scene(fxmlLoader.load());
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}
