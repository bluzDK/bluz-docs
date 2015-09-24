#Getting Started

This tutorial will walk you through getting your bluz board connected for the first time. If you are just unboxing bluz, this is the perfect place to start.

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- One of the following:
    - Bluz Gateway Shield
    - Bluz Gateway
    - Bluz app for iOS or Android

##Gateway Shield Setup

1. Take a Particle Core or Photon and power it on, connect it to the cloud, and program it with the sketch found [here](https://github.com/bluzDK/bluz-beta/tree/master/gateway/photon-sketch-0.1.0). For more documentation on connecting and programming the Particle devices, please see [here](https://docs.particle.io/guide/getting-started/start/photon/).
2. Place the programmed Core or Photon into the socket on the gateway shield
3. Power on the shield by plugging a USB cable into either the Core or Photon, or the USB connector available on the gateway shield
4. Wait for the Core or Photon to connect to the cloud.
5. Once your bluz DK is powered on, it will now automatically connect.

##Powering on bluz

1. Power bluz by either placing it in the battery shield and turning it on, feeding regulated 3.0V-3.3V to the 3V3 pin, or feeding unregulated 3.7V-6.0V to the VIN pin.
2. Bluz will power on and the LED will start to slowly blink green, about once every 2 seconds. This indicates bluz is advertising and can be connected.

![logo](/img/bluz_advertising.gif)


##App Selection
1. If you are using the app to connect, you can download the available iOS and Android apps from bluz from the app store.
2. Login to the app with your Particle account credentials.
3. Once bluz is powered on, it will appear in the list of available devices where you can select it to connect bluz to the cloud.

![logo](/img/app_screenshot.png)

##Cloud Connection
1. Once you power bluz on with the gateway turned on, or select it from the app, bluz will start to connect to the cloud. This is indicated by the LED quickly flashing green.

    ![logo](/img/bluz_connecting.gif)


2. After approximately 10-30 seconds, the LED should change to a slow blinking cyan color. This indicates bluz is now connected to the cloud.

    ![logo](/img/bluz_connected.gif)


3. If the LED changes to magenta, this means the cloud connection was unsuccessful. Please see the TroubleShooting guide.
4. If the LED starts to flash red, this is called an SOS sequence. It will flash quickly three times ('S'), slowly three times ('O'), and then quickly three times again ('S'). This will then be followed by a series of flashes which you can count to get the specific error code. The SOS sequence will repeat twice and bluz will then reboot. You can refer to the trobleshooting guide for information about your specific error code.



