package ru.kpfu.itis.gr201.ponomarev.springcars.util;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class Constants {
    public final static DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("d MMM uuuu HH:mm").withLocale(Locale.ENGLISH);
}
