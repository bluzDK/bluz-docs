# RGB

This library allows the user to control the RGB LED on the front of the device.

```cpp
// EXAMPLE CODE

// take control of the LED
RGB.control(true);

// red, green, blue, 0-255.
// the following sets the RGB LED to white:
RGB.color(255, 255, 255);

// wait one second
delay(1000);

// resume normal operation
RGB.control(false);
```

## control(user_control)

User can take control of the RGB LED, or give control back to the system.

```cpp
// take control of the RGB LED
RGB.control(true);

// resume normal operation
RGB.control(false);
```

## controlled()

Returns Boolean `true` when the RGB LED is under user control, or `false` when it is not.

```cpp
// take control of the RGB LED
RGB.control(true);

// Print true or false depending on whether
// the RGB LED is currently under user control.
// In this case it prints "true".
Serial.println(RGB.controlled());

// resume normal operation
RGB.control(false);
```

## color(red, green, blue)

Set the color of the RGB with three values, 0 to 255 (0 is off, any other value is on).  User must take control of the RGB LED before calling this method.

```cpp
// Set the RGB LED to red
RGB.color(255, 0, 0);

// Sets the RGB LED to cyan
RGB.color(0, 255, 255);

// Sets the RGB LED to white
RGB.color(255, 255, 255);
```

## onChange(handler)

Specifies a function to call when the color of the RGB LED changes. It can be used to implement an external RGB LED.

```cpp
// EXAMPLE USAGE

void ledChangeHandler(uint8_t r, uint8_t g, uint8_t b) {
  // Duplicate the green color to an external LED
  analogWrite(D0, g);
}

void setup()
{
  pinMode(D0, OUTPUT);
  RGB.onChange(ledChangeHandler);
}

```

---

`onChange` can also call a method on an object.

```
// Automatically mirror the onboard RGB LED to an external RGB LED
// No additional code needed in setup() or loop()

class ExternalRGB {
  public:
    ExternalRGB(pin_t r, pin_t g, pin_t b) : pin_r(r), pin_g(g), pin_b(b) {
      pinMode(pin_r, OUTPUT);
      pinMode(pin_g, OUTPUT);
      pinMode(pin_b, OUTPUT);
      RGB.onChange(&ExternalRGB::handler, this);
    }

    void handler(uint8_t r, uint8_t g, uint8_t b) {
      analogWrite(pin_r, 255 - r);
      analogWrite(pin_g, 255 - g);
      analogWrite(pin_b, 255 - b);
    }

    private:
      pin_t pin_r;
      pin_t pin_g;
      pin_t pin_b;
};

// Connect an external RGB LED to D0, D1 and D2 (R, G, and B)
ExternalRGB myRGB(D0, D1, D2);
```
