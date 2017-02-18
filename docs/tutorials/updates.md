#Loading Firmware

Bluz offers several ways of loading new firmware, including Over the Air through the Bluetooth LE link and hardwired through UART. While there
is an amazing amount of functionality packed into each bluz board, the one noticeable piece that is lacking is a USB port. This means there
needs to be a little planning to make sure you can always load new firmware.

There are two main ways to load new firmware:

- Over the Air
- Through UART

This tutorial will go over both in detail and point out any potential pitfalls that may arise.

##Firmware Parts
The bluz firmware consists of 4 major parts. They each reside in the internal flash of the Nordic nrf51822 and each play a very specific role.

1. The Nordic SoftDevice is the BLE Stack provided as a binary file from Nordic Semiconductor. This runs the BLE radio on-board.
2. The System Firmware. This contains all the code that makes bluz run on Particle, act like an Arduino, and generally run. This is
a separate binary file that gets created from the build system and flashed down.
3. The User App. This is where the code the user generates lives. When you write a sketch with the setup() and loop() functions, it builds a
separate  binary from this code that links to the system firmware at runtime.
4. The Bootloader. This is what performs copies of system updates, and also handles Setup Mode. The bootloader will make sure everything looks
right in the system before handing control over to the system firmware.

![hero](/img/firmware_pieces.jpg)

Because of this architecture, all the system functionality can be stored in the system firmware and it will only need to be updated between
major releases. This keeps the user app as small as possible, meaning most OTA updates of your code happen very quickly.

As the system firmware and user app link to eachother at runtime, there is a dependency mechanism to make sure they are compatible. If the
user app was trying to link to older system firmware that didn't have the required functionality, this would hang the system. So the system
firmware, which always launches first, checks that the user app is compatible. If it is not, then the system enters Safe Mode. In this mode,
the user app will not run (the setup() and loop()) functions will not be called). However, the system can still do everything else: get online,
receive OTA updates, etc. This state is signified by blinking magenta on the RGB LED.

When you make an update of code, for example from the Web IDE, you are updating the user app. The system can detect if there is then a
mismatch, enter Safe Mode, and still get online. If this happens, the cloud will automatically update the system firmware to the one
compatible with the user app. As the system firmware binary is large, it can take some time to complete.

**NOTE:** It is recommended to do system updates with the app if possible. Firmware updates will happen faster with the app as a gateway then
using the physical gateway or gateway shield.

##Over the Air
Firmware can be updated several ways over the Bluetooth LE link. The important piece to note is that you must have Bluetooth LE turned
on and advertising, and you must have a gateway, either the bluz made ones or the Android or iOS apps. It is possible
to [turn Bluetooth LE off](/reference/ble/#stopadvertising) when using bluz. One must be careful when doing this to turn Bluetooth back
on, or have another plan for updating firmware. You could get yourself into a situation where Bluetooth isn't turned back on and you
must update firmware another way or perform a factory reset.

When updating firmware over the air, the basic procedure will be as follows:

1. Your bluz DK must be online and flashing cyan
2. Start a firmware update through the Web IDE or CLI, the bluz board will begin to blink Magenta. Each blink equals one 512 byte chunk of firmware downloaded and saved.
3. Once this is complete, the RGB LED will turn solid blue, indicating the firmware is being copied to the internal flash.
4. If it is not in safe mode, it will blink green and the update is complete. If it is in Safe Mode, it will blink magenta and the update will continue to the next step.
5. Once bluz is back online in Safe Mode, the cloud will attempt to download the proper system part. This could take minutes, and will again be indicated by flashing magenta
6. Once the system part is downloaded, the LED will again turn solid blue, indicating the firmware is being copied to internal flash.
7. Once this is complete, bluz will start up and blink green.

**NOTE:** When the LED is solid blue, turning off bluz can cause issues. At this point, the internal flash is being overwritten, turning it off
will mean the flash is in a corrupted state and bluz may not reboot properly. If this happens, you can use a Factory Reset to recover.

###Web IDE
The first, and easiest, is to use the [Particle Web IDE](https://build.particle.io/build). This is an online IDE that you
can login to, write and save your code, and deploy it to bluz. You will write sketches as you would in the Arduino IDE,
then deploy easily over the air. You can find detailed instructions about how to use the IDE
[here.](https://docs.particle.io/guide/getting-started/build/photon/). You can flash user apps with this method, the system firmware will
get updated automatically for you if you enter safe mode.

###Particle CLI
You can download the bluz source code, build locally, and use the CLI to deploy. This is a more advanced method of loading firmware, but
may be necessary if you need to change the underlying functionality of bluz. You can access the source code on the
[bluz GitHub account](https://github.com/bluzDK/bluzDK-firmware), and follow the
[Particle CLI instructions](https://docs.particle.io/reference/cli/#particle-flash) for loading firmware. You can flash user apps and the system
part with this method.

##UART
You can also flash firmware to bluz through UART. This requires setting up the pieces to [talk serial](/tutorials/serial/) to bluz
and then using the [bootloader](/tutorials/bootloader/#entering-bootloader-setup-mode) to enter safe mode and flash new firmware. This does
require extra hardware, so make sure you have the correct pieces if you rely upon loading firmware throgh UART. You can flash user apps and the system
part with this method.

##Factory Reset
If you do find yourself in a situation where you cannot upload firmware, have no fear! You can
[perform a factory reset](/tutorials/bootloader/#performing-a-factory-reset) which will roll
your bluz board back to a known state with only the system firmware in place. In this state, you can use a gateway to connect to the cloud
and upload new apps.
