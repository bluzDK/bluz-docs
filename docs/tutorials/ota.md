#OTA Updates

This tutorial will walk you through updating your bluz board with new firmware through the Particle cloud.

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

