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

1. Take a Particle Core or Photon and power it on and connect it to the cloud. For more information on setting up your Photon, see the [Particle Documentation](https://docs.particle.io/guide/getting-started/start/photon/#connect-your-photon)
2. Copy or download the sketch found [here](https://github.com/bluzDK/particle-gateway-shield-code). You can copy+paste this into the Web IDE  and flash it to your core, or program the core locally using the CLI
3. Unplug the USB cable to your Core/Photon and place it into the socket on the gateway shield
4. Power on the shield by plugging a USB cable into either the Core or Photon, or the USB connector available on the gateway shield
5. The LED on D7 of the gateway shield will remain off until the Core/Photon is connected (breathing cyan). Once this happens, the LED on D7 for the gateway shield will blink rapidly, indicating it is connecting to the cloud*
6. After approximately 10-15 seconds, the LED on D7 of the gateway shield will blink once every 2 seconds. This indicates the gateway shield is online
7. To claim the device to your Particle account, visit the [bluz console](http://console.bluz.io/)
8. Enter your Particle account credentials

    ![hero](/img/console_login_ss.png)

9. After the website searches your devices, it should find the gateway shield and allow you to claim the device

    ![hero](/img/console_claim_ss.png)


*NOTE: If the LED on D7 does not start to blink rapidly once the Core/Photon is breathing cyan, please follow these steps:

1. Unplug the Core/Photon from the gateway shield
2. Plug the Core/Photon into a USB power source and let it power on and get to the breathing cyan state
3. While still powered, plug the Core/Photon into the gateway shield, being careful to push on the sides of the board and NOT push on the metal shielding

**Some boards shipped with firmware v1.0.47, those shipped before April 18th, 2016, may require these steps to connect. Once you update the firmware
of the gateway shield, this will no longer be necessary. Follow these steps only if the LED on the gateway shield doesn't act accordingly.**

##LED States
The LED on D7 is the indicator LED for the nrf51822 system and its connection to the cloud. The LED will have several states:
- Blinking quickly (twice a second): Attempting to connect to the Particle cloud
- Blinking slowly (once every two seconds): Connected to the Particle Cloud

When an OTA update is initiated, the LED will also blink on/off for each data chunk received, so it will blink somewhat steadily on/off.


##Gateway Shield Programming Limitations
The gateway shield requires more resources to run then bluz DK. Therefore, some peripherals or resources may not be available or may be limited.
The following is a list of differences from bluz DK to the gateway shield:
- SPI and I2C are not available on the gateway shield to the user app
- Only 1K of RAM is available to the user app
- The System.sleep(SLEEP_MODE_CPU) is not available or necessary in the user app
- There is no RGB LED for the nrf51822 on the gateway shield

Further, it is advised that no code be placed in the loop() function. This can block the gateway shield from working properly.

The bluz console can be used to claim gateway shields, update their firmware to the newest version, and program Particle devices to work with them.