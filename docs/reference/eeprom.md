# EEPROM

_Requires v2.0.50 or higher_

EEPROM emulation allocates a region of the device's built-in Flash memory to act as EEPROM.
Unlike "true" EEPROM, flash doesn't suffer from write "wear" with each write to
each individual address. Instead, the page suffers wear when it is filled. Each write
will add more data to the page until it is full, causing a page erase.

The EEPROM functions can be used to store small amounts of data in Flash that
will persist even after the device resets after a deep sleep or is powered off.

## length()
Returns the total number of bytes available in the emulated EEPROM.

```c++
// SYNTAX
size_t length = EEPROM.length();
```

- The Core has 127 bytes of emulated EEPROM.
- The Photon and Electron have 2047 bytes of emulated EEPROM.

## put()
This function will write an object to the EEPROM. You can write single values like `int` and
`float` or group multiple values together using `struct` to ensure that all values of the struct are
updated together.

```
// SYNTAX
EEPROM.put(int address, object)
```

`address` is the start address (int) of the EERPOM locations to write. It must be a value between 0
and `EEPROM.length()-1`

`object` is the object data to write. The number of bytes to write is automatically determined from
the type of object.

```C++
// EXAMPLE USAGE
// Write a value (2 bytes in this case) to the EEPROM address
int addr = 10;
uint16_t value = 12345;
EEPROM.put(addr, value);

// Write an object to the EEPROM address
addr = 20;
struct MyObject {
  uint8_t version;
  float field1;
  uint16_t field2;
  char name[10];
};
MyObject myObj = { 0, 12.34f, 25, "Test!" };
EEPROM.put(addr, myObj);
```

The object data is first compared to the data written in the EEPROM to avoid writing values that
haven't changed.

If the {{device}} loses power before the write finishes, the partially written data will be ignored.

If you write several objects to EEPROM, make sure they don't overlap: the address of the second
object must be larger than the address of the first object plus the size of the first object. You
can leave empty room between objects in case you need to make the first object bigger later.

## get()
This function will retrieve an object from the EEPROM. Use the same type of object you used in the
`put` call.

```
// SYNTAX
EEPROM.get(int address, object)
```

`address` is the start address (int) of the EERPOM locations to read. It must be a value between 0
and `EEPROM.length()-1`

`object` is the object data that would be read. The number of bytes read is automatically determined
from the type of object.

```C++
// EXAMPLE USAGE
// Read a value (2 bytes in this case) from EEPROM addres
int addr = 10;
uint16_t value;
EEPROM.get(addr, value);
if(value == 0xFFFF) {
  // EEPROM was empty -> initialize value
  value = 25;
}

// Read an object from the EEPROM addres
addr = 20;
struct MyObject {
  uint8_t version;
  float field1;
  uint16_t field2;
  char name[10];
};
MyObject myObj;
EEPROM.get(addr, myObj);
if(myObj.version != 0) {
  // EEPROM was empty -> initialize myObj
  MyObject defaultObj = { 0, 12.34f, 25, "Test!" };
  myObj = defaultObj;
}
```

The default value of bytes in the EEPROM is 255 (hexadecimal 0xFF) so reading an object on a new
{{device}} will return an object filled with 0xFF. One trick to deal with default data is to include
a version field that you can check to see if there was valid data written in the EEPROM.

## read()
Read a single byte of data from the emulated EEPROM.

```
// SYNTAX
uint8_t value = EEPROM.read(int address);
```

`address` is the address (int) of the EERPOM location to read

```C++
// EXAMPLE USAGE

// Read the value of the second byte of EEPROM
int addr = 1;
uint8_t value = EEPROM.read(addr);
```

When reading more than 1 byte, prefer `get()` over multiple `read()` since it's faster.

## write()
Write a single byte of data to the emulated EEPROM.

```
// SYNTAX
write(int address, uint8_t value);
```

`address` is the address (int) of the EERPOM location to write to
`value` is the byte data (uint8_t) to write

```C++
// EXAMPLE USAGE

// Write a byte value to the second byte of EEPROM
int addr = 1;
uint8_t val = 0x45;
EEPROM.write(addr, val);
```

When writing more than 1 byte, prefer `put()` over multiple `write()` since it's faster and it ensures
consistent data even when power is lost while writing.

## clear()
Erase all the EEPROM so that all reads will return 255 (hexadecimal 0xFF).

```C++
// EXAMPLE USAGE
// Reset all EEPROM locations to 0xFF
EEPROM.clear();
```

Calling this function pauses processor execution (including code running in interrupts) for 800ms since
no instructions can be fetched from Flash while the Flash controller is busy erasing both EEPROM
pages.

