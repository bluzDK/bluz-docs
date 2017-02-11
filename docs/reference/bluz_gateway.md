# Bluz Gateway

This library is used on the Particle board connected to your gateway shield or gateway. It is used to get data in local mode, get information from bluz devices, or configure your gateway.

Unlike all other libraries, these commands are to be used on your Particle Core/Photon/Electron/P1 that is part of the gateway package.

## set_ble_local(bool use_local)

Tells the nrf51 not to connect to the Particle cloud. The device will not come online and be available for updates/configuration, but this will siginifcantly save data use.

```C++
// SYNTAX
bluz_gateway gateway;

void setup() {
    gateway.set_ble_local(true);
}
```

## poll_connections()

Polls the gateway for how many DK's are currently connected. Will return the results though the register_gateway_event callback

```C++
// SYNTAX
bluz_gateway gateway;

void loop() {
    gateway.poll_connections();
}
```

## send_peripheral_data(uint8_t id, uint8_t *data, uint16_t length)

Sends data of the specified length to a connected DK. The DK must be spcified by id, which is an integer between 0 and 7. The currently connected devices can be retreived by calling poll_connections and listening for the results on the register_gateway_event callback

```C++
// SYNTAX
bluz_gateway gateway;

void loop() {
    uint8_t rsp[2] = {'H', 'i'};
    gateway.send_peripheral_data(0, rsp, 2);
}
```

## register_data_callback()

Specifies a function to be called when data from a particular bluz Dk is received. The data must be sent from the DK using BLE.sendData()

```C++
// SYNTAX
bluz_gateway gateway;

void handle_custom_data(uint8_t *data, uint16_t length) {

}

void setup() {
    gateway.register_data_callback(handle_custom_data);
}
```

## register_gateway_event()

Specifies a function to be called when events are received from the gateway. Currently supported events are:

- CONNECTION_RESULTS: Contains an array equal to the number of possible bluz DK's connected where a 1 indicates a DK is connected on that ID and a 0 indicates one is not

```C++
// SYNTAX
bluz_gateway gateway;

void handle_gateway_event(uint8_t event, uint8_t *data, uint16_t length) {
    switch (event) {
            case CONNECTION_RESULTS:
                break;
    }
}

void setup() {
    gateway.register_gateway_event(handle_gateway_event);
}
```

## set_connection_parameters()

Set the minimum and maximum connection intervals in milliseconds. The central will choose a value between these two points for the connection interval when a peripheral connects

Longer connection intervals will result in longer battery life, but will increase latency and decrease throughput.

```C++
// SYNTAX
bluz_gateway gateway;

void setup() {
     gateway.init();
     gateway.set_connection_parameters(275,300);
}
```