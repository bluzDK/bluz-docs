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

## disconnect()

Will disconnect bluz from the central to which it is currently connected.

```C++
// SYNTAX
if (Particle.connected() && state == BLE_CONNECTED) {
    BLE.disconnect();
}
```

## registerRadioNotifications()

Registers a callback function to be called whenever the radio state changes. This can be useful for timing sensitive tasks or ones that need to run when the radio is off. The user can keep track of the times the radio is not active or do things in the gaps.

**NOTE:** This is an interrupt handler and code in the callback function should not block.

```C++
// SYNTAX
void radioCallbackHandler(bool radio_active) {
    //Do something about it
}

BLE.registerNotifications(radioCallbackHandler);
```

## sendData()

_Requires v1.1.47 or higher_

This will use the custom data service to send data directly to the gateway. The gateway can be an app (bluz provided or custom) or any one of the hardware devices available.

Data will be sent under the custom data service, meaning there will be a one-byte header of 0x04 added to the data when this function is called. The gateway will need to use this header to determine how to use the data.

For more information, you can see our tutorial on [local communication](../tutorials/local_communication.md).


```C++
// Send a three byte array of data
uint8_t data[3] = {0x01, 0x02, 0x03};
BLE.sendData(data, sizeof(data));

BLE.registerNotifications(radioCallbackHandler);
```

## registerDataCallback()

_Requires v1.1.47 or higher_

This will register a function that will be called when data is sent to bluz over local communication.

Data can be sent locally from a gateway by using the custom data service. The data received by this function does not include the one-byte header, it will have been stripped away when routing.

For more information, you can see our tutorial on [local communication](../tutorials/local_communication.md).

**NOTE:** This is an interrupt handler and code in the callback function should not block.

```C++
void dataCallbackHandler(uint8_t *data, uint16_t length) {
    //do something with the data
}

BLE.registerDataCallback(dataCallbackHandler);
```

## setTxPower()

_Requires v2.0.50 or higher_

Set the transmit power of the BLE radio. Value must be one of the following: -30, -20, -16, -12, -8, -4, 0, or 4 dBm. Any other value will be ignored.

Default is 0dBm.

Lower values will result in longer battery life, but will reduce the operating range.

```C++
void setup()
{
    // set the transmit power to -8dBm
    BLE.setTxPower(-8);
}
```

## BLE_ADV_NAME()

_Requires v2.0.50 or higher_

Set the advertisement name. Gateway and Gateway Shields can also be setup to filter on specific advertised names, allowing you to filter connections from gateway to DK.

Max length of name is 24 characters.

```C++
BLE_ADV_NAME("Test");

void setup()
{

}
```