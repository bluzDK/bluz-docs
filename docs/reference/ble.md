#Bluetooth LE

This library allows you to configure or change parameters or functionality of the Bluetooth LE radio.

## getState()

Returns the current state of the BLE radio. Can be one of the following:
```C++
    BLE_OFF             //BLE is off and not advertising
    BLE_ADVERTISING     //BLE is on and advertising
    BLE_SLEEPING        //BLE is sleeping
    BLE_CONNECTED       //BLE is connected
```

```C++
// SYNTAX
BLEState state = BLE.getState();
```

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
