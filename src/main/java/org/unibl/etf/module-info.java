module org.unibl.etf {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;

    opens org.unibl.etf to javafx.fxml;
    exports org.unibl.etf;
}
