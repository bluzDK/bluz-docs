#Local Communication with Bluz

This tutorial will walk you through communicating locally with bluz. Local communication means data transferred directly from the gateway to bluz DK, without going through the Particle cloud.

Local communication can be used for a lot of tasks that don't require the cloud. For example, if you wanted a custom app to talk directly to bluz. Or if you were using a gateway but wanted the Particle board to do some work on behalf of bluz, such as posting HTTP requests or sending data over TCP/UDP.

This is also ideal when using bluz DK with an Electron, as monthly data charges can be quite high if you use a lot of data.

Local communication can be used with or without the cloud, the two are parallel and not dependent on eachother.

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- A bluz gateway or gateway shield with a Particle Core/Photon/Electron

##Programming the Particle Board
The Bluz Gateway library in the Particle Web IDE allows for easy configuration of you Particle board. There are several callback functions that allow you to receive data or information from the nrf51 side of the gateway, or individual DK's connected to it. For more infomration, you can view the [reference documentation](../reference/bluz_gateway.md).

In this example, we will have the gateway poll for available DK's connected to the gateway every 30 seconds, then request information from each one. THe Particle board will then publish the data from each DK.

To implement this on the gateway side, include the Bluz Gateway library in your app and use the following code:

```C++
#include "bluz_gateway/bluz_gateway.h"
#define POLL_CONNECTIONS_INTERVAL 30000

SYSTEM_MODE(SEMI_AUTOMATIC);
bluz_gateway gateway;

void handle_custom_data(uint8_t *data, uint16_t length) {
    //if you use BLE.send from any connected DK, the data will end up here
    Particle.publish("Bluz Custom Data", String((char*)data));
}

void handle_gateway_event(uint8_t event, uint8_t *data, uint16_t length) {
    //will return any polling queries from the gateway here
    uint8_t rsp[2] = {'H', 'i'};
    switch (event) {
        case CONNECTION_RESULTS:
            String online_devices = "";
            for (int i = 0; i < length; i++) {
                if (data[i] == 0) {
                    online_devices +="O ";
                } else {
                    online_devices +="X ";
                    gateway.send_peripheral_data(i, rsp, 2);
                }
            }
            Particle.publish("Bluz Devices Online", online_devices);
            break;
    }
}

void setup() {
    gateway.init();

    //register the callback functions
    gateway.register_data_callback(handle_custom_data);
    gateway.register_gateway_event(handle_gateway_event);
}

long timeToNextPoll = POLL_CONNECTIONS_INTERVAL;
void loop() {
    gateway.loop();
    if (millis() > timeToNextPoll) {
        timeToNextPoll = POLL_CONNECTIONS_INTERVAL + millis();
        gateway.poll_connections();
    }
}
```

Flash the full gateway sketch with this code to the Particle device that is plugged into the gateway shield.

##Programming bluz
In order for the gateway shield to receive data, bluz DK must send data. This can be acheived by using the BLE.sendData function.

To send data from a bluz DK and trigger the above publish, flash this sketch to your bluz DK board:

```C++
#include "application.h"
SYSTEM_MODE(MANUAL);

bool sendData = false;

void dataCallbackHandler(uint8_t *data, uint16_t length) {
    sendData = true;
}

void setup() {
    BLE.registerDataCallback(dataCallbackHandler);

    pinMode(D6, INPUT_PULLDOWN);
    if (digitalRead(D6) == HIGH) {
        SYSTEM_MODE(AUTOMATIC);
    }
}

void loop() {
    System.sleep(SLEEP_MODE_CPU);
    if (sendData)
    {
        uint8_t rsp[2] = {'H', 'i'};
        BLE.sendData(rsp, 2);
        sendData = false;
    }
}
```

This code registers a data callback function for when the gateway sends data down. Once this is received, is uses BLE.send to send data back up.

Notice also that we have configured D6 as an input that, if pulled HIGH during startup, will force the DK back to Automatic mode. This is useful if you want to quickly skip back to non-local communications mode so that you can update firmware.

##Running the example
Once you have flashed the code to both boards, turn on the gateway shield and let it connect. Then turn on your bluz DK with the above sketch, it will connect automatically and once it is online, you will start to the see the events published.

##Electron Use
This method is especially effective for use with the Electron as you are charged monthly for the data used. A bluz DK in normal Automatic mode can consume up to 6MB per month even if no data is sent, this is because keep-alives are sent in the background to the cloud. Local comunication mitigates this issue.

You can also turn off the gateway from connecting to the cloud by placing this line in your Particle sketch:

```C++
gateway.set_ble_local(true);
```

This will force the nrf51 on-board to not connect to the cloud, meaning it will not be available for cloud-related activities but will still work fine as a gateway and pass data to the Electron.
