#Beacon

_Requires v2.2.50 or higher_

This library allows you to turn bluz into various beacon types that can be used to trigger apps and other devices when they come into proximity.

**NOTE:** When bluz is configured as a beacon, it wil not automatically connect to bluz hardware gateways. The only way to get the device back online for reprogramming is through the iOS/Android app

## beacon(uint32_t major, uint32_t minor, uint8_t *UUID)

Starts advertising as a beacon with a major, minor, and UUID. This will put bluz into a state that is similar to popular beacon protocols used by major smartphone manufacturers

The advertising packet will include the major, minor, and UUID specified, as well as the RSSI of the device from 1 meter. The RSSI will be adjusted based on the power set from BLE.setTxPower()


`major` is the major value to be advertised

`minor` is the minor value to be advertised

`UUID` is the UUID to be advertised, should be exactly 16 bytes long


```C++
    uint16_t major = 765;
    uint16_t minor = 4321;
    uint8_t UUID[16] = {0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40, 0xb1, 0xe2, 0x40, 0x40};

    void setup() {
        BLE.beacon(major, minor, UUID);
    }
```

## eddystone_url_beacon(char *url)

Starts advertising as an Eddystone beacon with the specified URL, allowing Physical Web enabled apps to read and display it to the user.

The advertising packet will include the URL as well as the Tx Power of the device. The Tx Power will be adjusted based on the power set from BLE.setTxPower()

`url` is the URL to be displayed to the Physical Web enabled application. The value will be parsed, so the prefix (e.g. http:// or http://www.) will convert to a one-byte code. The remainder of the URL must be 17 characters or less, values longer will be truncated


```C++
    void setup() {
        BLE.eddystone_url_beacon("https://bluz.io");
    }
```

