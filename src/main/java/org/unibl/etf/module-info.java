module org.unibl.etf {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires java.base;

    opens org.unibl.etf to javafx.fxml;
    opens org.unibl.etf.controller to javafx.fxml;
    exports org.unibl.etf;
}
