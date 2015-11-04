# SPI

This library allows you to communicate with SPI devices, with bluz as the master device.

The hardware SPI pin functions are mapped as follows:
* `SCK` => `A3`
* `MISO` => `A4`
* `MOSI` => `A5`
* `SS` => `A2` (default)

**NOTE:** TWI and SPI cannot be enabled on bluz at the same time. They share resources and attempting to use both can cause conflicts.

## begin()

Initializes the SPI bus by setting SCK, MOSI, and a user-specified slave-select pin to outputs, MISO to input. SCK and MOSI are pulled low, and slave-select high.

**NOTE:**  The SPI firmware ONLY initializes the user-specified slave-select pin. The user's code must control the slave-select pin before and after each SPI transfer for the desired SPI slave device. Calling `SPI.end()` does NOT reset the pin mode of the SPI pins.

```C++
// SYNTAX
SPI.begin();
```

Where, the parameter `ss` is the SPI device slave-select pin to initialize.  If no pin is specified, the default pin is `SS (A2)`.

## end()

Disables the SPI bus (leaving pin modes unchanged).

```C++
// SYNTAX
SPI.end();
```

## setBitOrder()

Sets the order of the bits shifted out of and into the SPI bus, either LSBFIRST (least-significant bit first) or MSBFIRST (most-significant bit first).

```C++
// SYNTAX
SPI.setBitOrder(order);
```

Where, the parameter `order` can either be `LSBFIRST` or `MSBFIRST`.

## setClockSpeed()

Sets the SPI clock speed. The value can be specified as a direct value, or as
as a value plus a multiplier.


```
// EXAMPLE

// set the clock speed to 8 MHz
SPI.setClockSpeed(8, MHZ));
SPI.setClockSpeed(8000000));
```

The clock speed cannot be set to any arbitrary value, but is set internally by using a
divider (see `SPI.setClockDivider()`) that gives the highest clock speed not greater
than the one specified.

This method can make writing portable code easier, since it specifies the clock speed
absolutely, giving comparable results across devices. In contrast, specifying
the clock speed using dividers is typically not portable since is dependent upon the system clock speed.

## setClockDividerReference()

This function aims to ease porting code from other platforms by setting the clock speed that
`SPI.setClockDivider` is relative to.

For example, when porting an Arduino SPI library, each to `SPI.setClockDivider()` would
need to be changed to reflect the system clock speed of the device being used.

This can be avoided by placing a call to `SPI.setClockDividerReference()` before the other SPI calls.

```cpp

// setting divider reference

// place this early in the library code
SPI.setClockDividerReference(SPI_CLK_ARDUINO);

// then all following calls to setClockDivider() will give comparable clock speeds
// to running on the Arduino Uno

// sets the clock to as close to 4MHz without going over.
SPI.setClockDivider(SPI_CLK_DIV4);
```

The default clock divider reference is the system clock, which is 16MHz for bluz.

## setClockDivider()

Sets the SPI clock divider relative to the selected clock reference. The available dividers  are 2, 4, 8, 16, 32, 64, or 128. The default setting is SPI_CLOCK_DIV16, which sets the SPI clock to one-sixteenth the frequency of the system clock, or 1MHz.

```C++
// SYNTAX
SPI.setClockDivider(divider) ;
```
Where the parameter, `divider` can be:

 - `SPI_CLOCK_DIV2`
 - `SPI_CLOCK_DIV4`
 - `SPI_CLOCK_DIV8`
 - `SPI_CLOCK_DIV16`
 - `SPI_CLOCK_DIV32`
 - `SPI_CLOCK_DIV64`
 - `SPI_CLOCK_DIV128`

## setDataMode()

Sets the SPI data mode: that is, clock polarity and phase. See the [Wikipedia article on SPI](http://en.wikipedia.org/wiki/Serial_Peripheral_Interface_Bus) for details.

```C++
// SYNTAX
SPI.setDataMode(mode) ;
```
Where the parameter, `mode` can be:

 - `SPI_MODE0`
 - `SPI_MODE1`
 - `SPI_MODE2`
 - `SPI_MODE3`

## transfer()

Transfers one byte over the SPI bus, both sending and receiving, and returns the received byte.

```C++
// SYNTAX
SPI.transfer(val);
```
Where the parameter `val`, can is the byte to send out over the SPI bus.