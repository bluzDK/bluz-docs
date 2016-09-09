#Gateway/DK Interations

This tutorial will explain the interation between the gateway and DK. Several topics will be outlined, including how to get the best battery
performance out of a DK, how to setup private networks between DK and gateways, and how to use an Electron effectively for low data usage.

##Background
The gateway and gateway shield are devices that operate in BLE central mode and allow traffic from connected bluz DK to be forwarded to an
internet connected micrcontroller using SPI. The microcontroller, such as a Particle Photon or Electron, will then forward the traffic from
a DK to the internet.

![logo](/img/bluz_diagram_vertical_electron.png)

The gateway and DK have many settings that can alter the behavior between them. For example, the gateway will only connect to BLE devices
that advertise with a certain name. The default name that a gateway will connect to is "Bluz DK", but this can be set in the gateway itself.
Also, the advertising name of the DK can be changed. This lets you create separate networks of bluz devices.

Another major setting between the DK and gateway is the connection interval. The connection interval is the time between synchronization
events between the two, so data can only be sent once the next connection interval rolls around. By increasing this time, it increases
the time the DK can force the CPU to sleep and increases the time between radio events. This can increase battery life, but alternatively
will decrease throughput. For applications that don't need constant OTA updates, this can significantly reduce power consumption.

