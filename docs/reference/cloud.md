# Cloud Functions

## Spark.variable()

Expose a *variable* through the Cloud so that it can be called with `GET /v1/devices/{DEVICE_ID}/{VARIABLE}`.
Returns a success value - `true` when the variable was registered.

It is fine to call this function when the cloud is disconnected - the variable
will be registered next time the cloud is connected.

```C++
// EXAMPLE USAGE

int analogvalue = 0;
double tempC = 0;
char *message = "my name is particle";

void setup()
{
  // variable name max length is 12 characters long
  Spark.variable("analogvalue", &analogvalue, INT);
  Spark.variable("temp", &tempC, DOUBLE);
  if (Spark.variable("mess", message, STRING)==false)
      // variable not registered!
  pinMode(A0, INPUT);
}

void loop()
{
  // Read the analog value of the sensor (TMP36)
  analogvalue = analogRead(A0);
  //Convert the reading into degree celcius
  tempC = (((analogvalue * 3.3)/4095) - 0.5) * 100;
  delay(200);
}
```
Currently, up to 10 cloud variables may be defined and each variable name is limited to a max of 12 characters.

There are three supported data types:

 * `INT`
 * `DOUBLE`
 * `STRING`   (maximum string size is 622 bytes)




```json
# EXAMPLE REQUEST IN TERMINAL
# Device ID is 0123456789abcdef
# Your access token is 123412341234
curl "https://api.particle.io/v1/devices/0123456789abcdef/analogvalue?access_token=123412341234"
curl "https://api.particle.io/v1/devices/0123456789abcdef/temp?access_token=123412341234"
curl "https://api.particle.io/v1/devices/0123456789abcdef/mess?access_token=123412341234"

# In return you'll get something like this:
960
27.44322344322344
my name is particle

```

## Spark.function()

Expose a *function* through the Cloud so that it can be called with `POST /v1/devices/{DEVICE_ID}/{FUNCTION}`.

```cpp
// SYNTAX TO REGISTER A CLOUD FUNCTION
bool success = Spark.function("funcKey", funcName);
//                ^
//                |
//     (max of 12 characters long)
```

Currently the application supports the creation of up to 4 different cloud functions.

In order to register a cloud  function, the user provides the `funcKey`, which is the string name used to make a POST request and a `funcName`, which is the actual name of the function that gets called in your app. The cloud function can return any integer; `-1` is commonly used for a failed function call.

The length of the `funcKey` is limited to a max of 12 characters. If you declare a function name longer than 12 characters the function will not be registered.

Example: Spark.function("someFunction1", ...); exposes a function called someFunction and not someFunction1

