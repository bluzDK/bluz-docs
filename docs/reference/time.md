# Time

_Requires v2.0.50 or higher_

The device synchronizes time with the Particle Cloud during the handshake.
From then, the time is continually updated on the device.
This reduces the need for external libraries to manage dates and times.


## hour()

Retrieve the hour for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the hour for the current time
Serial1.print(Time.hour());

// Print the hour for the given time, in this case: 4
Serial1.print(Time.hour(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 0-23


## hourFormat12()

Retrieve the hour in 12-hour format for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the hour in 12-hour format for the current time
Serial1.print(Time.hourFormat12());

// Print the hour in 12-hour format for the given time, in this case: 15
Serial1.print(Time.hourFormat12(1400684400));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 1-12


## isAM()

Returns true if the current or given time is AM.

```cpp
// Print true or false depending on whether the current time is AM
Serial1.print(Time.isAM());

// Print whether the given time is AM, in this case: true
Serial1.print(Time.isAM(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Unsigned 8-bit integer: 0 = false, 1 = true


## isPM()

Returns true if the current or given time is PM.

```cpp
// Print true or false depending on whether the current time is PM
Serial1.print(Time.isPM());

// Print whether the given time is PM, in this case: false
Serial1.print(Time.isPM(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Unsigned 8-bit integer: 0 = false, 1 = true


## minute()

Retrieve the minute for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the minute for the current time
Serial1.print(Time.minute());

// Print the minute for the given time, in this case: 51
Serial1.print(Time.minute(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 0-59


## second()

Retrieve the seconds for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the second for the current time
Serial1.print(Time.second());

// Print the second for the given time, in this case: 51
Serial1.print(Time.second(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 0-59


## day()

Retrieve the day for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the day for the current time
Serial1.print(Time.day());

// Print the minute for the given time, in this case: 21
Serial1.print(Time.day(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 1-31


## weekday()

Retrieve the weekday for the current or given time.

 - 1 = Sunday
 - 2 = Monday
 - 3 = Tuesday
 - 4 = Wednesday
 - 5 = Thursday
 - 6 = Friday
 - 7 = Saturday

```cpp
// Print the weekday number for the current time
Serial1.print(Time.weekday());

// Print the weekday for the given time, in this case: 4
Serial1.print(Time.weekday(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 1-7


## month()

Retrieve the month for the current or given time.
Integer is returned without a leading zero.

```cpp
// Print the month number for the current time
Serial1.print(Time.month());

// Print the month for the given time, in this case: 5
Serial1.print(Time.month(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer 1-12


## year()

Retrieve the 4-digit year for the current or given time.

```cpp
// Print the current year
Serial1.print(Time.year());

// Print the year for the given time, in this case: 2014
Serial1.print(Time.year(1400647897));
```

Optional parameters: Integer (Unix timestamp)

Returns: Integer


## now()

Retrieve the current time as seconds since January 1, 1970 (commonly known as "Unix time" or "epoch time"). This time is not affected by the timezone setting.

```cpp
// Print the current Unix timestamp
Serial1.print(Time.now()); // 1400647897
```

Returns: Integer

## local()

Retrieve the current time in the configured timezone as seconds since January 1, 1970 (commonly known as "Unix time" or "epoch time"). This time is affected by the timezone setting.

Note that the functions in the `Time` class expect times in UTC time, so the result from this should be used carefully.


## zone()

Set the time zone offset (+/-) from UTC.
The device will remember this offset until reboot.

*NOTE*: This function does not observe daylight savings time.

```cpp
// Set time zone to Eastern USA daylight saving time
Time.zone(-4);
```

Parameters: floating point offset from UTC in hours, from -12.0 to 13.0


## setTime()

Set the system time to the given timestamp.

*NOTE*: This will override the time set by the Particle Cloud.
If the cloud connection drops, the reconnection handshake will set the time again

Also see: [`Particle.syncTime()`](#particle-synctime-)

```cpp
// Set the time to 2014-10-11 13:37:42
Time.setTime(1413034662);
```

Parameters: Unix timestamp (integer)


## timeStr()

Return string representation for the given time.
```cpp
Serial1.print(Time.timeStr()); // Wed May 21 01:08:47 2014
```

Returns: String

## format()

Formats a time string using a configurable format.

```cpp
// EXAMPLE

time_t time = Time.now();
Time.format(time, TIME_FORMAT_DEFAULT); // Sat Jan 10 08:22:04 2004 , same as Time.timeStr()

Time.zone(-5.25);  // setup a time zone, which is part of the ISO6801 format
Time.format(time, TIME_FORMAT_ISO8601_FULL); // 2004-01-10T08:22:04-05:15

```

The formats available are:

- `TIME_FORMAT_DEFAULT`
- `TIME_FORMAT_ISO8601_FULL`
- custom format based on `strftime()`

{{#if core}}
Note that the format function is implemented using `strftime()` which adds several kilobytes to the size of firmware.
Application firmware that has limited space available may want to consider using simpler alternatives that consume less firmware space, such as `sprintf()`.
{{/if}}

## setFormat()

Sets the format string that is the default value used by `format()`.

```cpp

Time.setFormat(TIME_FORMAT_ISO8601_FULL);

```

In more advanced cases, you can set the format to a static string that follows
the same syntax as the `strftime()` function.

```
// custom formatting

Time.format(Time.now(), "Now it's %I:%M%p.");
// Now it's 03:21AM.

```

## getFormat()

Retrieves the currently configured format string for time formatting with `format()`.
