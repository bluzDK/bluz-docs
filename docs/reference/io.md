# Input/Output

## pinMode()

`pinMode()` configures the specified pin to behave either as an input (with or without an internal weak pull-up or pull-down resistor), or an output.

```C++
// SYNTAX
pinMode(pin,mode);
```

`pinMode()` takes two arguments, `pin`: the number of the pin whose mode you wish to set and `mode`: `INPUT, INPUT_PULLUP, INPUT_PULLDOWN or OUTPUT.`

`pinMode()` does not return anything.

```C++
// EXAMPLE USAGE
int button = D0;                      // button is connected to D0
int LED = D1;                         // LED is connected to D1

void setup()
{
  pinMode(LED, OUTPUT);               // sets pin as output
  pinMode(button, INPUT_PULLDOWN);    // sets pin as input
}

void loop()
{
  // blink the LED as long as the button is pressed
  while(digitalRead(button) == HIGH) {
    digitalWrite(LED, HIGH);          // sets the LED on
    delay(200);                       // waits for 200mS
    digitalWrite(LED, LOW);           // sets the LED off
    delay(200);                       // waits for 200mS
  }
}
```

## getPinMode(pin)

Retrieves the current pin mode.

```cpp
// EXAMPLE

if (getPinMode(D0)==INPUT) {
  // D0 is an input pin
}
```

## digitalWrite()

Write a `HIGH` or a `LOW` value to a digital pin.

```C++
// SYNTAX
digitalWrite(pin, value);
```

If the pin has been configured as an `OUTPUT` with `pinMode()` or if previously used with `analogWrite()`, its voltage will be set to the corresponding value: 3.3V for HIGH, 0V (ground) for LOW.

`digitalWrite()` takes two arguments, `pin`: the number of the pin whose value you wish to set and `value`: `HIGH` or `LOW`.

`digitalWrite()` does not return anything.

```C++
// EXAMPLE USAGE
int LED = D1;              // LED connected to D1

void setup()
{
  pinMode(LED, OUTPUT);    // sets pin as output
}

void loop()
{
  digitalWrite(LED, HIGH); // sets the LED on
  delay(200);              // waits for 200mS
  digitalWrite(LED, LOW);  // sets the LED off
  delay(200);              // waits for 200mS
}
```

## digitalRead()

Reads the value from a specified digital `pin`, either `HIGH` or `LOW`.

```C++
// SYNTAX
digitalRead(pin);
```

`digitalRead()` takes one argument, `pin`: the number of the digital pin you want to read.

`digitalRead()` returns `HIGH` or `LOW`.

```C++
// EXAMPLE USAGE
int button = D0;                   // button is connected to D0
int LED = D1;                      // LED is connected to D1
int val = 0;                       // variable to store the read value

void setup()
{
  pinMode(LED, OUTPUT);            // sets pin as output
  pinMode(button, INPUT_PULLDOWN); // sets pin as input
}

void loop()
{
  val = digitalRead(button);       // read the input pin
  digitalWrite(LED, val);          // sets the LED to the button's value
}

```

## analogWrite()

Writes an analog value (PWM wave) to a pin. Can be used to light a LED at varying brightnesses or drive a motor at various speeds. After a call to analogWrite(), the pin will generate a steady square wave of the specified duty cycle until the next call to analogWrite() (or a call to digitalRead() or digitalWrite() on the same pin). The frequency of the PWM signal is approximately 500 Hz.

```C++
// SYNTAX
analogWrite(pin, value);
```

```C++
// EXAMPLE USAGE

int ledPin = D1;               // LED connected to digital pin D1
int analogPin = A0;            // potentiometer connected to analog pin A0
int val = 0;                   // variable to store the read value

void setup()
{
  pinMode(ledPin, OUTPUT);     // sets the pin as output
}

void loop()
{
  val = analogRead(analogPin); // read the input pin
  analogWrite(ledPin, val/16); // analogRead values go from 0 to 4095,
                               // analogWrite values from 0 to 255.
  delay(10);
}
```

- On the Core, this function works on pins A0, A1, A4, A5, A6, A7, D0 and D1.
- On the Photon, this function works on pins D0, D1, D2, D3, A4, A5, WKP, RX and TX with a caveat: PWM timer peripheral is duplicated on two pins (A5/D2) and (A4/D3) for 7 total independent PWM outputs. For example: PWM may be used on A5 while D2 is used as a GPIO, or D2 as a PWM while A5 is used as an analog input. However A5 and D2 cannot be used as independently controlled PWM outputs at the same time.

When used with these pins, the analogWrite function has nothing to do with the analog pins or the analogRead function.


`analogWrite()` takes two arguments, `pin`: the number of the pin whose value you wish to set and `value`: the duty cycle: between 0 (always off) and 255 (always on).

**NOTE:** `pinMode(pin, OUTPUT);` is required before calling `analogWrite(pin, value);` or else the `pin` will not be initialized as a PWM output and set to the desired duty cycle.

`analogWrite()` does not return anything.



## Analog Output (Photon)

The Photon supports true analog output on pins DAC (`DAC1` or `A6` in code) and A3 (`DAC2` or `A3` in code). Using `analogWrite(pin, value)`
with these pins, the output of the pin is set to an analog voltage from 0V to 3.3V that corresponds to values
from 0-4095.

**NOTE:** While for PWM pins one single call to `pinMode(pin, OUTPUT);` sets the pin mode for multiple `analogWrite(pin, value);` calls, for DAC pins you need to set `pinMode(DAC, OUTPUT);` each time anew you want to perform an `analogWrite()`.

```C++
// SYNTAX
pinMode(DAC1, OUTPUT);
analogWrite(DAC1, 1024);
// sets DAC pin to an output voltage of 1024/4095 * 3.3V = 0.825V.
```

## analogRead()

Reads the value from the specified analog pin. The device has 8 channels (A0 to A7) with a 12-bit resolution. This means that it will map input voltages between 0 and 3.3 volts into integer values between 0 and 4095. This yields a resolution between readings of: 3.3 volts / 4096 units or, 0.0008 volts (0.8 mV) per unit.

```C++
// SYNTAX
analogRead(pin);
```

`analogRead()` takes one argument `pin`: the number of the analog input pin to read from ('A0 to A7'.)

`analogRead()` returns an integer value ranging from 0 to 4095.

```C++
// EXAMPLE USAGE
int ledPin = D1;                // LED connected to digital pin D1
int analogPin = A0;             // potentiometer connected to analog pin A0
int val = 0;                    // variable to store the read value

void setup()
{
  pinMode(ledPin, OUTPUT);      // sets the pin as output
}

void loop()
{
  val = analogRead(analogPin);  // read the input pin
  analogWrite(ledPin, val/16);  // analogRead values go from 0 to 4095, analogWrite values from 0 to 255
  delay(10);
}
```