A cloud function is set up to take one argument of the [String](#language-syntax-string-class) datatype. This argument length is limited to a max of 63 characters.

```cpp
// EXAMPLE USAGE

int brewCoffee(String command);

void setup()
{
  // register the cloud function
  Spark.function("brew", brewCoffee);
}

void loop()
{
  // this loops forever
}

// this function automagically gets called upon a matching POST request
int brewCoffee(String command)
{
  // look for the matching argument "coffee" <-- max of 64 characters long
  if(command == "coffee")
  {
    // some example functions you might have
    //activateWaterHeater();
    //activateWaterPump();
    return 1;
  }
  else return -1;
}
```

---

You can expose a method on a C++ object to the Cloud.

```C++
// EXAMPLE USAGE WITH C++ OBJECT

class CoffeeMaker {
  public:
    CoffeeMaker() {
      Spark.function("brew", &CoffeeMaker::brew, this);
    }

    int brew(String command) {
      // do stuff
      return 1;
    }
};

CoffeeMaker myCoffeeMaker;
// nothing else needed in setup() or loop()
```

---

The API request will be routed to the device and will run your brew function. The response will have a return_value key containing the integer returned by brew.

```json
COMPLEMENTARY API CALL
POST /v1/devices/{DEVICE_ID}/{FUNCTION}

# EXAMPLE REQUEST
curl https://api.particle.io/v1/devices/0123456789abcdef/brew \
     -d access_token=123412341234 \
     -d "args=coffee"
```

## Spark.publish()

Publish an *event* through the Particle Cloud that will be forwarded to all registered callbacks, subscribed streams of Server-Sent Events, and other devices listening via `Spark.subscribe()`.

This feature allows the device to generate an event based on a condition. For example, you could connect a motion sensor to the device and have the device generate an event whenever motion is detected.

Cloud events have the following properties:

* name (1–63 ASCII characters)
* public/private (default public)
* ttl (time to live, 0–16777215 seconds, default 60)
  !! NOTE: The user-specified ttl value is not yet implemented, so changing this property will not currently have any impact.
* optional data (up to 255 bytes)

Anyone may subscribe to public events; think of them like tweets.
Only the owner of the device will be able to subscribe to private events.

A device may not publish events beginning with a case-insensitive match for "spark".
Such events are reserved for officially curated data originating from the Cloud.

Calling `Spark.publish()` when the device is not connected to the cloud will not
result in an event being published. This is indicated by the return success code
of `false`.

For the time being there exists no way to access a previously published but TTL-unexpired event.

**NOTE:** Currently, a device can publish at rate of about 1 event/sec, with bursts of up to 4 allowed in 1 second. Back to back burst of 4 messages will take 4 seconds to recover.

---

Publish a public event with the given name, no data, and the default TTL of 60 seconds.

```C++
// SYNTAX
Spark.publish(const char *eventName);
Spark.publish(String eventName);

RETURNS
boolean (true or false)

// EXAMPLE USAGE
bool success;
success = Spark.publish("motion-detected");
if (!success) {
  // get here if event publish did not work
}
```

---

Publish a public event with the given name and data, with the default TTL of 60 seconds.

```C++
// SYNTAX
Spark.publish(const char *eventName, const char *data);
Spark.publish(String eventName, String data);

// EXAMPLE USAGE
Spark.publish("temperature", "19 F");
```

---

Publish a public event with the given name, data, and TTL.

```C++
// SYNTAX
Spark.publish(const char *eventName, const char *data, int ttl);
Spark.publish(String eventName, String data, int ttl);

// EXAMPLE USAGE
Spark.publish("lake-depth/1", "28m", 21600);
```

---

Publish a private event with the given name, data, and TTL.
In order to publish a private event, you must pass all four parameters.

```C++
// SYNTAX
Spark.publish(const char *eventName, const char *data, int ttl, PRIVATE);
Spark.publish(String eventName, String data, int ttl, PRIVATE);

// EXAMPLE USAGE
Spark.publish("front-door-unlocked", NULL, 60, PRIVATE);
```

Publish a private event with the given name.

```C++
// SYNTAX
Spark.publish(const char *eventName, PRIVATE);
Spark.publish(String eventName, PRIVATE);

// EXAMPLE USAGE
Spark.publish("front-door-unlocked", PRIVATE);
```


```json
COMPLEMENTARY API CALL
GET /v1/events/{EVENT_NAME}

# EXAMPLE REQUEST
curl -H "Authorization: Bearer {ACCESS_TOKEN_GOES_HERE}" \
    https://api.particle.io/v1/events/motion-detected

# Will return a stream that echoes text when your event is published
event: motion-detected
data: {"data":"23:23:44","ttl":"60","published_at":"2014-05-28T19:20:34.638Z","deviceid":"0123456789abcdef"}
```

## Spark.subscribe()

Subscribe to events published by devices.

This allows devices to talk to each other very easily.  For example, one device could publish events when a motion sensor is triggered and another could subscribe to these events and respond by sounding an alarm.

```cpp
int i = 0;

void myHandler(const char *event, const char *data)
{
  i++;
  Serial.print(i);
  Serial.print(event);
  Serial.print(", data: ");
  if (data)
    Serial.println(data);
  else
    Serial.println("NULL");
}

void setup()
{
  Spark.subscribe("temperature", myHandler);
  Serial.begin(9600);
}
```

To use `Spark.subscribe()`, define a handler function and register it in `setup()`.


---

You can listen to events published only by your own devices by adding a `MY_DEVICES` constant.

```cpp
// only events from my devices
Spark.subscribe("the_event_prefix", theHandler, MY_DEVICES);
```

---

You are also able to subscribe to events from a single device by specifying the device's ID.

```cpp
// Subscribe to events published from a specific device
Spark.subscribe("motion/front-door", motionHandler, "55ff70064989495339432587");
```

---

You can register a method in a C++ object as a subscription handler.

```cpp
class Subscriber {
  public:
    void subscribe() {
      Particle.subscribe("some_event", &Subscriber::handler, this);
    }
    void handler(const char *eventName, const char *data) {
      Serial.println(data);
    }
};

Subscriber mySubscriber;
// nothing else needed in setup() or loop()
```

---

A subscription works like a prefix filter.  If you subscribe to "foo", you will receive any event whose name begins with "foo", including "foo", "fool", "foobar", and "food/indian/sweet-curry-beans".

Received events will be passed to a handler function similar to `Spark.function()`.
A _subscription handler_ (like `myHandler` above) must return `void` and take two arguments, both of which are C strings (`const char *`).

- The first argument is the full name of the published event.
- The second argument (which may be NULL) is any data that came along with the event.

`Spark.subscribe()` returns a `bool` indicating success. It is ok to register a subscription when
the device is not connected to the cloud - the subscription is automatically registered
with the cloud next time the device connects.

**NOTE:** A device can register up to 4 event handlers. This means you can call `Spark.subscribe()` a maximum of 4 times; after that it will return `false`.

## Spark.unsubscribe()

Removes all subscription handlers previously registered with `Spark.subscribe()`.

```cpp
// SYNTAX
Spark.unsubscribe();
```

## Spark.connect()

`Spark.connect()` connects the device to the Cloud. This will automatically activate the Wi-Fi module and attempt to connect to a Wi-Fi network if the device is not already connected to a network.

```cpp
void setup() {}

void loop() {
  if (Spark.connected() == false) {
    Spark.connect();
  }
}
```

After you call `Spark.connect()`, your loop will not be called again until the device finishes connecting to the Cloud. Typically, you can expect a delay of approximately one second.

In most cases, you do not need to call `Spark.connect()`; it is called automatically when the device turns on. Typically you only need to call `Spark.connect()` after disconnecting with [`Spark.disconnect()`](#spark-disconnect) or when you change the [system mode](#system-system-modes).


## Spark.disconnect()

`Spark.disconnect()` disconnects the device from the Cloud.

```C++
int counter = 10000;

void doConnectedWork() {
  digitalWrite(D7, HIGH);
  Serial.println("Working online");
}

void doOfflineWork() {
  digitalWrite(D7, LOW);
  Serial.println("Working offline");
}

bool needConnection() {
  --counter;
  if (0 == counter)
    counter = 10000;
  return (2000 > counter);
}

void setup() {
  pinMode(D7, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if (needConnection()) {
    if (!Spark.connected())
      Spark.connect();
    doConnectedWork();
  } else {
    if (Spark.connected())
      Spark.disconnect();
    doOfflineWork();
  }
}
```

While this function will disconnect from the Cloud, it will keep the connection to the Wi-Fi network. If you would like to completely deactivate the Wi-Fi module, use [`WiFi.off()`](#wifi-off).

**NOTE:* When the device is disconnected, many features are not possible, including over-the-air updates, reading Spark.variables, and calling Spark.functions.

*If you disconnect from the Cloud, you will NOT BE ABLE to flash new firmware over the air. A factory reset should resolve the issue.*

## Spark.connected()

Returns `true` when connected to the Cloud, and `false` when disconnected from the Cloud.

```C++
// SYNTAX
Spark.connected();

RETURNS
boolean (true or false)

// EXAMPLE USAGE
void setup() {
  Serial.begin(9600);
}

void loop() {
  if (Spark.connected()) {
    Serial.println("Connected!");
  }
  delay(1000);
}
```

## Spark.process()

Runs the background loop. This is the public API for the former internal function
`SPARK_WLAN_Loop()`.

`Spark.process()` checks the Wi-Fi module for incoming messages from the Cloud,
and processes any messages that have come in. It also sends keep-alive pings to the Cloud,
so if it's not called frequently, the connection to the Cloud may be lost.

```cpp
void setup() {
  Serial.begin(9600);
}

void loop() {
  while (1) {
    Spark.process();
    redundantLoop();
  }
}

void redundantLoop() {
  Serial.println("Well that was unnecessary.");
}
```

`Spark.process()` is a blocking call, and blocks for a few milliseconds. `Spark.process()` is called automatically after every `loop()` and during delays. Typically you will not need to call `Spark.process()` unless you block in some other way and need to maintain the connection to the Cloud, or you change the [system mode](#system-system-modes). If the user puts the device into `MANUAL` mode, the user is responsible for calling `Spark.process()`. The more frequently this function is called, the more responsive the device will be to incoming messages, the more likely the Cloud connection will stay open, and the less likely that the WiFi module's buffer will overrun.

## Spark.syncTime()

Synchronize the time with the Particle Cloud.
This happens automatically when the device connects to the Cloud.
However, if your device runs continuously for a long time,
you may want to synchronize once per day or so.

```C++
#define ONE_DAY_MILLIS (24 * 60 * 60 * 1000)
unsigned long lastSync = millis();

void loop() {
  if (millis() - lastSync > ONE_DAY_MILLIS) {
    // Request time synchronization from the Particle Cloud
    Spark.syncTime();
    lastSync = millis();
  }
}
```

Note that this function sends a request message to the Cloud and then returns.
The time on the device will not be synchronized until some milliseconds later
when the Cloud responds with the current time between calls to your loop.

## Get Public IP

Using this feature, the device can programmatically know its own public IP address.

```cpp
// Open a serial terminal and see the IP address printed out
void handler(const char *topic, const char *data) {
    Serial.println("received " + String(topic) + ": " + String(data));
}

void setup() {
    Serial.begin(115200);
    for(int i=0;i<5;i++) {
        Serial.println("waiting... " + String(5 - i));
        delay(1000);
    }

    Spark.subscribe("spark/", handler);
    Spark.publish("spark/device/ip");
}
```

## Get Device name

This gives you the device name that is stored in the cloud,

```cpp
// Open a serial terminal and see the device name printed out
void handler(const char *topic, const char *data) {
    Serial.println("received " + String(topic) + ": " + String(data));
}

void setup() {
    Serial.begin(115200);
    for(int i=0;i<5;i++) {
        Serial.println("waiting... " + String(5 - i));
        delay(1000);
    }

    Spark.subscribe("spark/", handler);
    Spark.publish("spark/device/name");
}
```

## Get Random seed

Grab 40 bytes of randomness from the cloud and {e}n{c}r{y}p{t} away!

```cpp
void handler(const char *topic, const char *data) {
    Serial.println("received " + String(topic) + ": " + String(data));
}

void setup() {
    Serial.begin(115200);
    for(int i=0;i<5;i++) {
        Serial.println("waiting... " + String(5 - i));
        delay(1000);
    }

    Spark.subscribe("spark/", handler);
    Spark.publish("spark/device/random");
}
```
