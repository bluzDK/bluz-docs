## System Calls

### System.sleep()

`System.sleep(SLEEP_MODE_DEEP)` can be used to dramatically reduce the power consumption of bluz while remaining connected to any BLE device and the Particle cloud.
In this particular mode, the device CPU and high frequency clock will turn off. Only the resources needed for enabled peripheral and the BLE radio will be on.
The device can be 'awakened' by any interrupt, including Bluetooth LE data becoming available. The device will wake up in the same exact state as it was when it was put in this mode.

As such, it is recommended that deep sleep be called in the loop() function. This will reduce the running time of the processor and will only awaken bluz when needed.

This is a slightly different way to configure most Arduino style sketches. However, to get maximize battery life from bluz, it is highly encourages to use interrupts and deep sleep mode.

```C++
// SYNTAX
System.sleep(SLEEP_MODE_DEEP);
```

*Power consumption:*

Power consumption in this mode is highly dependent on the peripherals enabled. No peripheral will be disabled by calling this command, and some peripherals (notably UART) can draw a fair amount of current. To acheive maximum battery life, you can disable unused peripherals before entering this state.