#Getting Started

This tutorial will walk you through getting your bluz board connected for the first time. If you are just unboxing bluz, this is the perfect place to start.

For this tutorial, you will need:

- One bluz DK
- One power source (battery shield, battery, USB line, etc.)
- A Particle account (if you don't have one, you can sign up [here](https://dashboard.particle.io/login))
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

1. If you are using the app to connect, you can download the available iOS and Android apps from the app store.
[<img src="/img/app_store_logo.png">](https://itunes.apple.com/us/app/bluz/id1068381227?ls=1&mt=8)
[<img src="/img/google-play-badge.png">](https://play.google.com/store/apps/details?id=com.banc.sparkle_gateway)

2. Login to the app with your Particle account credentials by clicking the 'Login' button on the top left.
![logo](/img/ios_app_login.png)

3. The app will scan for 30 seconds. When bluz is powered on during this time, it will appear in the list and you can click Connect

![logo](/img/ios_app.png)

##Cloud Connection
1. Once you power bluz and it is selected from the app, bluz will start to connect to the cloud. This is indicated by the LED quickly flashing green.

    ![logo](/img/bluz_connecting.gif)


2. After approximately 10-30 seconds, the LED should change to a slow blinking cyan color. This indicates bluz is now connected to the cloud.

    ![logo](/img/bluz_connected.gif)


3. If the LED changes to magenta, this means the cloud connection was unsuccessful. Please see the TroubleShooting guide.
4. If the LED starts to flash red, this is called an SOS sequence. It will flash quickly three times ('S'), slowly three times ('O'), and then quickly three times again ('S'). If you experience this, you can look to the [Troubleshooting guide](../troubleshooting/sos.md) for more help.

##Claim your device
Once your device is connected to the cloud, you need to claim it, which means the device is associated to your account so only you can control it.
Approximately 30 seconds after you connect the device ID will display and a Claim button will appear. You can
click this to claim your device.

Once the device is claimed to your account, you will see it in your list of devices and can program it Over the Air.



