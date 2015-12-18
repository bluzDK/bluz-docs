#Bluz DK

![hero](/img/gw_shield.jpg)

Bluz DK is the main development board. It contains an ARM Cortex-M0 that runs at 16MHz, 32K Ram, 256K Flash, and a load of hardware peripherals (UART, SPI, I2C, etc.)

Bluz is also outfitted with 2Mb (256KB) external SPI flash. This is used to store backup firmware, system flags, and to download new over the air firmware images.

And, of course, it contains the Bluetooth LE radio and stack, giving bluz it's power-sipping wireless performance.

##Guide
![Bluz DK](/img/bluz_GatewayShield_guide.png)

The following are the major components on the gateway shield along with their purpose:

- External SPI Flash: Used to store ID, keys, factory reset firmware, and OTA updates when they are downloaded.
- LED on D7: This is a user controllable LED, just set pin D7 to HIGH to turn it on.
- Reset Button: Will reboot bluz and the Photon/Electron.
- nrf51822 Module: Contains the nrf51822 along with the antenna.
- SWD Header: Used to program the nrf51822 with JTAG
- Power LED: Indicates the board is powered
- USB for Power: This provides power to the board, through the on-board linear regulator. This port does not provide USB communication to the Photon or nrf51

