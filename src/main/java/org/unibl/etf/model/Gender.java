package org.unibl.etf.model;

public enum Gender {
    Male,
    Female,
    AlphabetPeople;

    @Override
    public String toString() {
        return switch (this) {
            case Male -> "Male";
            case Female -> "Female";
            case AlphabetPeople -> "AlphabetPeople";
        };
    }
}
