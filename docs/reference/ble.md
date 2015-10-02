#Bluetooth LE

This library allows you to configure or change parameters or functionality of the Bluetooth LE radio.

## startAdvertising()

Starts Bluetooth LE advertising with the currently configured advertising data. By default, bluz will begin to advertise upon boot, but this behavior can be started or stopped.

When bluz is advertising, by default the RGB LED will blink slowly green.

```C++
// SYNTAX
BLE.startAdvertising();
```

## stopAdvertising()

Stops Bluetooth LE advertising. By default, bluz will begin to advertise upon boot, but this behavior can be started or stopped.

When bluz is not advertising, by default the RGB LED will blink slowly blue.

```C++
// SYNTAX
BLE.stopAdvertising();
```

## isAdvertising()

Reports back if bluz is currently advertising or not.

```C++
// SYNTAX
bool isAdv = BLE.isAdvertising();
```

