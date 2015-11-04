# Wire (I2C)

This library allows you to communicate with I2C/TWI devices. On bluz, D0 is the Serial Data Line (SDA) and D1 is the Serial Clock (SCL). Both of these pins runs at 3.3V. Connect a pull-up resistor(1.5k to 10k) on SDA line. Connect a pull-up resistor(1.5k to 10k) on SCL line.

On bluz, I2C/TWI can only support Master mode and cannot be run as a Slave.

**NOTE:** TWI and SPI cannot be enabled on bluz at the same time. They share resources and attempting to use both can cause conflicts.

## setSpeed()

Sets the I2C clock speed. This is an optional call (not from the original Arduino specs.) and must be called once before calling begin().  The default I2C clock speed is 100KHz.

```C++
// SYNTAX
Wire.setSpeed(clockSpeed);
Wire.begin();
```

Parameters:

- `clockSpeed`: CLOCK_SPEED_100KHZ or CLOCK_SPEED_400KHZ

## begin()

Initiate the Wire library and join the I2C bus as a master or slave. This should normally be called only once.

```C++
// SYNTAX
Wire.begin();
```


## end()

Releases the I2C bus so that the pins used by the I2C bus are available for general purpose I/O.

## isEnabled()

Used to check if the Wire library is enabled already.  Useful if using multiple slave devices on the same I2C bus.  Check if enabled before calling Wire.begin() again.

```C++
// SYNTAX
Wire.isEnabled();
```

Returns: boolean `true` if I2C enabled, `false` if I2C disabled.

```C++
// EXAMPLE USAGE

// Initialize the I2C bus if not already enabled
if ( !Wire.isEnabled() ) {
    Wire.begin();
}
```

## requestFrom()

Used by the master to request bytes from a slave device. The bytes may then be retrieved with the `available()` and `read()` functions.

```C++
// SYNTAX
Wire.requestFrom(address, quantity);
Wire.requestFrom(address, quantity, stop) ;
```

Parameters:

- `address`: the 7-bit address of the device to request bytes from
- `quantity`: the number of bytes to request (Max. 32)
- `stop`: boolean. `true` will send a stop message after the request, releasing the bus. `false` will continually send a restart after the request, keeping the connection active. The bus will not be released, which prevents another master device from transmitting between messages. This allows one master device to send multiple transmissions while in control.  If no argument is specified, the default value is `true`.

Returns: `byte` : the number of bytes returned from the slave device.  If a timeout occurs, will return `0`.

## reset()

Attempts to reset the I2C bus. This should be called only if the I2C bus has
has hung.

## beginTransmission()

Begin a transmission to the I2C slave device with the given address. Subsequently, queue bytes for transmission with the `write()` function and transmit them by calling `endTransmission()`.

```C++
// SYNTAX
Wire.beginTransmission(address);
```

Parameters: `address`: the 7-bit address of the device to transmit to.

## endTransmission()

Ends a transmission to a slave device that was begun by `beginTransmission()` and transmits the bytes that were queued by `write()`.


```C++
// SYNTAX
Wire.endTransmission();
Wire.endTransmission(stop);
```

Parameters: `stop` : boolean.
`true` will send a stop message after the last byte, releasing the bus after transmission. `false` will send a restart, keeping the connection active. The bus will not be released, which prevents another master device from transmitting between messages. This allows one master device to send multiple transmissions while in control.  If no argument is specified, the default value is `true`.

Returns: `byte`, which indicates the status of the transmission:

- 0: success
- 3: internal driver error
- 17: busy timeout, the driver is not ready for a new transfer

## write()

Writes data from a slave device in response to a request from a master, or queues bytes for transmission from a master to slave device (in-between calls to `beginTransmission()` and `endTransmission()`). Buffer size is truncated to 32 bytes; writing bytes beyond 32 before calling endTransmission() will be ignored.

```C++
// SYNTAX
Wire.write(value);
Wire.write(string);
Wire.write(data, length);
```
Parameters:

- `value`: a value to send as a single byte
- `string`: a string to send as a series of bytes
- `data`: an array of data to send as bytes
- `length`: the number of bytes to transmit (Max. 32)

Returns:  `byte`

`write()` will return the number of bytes written, though reading that number is optional.

```C++
// EXAMPLE USAGE

// Master Writer running on Device No.1 (Use with corresponding Slave Reader running on Device No.2)

void setup()
{
  Wire.begin();              // join i2c bus as master
}

byte x = 0;

void loop()
{
  Wire.beginTransmission(4); // transmit to slave device #4
  Wire.write("x is ");       // sends five bytes
  Wire.write(x);             // sends one byte
  Wire.endTransmission();    // stop transmitting

  x++;
  delay(500);
}
```

## available()

Returns the number of bytes available for retrieval with `read()`. This should be called on a master device after a call to `requestFrom()` or on a slave inside the `onReceive()` handler.

```C++
Wire.available();
```

Returns: The number of bytes available for reading.

## read()

Reads a byte that was transmitted from a slave device to a master after a call to `requestFrom()` or was transmitted from a master to a slave. `read()` inherits from the `Stream` utility class.

```C++
// SYNTAX
Wire.read() ;
```

Returns: The next byte received

```C++
// EXAMPLE USAGE

// Master Reader running on Device No.1 (Use with corresponding Slave Writer running on Device No.2)

void setup()
{
  Wire.begin();              // join i2c bus as master
  Serial.begin(9600);        // start serial for output
}

void loop()
{
  Wire.requestFrom(2, 6);    // request 6 bytes from slave device #2

  while(Wire.available())    // slave may send less than requested
  {
    char c = Wire.read();    // receive a byte as character
    Serial.print(c);         // print the character
  }

  delay(500);
}
```

## peek()

Similar in use to read(). Reads (but does not remove from the buffer) a byte that was transmitted from a slave device to a master after a call to `requestFrom()` or was transmitted from a master to a slave. `read()` inherits from the `Stream` utility class. Useful for peeking at the next byte to be read.

```C++
// SYNTAX
Wire.peek();
```

Returns: The next byte received (without removing it from the buffer)

