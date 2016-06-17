#Different Operating Modes of bluz

This tutorial will walk you through the different operating states of bluz. There are different states the bluz can get into based on the Bluetooth LE connection, so it is important to understand how these states are entered and what can be done in each one.

For example, bluz is designed to be used with the Particle cloud, but this isn't a requirement. Bluz can be easily reconfigured into a normal Bluetooth LE device, capable of many different profiles, or the radio can be turned off completely and it can be used as any other Arduino-style development board.

Please note that in all states, the setup() and loop() functions will be called. Therefore, user code must check for the current state and act accordingly. For example, calling Spark.publish when the device is not connected will result in the event never being published.

## States

RGB LED Color   | Flashes   |   State
---             | ---       | ---
Green           | Slow      | Advertising and waiting for connection
Green           | Quick     | Bluetooth LE is connected, attempting to connect to Particle Cloud
Blue            | Slow      | Bluetooth is off and not advertising
Magenta         | Steady    | Bluz is receiving an Over the Air update
Magenta         | Slow      | Bluz is in Safe Mode, meaning no user app is loaded and running
Cyan            | Slow      | Bluetooth is connected and bluz is connected to the Particle Cloud
Yellow          | Solid     | Bluz is in bootloader setup mode
RED             | Any       | Bluz has errored. Please see the [SOS codes](/troubleshooting/sos/) for further help

## Advertising State

This is, by default, the state bluz will enter upon boot. It will advertise the Particle service so that a bluz enabled gateway can connect to it and proxy data to the cloud.

Bluz will start advertising indefinitely, but this is not ideal for battery life. Power consumption can be high wen advertising, so if you aren't expecting a connection, it is best to turn it off. You can do this by calling
```C++
// SYNTAX
BLE.stopAdvertising();
```

To start advertsising again, simply call
```C++
// SYNTAX
BLE.startAdvertising();
```

## Connecting State

When bluz connects to a gateway, it will by default attempt to connect to the Particle cloud. This state will only last for 40 seconds. Either the connection will be successful, or it will not. Bluz will not drop the Bluetooth LE connection, however, but the state will change and the user can decide what to do next.

## Non-Advertising state

This state can only be entered manually by calling stopAdvertising. Once entered, the Bluetooth LE radio is turned off, and no connections can be made to the device. This mode can be used to save battery life if a constant connection to the cloud isn't required.

## Bluetooth LE Connected, no Cloud Connection
This state means that you cannot access the particle cloud, so all features related to it aren't available. However, you can still use local Bluetooth LE to talk to the central device. For example, if you were making a HID keyboard or mouse, this may be a valid state for your app.

## OTA Updating

When you issue an OTA update to your app, it will enter this state. A new firmware image is being downloaded and user code may be blocked during this process. Once it is complete, bluz will reboot and launch the new app.

## Connected Mode

In connected mode, bluz can talk to the cloud and the central device, and perform all online activities.

## Safe Mode

Safe Mode is entered automatically when there is an issue detected with the user app or after a Factory Reset. This can happen when moving to
a new version of firmware as the dependency may have changed, and bluz needs to update its system firmware. To exit Safe Mode, connect bluz
to the Particle Cloud, if any system updates are needed then it will automatically download them. Once this step is complete, you can flash new
user app code.
