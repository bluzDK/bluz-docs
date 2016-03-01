#Bootloader Updating

This tutorial will explain how to upload new firmware and keys through the bootloder. It will also go over resetting bluz to factory firmware.

##Bootloader
The bluz bootloader is the piece of code that runs before the main firmware starts. The bootloader does three things:

1. Check if the user wants to enter setup mode, which is accomplished by pressing BTN as bluz is powered on
2. Check if there are any firmware updates to load
3. Launch the main code

Setup mode can also be broken down into two parts:

1. Update firmware
2. Perform a factory reset

Performing a factory reset will reset the firmware to the default. This can be useful if bluz has been loaded with bad firmware
or is otherwise not recoverable.

This tutorial will cover how to enter setup mode, and how to perform a reset or upload keys or new code to bluz. The bootloader talks to a
PC through UART, and since there is no USB connector on bluz, you will need a converter. You can see our tutorial on
[Talking Serial to Bluz](../tutorials/serial.md) for information on what hardware you will need and how to hook it up.

Through setup mode in the bootloader, you can upload firmware modules or the keys used to talk to the Particle cloud.
Currently, a series of scripts is provided to perform these updates, but this will soon be replaced by a CLI package that
can be installed and run on your PC. The scripts for each part can be found here: [https://github.com/bluzDK/bootloader_scripts](https://github.com/bluzDK/bootloader_scripts)

The scripts are written in python and require version 2.7 to be installed.

##Performing a factory reset
To enter the bootloader setup mode, you must perform the following steps:

1. Hold the reset button or power bluz off completely
2. Press and hold the BTN button
3. Release the reset button, or power bluz on
4. The RGB LED will imediately start flashing magenta quickly
5. Continue to hold BTN for approximately 3 seconds until the RGB LED changes to blinking yellow quickly
5. Continue to hold BTN for approximately 7 more seconds until the RGB LED changes to blinking white quickly
6. Release BTN. The RGB LED will turn blue while new firmware is copied. Do not power off bluz during this time
7. After approximately 10-20 seconds, bluz will reboot and start flashing magenta slowly, it is now in Setup Mode and can be
connected to the cloud for furhter updates


##Entering Bootloader Setup Mode
To enter the bootloader setup mode, you must perform the following steps:

1. Hold the reset button or power bluz off completely
2. Press and hold the BTN button
3. Release the reset button, or power bluz on
4. The RGB LED will imediately start flashing magenta quickly
5. Continue to hold BTN for approximately 3-5 seconds until the RGB LED changes to blinking yellow quickly
6. Release BTN. The RGB LED will stay on as solid yellow.
7. You are now in bootloader setup mode

![hero](/img/bootloader_setup.jpg)

Once in setup mode, you can connect with any terminal application at 38400 baud rate. You can use the following commands to get information:

    f - update firmware
    u - update public key
    r - update private key
    e - exit and boot
    v - version
    h - help

Note that to update the firmware or keys, you should follow the instructions below.

##Updating Firmware
You can flash any module built portion of the bluz firmware, including system and user parts. The file must be a .bin file,
and not a .hex or .elf file. These can be built locally from the (firmware repository)[https://github.com/bluzDK/bluzDK-firmware].

To update firmware, you must perform the following steps:

1. Enter Setup Mode as described above
2. Run the command:

    > python update_fw.py -s [serial port*]

    where [serial port] is the port you are using to talk to bluz (either COM on Windows or /dev/tty.xzy... on linux/OS X)

3. The script will prompt you for a filename, enter the name of the file with full path
4. While the file is being downloaded, the RGB LED will toggle between magenta and blue
5. Once it is completed downloading, bluz will restart and boot normally to run your new firmware


##Updating Keys
Keys are used for encryption between bluz and the Particle cloud. There are two sets of keys, one for the cloud and one for bluz. Each
set has a public and private portion. There is a set for bluz where bluz has a private key and the cloud as the public version.
Similrarly, the cloud has a set where the cloud has a private key and bluz has the public key. As long as you are using the public
Particle cloud, you do not need to update the public key in bluz.

You should only need to update the keys for bluz if you are changing from the public cloud to a separately hosted one. To do this, you
will need the (Particle CLI)[https://docs.particle.io/guide/getting-started/connect/electron/] installed.

###To update the private key on bluz, and subsequently sent the public key to the cloud, you must perform the following steps:

1. Enter Setup Mode as described above
2. Run the command:

    > particle keys new --protocol tcp

3. Three files will get create, device.der, device.pem and device.pub.pem.
4. Make sure the CLI is pointed to the cloud you wish bluz to connect to, then run the command:

    > particle keys send [device ID] device.pub.pem

5. Run the command:

    > python update_private_key.py -s [serial port]

    where [serial port] is the port you are using to talk to bluz (either COM on Windows or /dev/tty.xzy... on linux/OS X)

6. The script will prompt you for a filename, enter the name of the file device.der with full path
7. While the file is being downloaded, the RGB LED will toggle between magenta and blue
8. Once it is completed downloading, bluz will stay in setup mode. You can now reset the device and connect to the cloud


###To update the public key on bluz, you must perform the following steps:

1. Enter Setup Mode as described above
2. Run the command:

    > python update_public_key.py -s [serial port]

    where [serial port] is the port you are using to talk to bluz (either COM on Windows or /dev/tty.xzy... on linux/OS X)

3. The script will prompt you for a filename, enter the name of the file xyz.pub.pem with full path
4. While the file is being downloaded, the RGB LED will toggle between magenta and blue
5. Once it is completed downloading, bluz will stay in setup mode. You can now reset the device and connect to the cloud
