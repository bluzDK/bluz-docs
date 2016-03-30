#Getting Started with the Gateway and Gateway Shield

The bluz gateway and gateway shields are hardware devices that allow you to connect your bluz DK to the Particle cloud without a smartphone.
This is greatly beneficial for many applications where the devices must work and be connected at all times. These devices are basically
a bridge from Bluetooth LE to WiFi or Cellular, and can allow up to 3 bluz DK devices to connect to the cloud at one time.

The gateway shield acts like any other Particle device, it can be programmed OTA and access all Particle functions. Once your device
has been powered on, you can claim it and program it through the Web IDE.

This tutorial will walk you through getting your gateway or gateway shield setup and working. This tutorial assumes you have already
setup and claimed your bluz DK devices using the [Getting Started tutorial](../tutorials/getting_started.md).

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- A Particle account (if you don't have one, you can sign up [here](https://dashboard.particle.io/login))
- One of the following:
    - Bluz Gateway Shield with Particle Core, Photon, or Electron
    - Bluz Gateway

##Gateway Shield Setup

1. Take a Particle Core or Photon and power it on, connect it to the cloud, and program it with the sketch found [here](https://github.com/bluzDK/particle-gateway-shield-code).
2. Place the programmed Core or Photon into the socket on the gateway shield
3. Power on the shield by plugging a USB cable into either the Core or Photon, or the USB connector available on the gateway shield
4. Wait for the Core or Photon to connect to the cloud.
5. Once your bluz DK is powered on, it will now automatically connect.

##LED States
The LED on D7 is the indicator LED for the nrf51822 system and its connection to the cloud. The LED will have several states:
- Blinking quickly: Attempting to connect to the Particle cloud
- Blinking slowly: Connected to the Particle Cloud

When an OTA update is initiated, the LED will also blink on/off for each data chunk received, so it will blink somewhat steadily on/off.


##Gateway Shield Programming Limitations
The gateway shield requires more resources to run then bluz DK. Therefore, some peripherals or resources may not be available or may be limited.
The following is a list of differences from bluz DK to the gateway shield:
- SPI and I2C are not available on the gateway shield to the user app
- Only 1K of RAM is available to the user app
- The System.sleep(SLEEP_MODE_CPU) is not available or necessary in the user app
- There is no RGB LED for the nrf51822 on the gateway shield