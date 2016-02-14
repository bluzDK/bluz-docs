#Gateway Shield

![hero](/img/gw_shield.jpg)

The bluz gateway shield is one of the special features of bluz. By pairing the shield with a Particle Photon or Electron (not provided),
you can give bluz access to the cloud at all times using WiFi or cellular as the back-end connection. It is basically a
bridge from Bluetooth LE to the internet. This allows you to place the most power-hungry portion of your deployment in
a central location with a constant power source, then place many battery powered bluz boards wherever you may need.

The gateway shield works by using an nrf51822 in central mode, allowing up to 8 bluz boards to connect at once. The shield
then uses SPI to talk to the provided Photon/Electron, which opens the TCP sockets to the Particle cloud.

The gateway shield can be programmed just like bluz, the nrf51822 central will show up as a separate device class in your
Particle account. Breakout pins allow you to add sensors or other devices.

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

