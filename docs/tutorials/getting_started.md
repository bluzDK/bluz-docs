#Getting Started

This tutorial will walk you through getting your bluz board connected for the first time. If you are just unboxing bluz, this is the perfect place to start.

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- A Particle account (if you don't have one, you can sign up [here](https://dashboard.particle.io/login))
- One of the following:
    - Bluz Gateway Shield
    - Bluz Gateway
    - Bluz app for iOS or Android

##Particle Account
Access to the Particle cloud is one of the many advantages of bluz over other Bluetooth LE development kits. This access allows bluz to be controlled
and programmed from anywhere in the world through a simple REST API.

If you are unfamiliar with the Particle Cloud, we recomend you read some of their documentation first to familiarize yourself with the enviroment. These are some good
topics to start with:

- [Tools and Features](https://docs.particle.io/guide/tools-and-features/intro/) provides a general overview of the available features for bluz
- [Web IDE](https://docs.particle.io/guide/getting-started/build/photon/) which you can use to program bluz Over the Air
- [Cloud API](https://docs.particle.io/reference/api/) is an overview of the REST API available to bluz
- [Command Line Interface (CLI)](https://docs.particle.io/reference/cli/) gives flexible control over your device
- [How to Build a Product](https://docs.particle.io/guide/how-to-build-a-product/intro/) helps take you from prototype to production with Particle and bluz

**Once you are familiar with Particle and have created an account, the following steps guide you through connecting bluz to the cloud.**

##Powering on bluz

1. Power bluz by either placing it in the battery shield and turning it on, feeding regulated 3.0V-3.3V to the 3V3 pin, or feeding unregulated 3.7V-6.0V to the VIN pin.
2. Bluz will power on and the LED will start to slowly blink green, about once every 2 seconds. This indicates bluz is advertising and can be connected.

![logo](/img/bluz_advertising.gif)


##App Selection

If this is your first time setting up a new device, it is recomended you use the bluz app. This will ensure the device is claimed to your account
and is the most seamless way.

1. If you are using the app to connect, you can download the available iOS and Android apps from bluz from the app store.
2. Login to the app with your Particle account credentials.
3. Once bluz is powered on, it will appear in the list of available devices where you can select it to connect bluz to the cloud.

![logo](/img/app_screenshot.png)

##Gateway Shield Setup

If this is an existing device on your account, or you know the device ID of your bluz device, you can use the gateway shield to connect. 

1. Take a Particle Core or Photon and power it on, connect it to the cloud, and program it with the sketch found [here](https://github.com/bluzDK/bluz-beta/tree/master/gateway/photon-sketch-0.1.0). For more documentation on connecting and programming the Particle devices, please see [here](https://docs.particle.io/guide/getting-started/start/photon/).
2. Place the programmed Core or Photon into the socket on the gateway shield
3. Power on the shield by plugging a USB cable into either the Core or Photon, or the USB connector available on the gateway shield
4. Wait for the Core or Photon to connect to the cloud.
5. Once your bluz DK is powered on, it will now automatically connect.

##Cloud Connection
1. Once you power bluz on with the gateway turned on, or select it from the app, bluz will start to connect to the cloud. This is indicated by the LED quickly flashing green.

    ![logo](/img/bluz_connecting.gif)


2. After approximately 10-30 seconds, the LED should change to a slow blinking cyan color. This indicates bluz is now connected to the cloud.

    ![logo](/img/bluz_connected.gif)


3. If the LED changes to magenta, this means the cloud connection was unsuccessful. Please see the TroubleShooting guide.
4. If the LED starts to flash red, this is called an SOS sequence. It will flash quickly three times ('S'), slowly three times ('O'), and then quickly three times again ('S'). If you experience this, you can look to the [Troubleshooting guide](../troubleshooting/sos.md) for more help.

##Claim your device
Once your device is connected to the cloud, you need to claim it, which means the device is associated to your account so only you can control it.
If you are using the bluz app, this will be done automatically and there is nothing further required. If you are using the gateway shield, you
need to claim your device either through the [Particle CLI](https://docs.particle.io/reference/cli/#particle-device-add),
the [Particle Web IDE](https://build.particle.io/login) (by clicking on the Devices icon and selecting 'Add New Device'),
or the [REST API](https://docs.particle.io/reference/api/#claim-a-device).

Once the device is claimed to your account, you will see it in your list of devices and can program it Over the Air.



