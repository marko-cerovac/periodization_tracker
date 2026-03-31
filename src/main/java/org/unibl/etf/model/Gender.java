package org.unibl.etf.model;

public enum Gender {
    Male,
    Female,
    AlphabetPerson;

    @Override
    public String toString() {
        return switch (this) {
            case Male -> "Male";
            case Female -> "Female";
            case AlphabetPerson -> "AlphabetPerson";
        };
    }
}
