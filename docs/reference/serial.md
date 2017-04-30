# Serial

Used for communication between the device and a computer or other devices. The device has one serial channel:

`Serial1:` This channel is available via the device's TX and RX pins.

**NOTE:** 'Serial' is not available. On the Core/Photon, and Arduino Uno and many other compatible boards, this pipes to a virtual port that goes to the USB connector. Since bluz doesn't have a USB connector, we are sticking with convention and not using this.

To use the TX/RX (Serial1) pins to communicate with your personal computer, you will need an additional USB-to-serial adapter. To use them to communicate with an external TTL serial device, connect the TX pin to your device's RX pin, the RX to your device's TX pin, and the ground of bluz to your device's ground.

**NOTE:** Please take into account that the voltage levels on these pins runs at 0V to 3.3V and should not be connected directly to a computer's RS232 serial port which operates at +/- 12V and can damage bluz.

## begin()

Sets the data rate in bits per second (baud) for serial data transmission. For communicating with the computer, use one of these rates: 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, or 115200. You can, however, specify other rates - for example, to communicate over pins TX and RX with a component that requires a particular baud rate.


```C++
// SYNTAX
Serial1.begin(speed);   // serial via TX and RX pins
```
`speed`: parameter that specifies the baud rate *(long)*

`begin()` does not return anything

```C++
// EXAMPLE USAGE
void setup()
{
  Serial1.begin(9600);   // open serial over USB

  Serial1.begin(9600);  // open serial over TX and RX pins

  Serial1.println("Hello Serial 1");
}

void loop() {}
```

## end()

Disables serial communication, allowing the RX and TX pins to be used for general input and output. To re-enable serial communication, call `Serial1.begin()`.

```C++
// SYNTAX
Serial1.end();
```

## available()

Get the number of bytes (characters) available for reading from the serial port. This is data that's already arrived and stored in the serial receive buffer (which holds 64 bytes).

```C++
// EXAMPLE USAGE
void setup()
{
  Serial1.begin(9600);
  Serial1.begin(9600);

}

void loop()
{
  // read from port 1:
  if (Serial1.available())
  {
    int inByte = Serial1.read();
  }
}
```

## peek()

Returns the next byte (character) of incoming serial data without removing it from the internal serial buffer. That is, successive calls to peek() will return the same character, as will the next call to `read()`.

```C++
// SYNTAX
Serial1.peek();
```
`peek()` returns the first byte of incoming serial data available (or `-1` if no data is available) - *int*

## write()

Writes binary data to the serial port. This data is sent as a byte or series of bytes; to send the characters representing the digits of a number use the `print()` function instead.

```C++
// SYNTAX
Serial1.write(val);
Serial1.write(str);
Serial1.write(buf, len);
```

```C++
// EXAMPLE USAGE

void setup()
{
  Serial1.begin(9600);
}

void loop()
{
  Serial1.write(45); // send a byte with the value 45

  int bytesSent = Serial1.write(“hello”); //send the string “hello” and return the length of the string.
}
```

*Parameters:*

- `val`: a value to send as a single byte
- `str`: a string to send as a series of bytes
- `buf`: an array to send as a series of bytes
- `len`: the length of the buffer

`write()` will return the number of bytes written, though reading that number is optional.


## read()

Reads incoming serial data.

```C++
// SYNTAX
Serial1.read();
```
`read()` returns the first byte of incoming serial data available (or -1 if no data is available) - *int*

```C++
// EXAMPLE USAGE
uint8_t incomingByte = 0; // for incoming serial data

void setup() {
  Serial1.begin(9600); // opens serial port, sets data rate to 9600 bps
}

void loop() {
  // send data only when you receive data:
  if (Serial1.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial1.read();

    // say what you got:
    Serial1.print("I received: ");
    Serial1.println(incomingByte, DEC);
  }
}
```
## print()

Prints data to the serial port as human-readable ASCII text. This command can take many forms. Numbers are printed using an ASCII character for each digit. Floats are similarly printed as ASCII digits, defaulting to two decimal places. Bytes are sent as a single character. Characters and strings are sent as is. For example:

- Serial1.print(78) gives "78"
- Serial1.print(1.23456) gives "1.23"
- Serial1.print('N') gives "N"
- Serial1.print("Hello world.") gives "Hello world."

An optional second parameter specifies the base (format) to use; permitted values are BIN (binary, or base 2), OCT (octal, or base 8), DEC (decimal, or base 10), HEX (hexadecimal, or base 16). For floating point numbers, this parameter specifies the number of decimal places to use. For example:

- Serial1.print(78, BIN) gives "1001110"
- Serial1.print(78, OCT) gives "116"
- Serial1.print(78, DEC) gives "78"
- Serial1.print(78, HEX) gives "4E"
- Serial1.println(1.23456, 0) gives "1"
- Serial1.println(1.23456, 2) gives "1.23"
- Serial1.println(1.23456, 4) gives "1.2346"

## println()

Prints data to the serial port as human-readable ASCII text followed by a carriage return character (ASCII 13, or '\r') and a newline character (ASCII 10, or '\n'). This command takes the same forms as `Serial1.print()`.

```C++
// SYNTAX
Serial1.println(val);
Serial1.println(val, format);
```

*Parameters:*

- `val`: the value to print - any data type
- `format`: specifies the number base (for integral data types) or number of decimal places (for floating point types)

`println()` returns the number of bytes written, though reading that number is optional - `size_t (long)`

```C++
// EXAMPLE
//reads an analog input on analog in A0, prints the value out.

int analogValue = 0;    // variable to hold the analog value

void setup()
{
  // Make sure your Serial Terminal app is closed before powering your device
  Serial1.begin(9600);
}

void loop() {
  // read the analog input on pin A0:
  analogValue = analogRead(A0);

  // print it out in many formats:
  Serial1.println(analogValue);       // print as an ASCII-encoded decimal
  Serial1.println(analogValue, DEC);  // print as an ASCII-encoded decimal
  Serial1.println(analogValue, HEX);  // print as an ASCII-encoded hexadecimal
  Serial1.println(analogValue, OCT);  // print as an ASCII-encoded octal
  Serial1.println(analogValue, BIN);  // print as an ASCII-encoded binary

  // delay 10 milliseconds before the next reading:
  delay(10);
}
```

## flush()

Waits for the transmission of outgoing serial data to complete.

**NOTE:** Since Serial uses the USB port, `Serial1.flush()` is an empty function at this time.

```C++
// SYNTAX
Serial1.flush();
```

`flush()` neither takes a parameter nor returns anything

## halfduplex()

Puts Serial1 into half-duplex mode.  In this mode both the transmit and receive
are on the TX pin.  This mode can be used for a single wire bus communications
scheme between microcontrollers.

```C++
// SYNTAX
Serial1.halfduplex(true);  // Enable half-duplex mode
Serial1.halfduplex(false); // Disable half-duplex mode
```

```C++
// EXAMPLE
// Initializes Serial1 at 9600 baud and enables half duplex mode

Serial1.begin(9600);
Serial1.halfduplex(true);

```
`halfduplex()` takes one argument: `true` enables half-duplex mode, `false` disables half-duplex mode

`halfduplex()` returns nothing
