# System Calls

## System.sleep()

`System.sleep(SLEEP_MODE_CPU)` can be used to dramatically reduce the power consumption of bluz while remaining connected to any BLE device and the Particle cloud.
In this particular mode, the device CPU and high frequency clock will turn off except for interrupts. Only the resources needed for enabled peripheral and the BLE radio will be on.
The device can be 'awakened' by any interrupt, including Bluetooth LE data becoming available. The device will wake up in the same exact state as it was when it was put in this mode.

In this mode, the system will still wake up every 100mSeconds to perform house-keeping duties. This will also run the loop() function again, so user code
will still be run 10 times every second with this sleep mode.

As such, it is recommended that sleep be called in the loop() function. This will reduce the running time of the processor and will only awaken bluz when needed. Any blocking code
that prevents this from being called as soon as possible (such as delay()) can cause much higher current draw in bluz and will decrease battery performance.

This is a slightly different way to configure most Arduino style sketches. However, to get maximize battery life from bluz, it is highly encouraged to use interrupts and sleep mode.

```C++
// SYNTAX
System.sleep(SLEEP_MODE_CPU);
```

*Power consumption:*

Power consumption in this mode is highly dependent on the peripherals enabled by the user. No peripheral will be disabled by calling this
command, and some peripherals (notably UART) can draw a fair amount of current. To achieve maximum battery life, you can disable unused
peripherals that you may have enabled before entering this state.

## millis()

Returns the number of milliseconds since the device began running the current program. This number will overflow (go back to zero), after approximately 49 days.

`unsigned long time = millis();`

```C++
// EXAMPLE USAGE

unsigned long time;

void setup()
{
  Serial.begin(9600);
}
void loop()
{
  Serial.print("Time: ");
  time = millis();
  //prints time since program started
  Serial.println(time);
  // wait a second so as not to send massive amounts of data
  delay(1000);
}
```
**Note:**
The parameter for millis is an unsigned long, errors may be generated if a programmer tries to do math with other datatypes such as ints.

## micros()

Returns the number of microseconds since the device began running. This number will overflow (go back to zero), after approximately 36 hours.

`unsigned long time = micros();`

**Note:**
To preserve low power consumption, this uses the 32,768kHz LFCLK to keep track of microseconds, meaning resolution is reduced. Each tick of the clock is approximately 30 microseconds, so greater resolution than that cannot be obtained.

## deviceID()

`System.deviceID()` provides an easy way to extract the device ID of your device. It returns a String object of the device ID, which is used to identify your device.

```cpp
// EXAMPLE USAGE

void setup()
{
  // Make sure your Serial Terminal app is closed before powering your device
  Serial1.begin(9600);

  String myID = System.deviceID();
  // Prints out the device ID over Serial
  Serial1.println(myID);
}

void loop() {}
```

## readSupplyVoltage()

_Requires v2.2.50 or higher_

Read the level of the supply voltage without requiring any external connections, can be used to check for battery life. Uses the ADC, so returns a value between 0 and 1023 that represents a voltage between 0V and 3.6V.

```cpp
// EXAMPLE USAGE
void setup() {}

void loop()
{
  double battery_voltage = (readSupplyVoltage() / 1024.0) * 3.6;
  Spark.publish("Battery Voltage", String(battery_voltage));
}
```