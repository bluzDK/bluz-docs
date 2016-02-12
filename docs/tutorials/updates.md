#Loading Firmware

Bluz offers several ways of loading new firmware, including Over the Air through the Bluetooth LE link and hardwired through UART. While there
is an amazing amount of functionality packed into each bluz board, the one noticeable piece that is lacking is a USB port. This means there
needs to be a little planning to make sure you can always load new firmware.

There are two main ways to load new firmware:

- Over the Air
- Through UART

This tutorial will go over both in detail and point out any potential pitfalls that may arise.

##Over the Air
Firmware can be updated several ways over the Bluetooth LE link. The important piece to note is that you must have Bluetooth LE turned
on and advertising, and you must have a gateway, either the bluz made ones or the Android or iOS apps. It is possible
to [turn Bluetooth LE off](/reference/ble/#stopadvertising) when using bluz. One must be careful when doing this to turn Bluetooth back
on, or have another plan for updating firmware. You could get yourself into a situation where Bluetooth isn't turned back on and you
must update firmware another way or perform a factory reset.

###Web IDE
The first, and easiest, is to use the [Particle Web IDE](https://build.particle.io/build). This is an online IDE that you
can login to, write and save your code, and deploy it to bluz. You will write sketches as you would in the Arduino IDE,
then deploy easily over the air. You can find detailed instructions about how to use the IDE
[here.](https://docs.particle.io/guide/getting-started/build/photon/)

###Particle CLI
You can download the bluz source code, build locally, and use the CLI to deploy. This is a more advanced method of loading firmware, but
may be necessary if you need to change the underlying functionality of bluz. You can access the source code on the
[bluz GitHub account](https://github.com/bluzDK/bluzDK-firmware), and follow the
[Particle CLI instructions](https://docs.particle.io/reference/cli/#particle-flash) for loading firmware.

##UART
You can also flash firmware to bluz through UART. This requires setting up the pieces to [talk serial](/tutorials/serial/) to bluz
and then using the [bootloader](/tutorials/bootloader/#entering-bootloader-setup-mode) to enter safe mode and flash new firmware. This does
require extra hardware, so make sure you have the correct pieces if you rely upon loading firmware throgh UART.

##Factory Reset
If you do find yourself in a situation where you cannot upload firmware, have no fear! You can
[perform a factory reset](/tutorials/bootloader/#performing-a-factory-reset) which will roll
your bluz board back to a known state with only the system firmware in place. In this state, you can use a gateway to connect to the cloud
and upload new apps.