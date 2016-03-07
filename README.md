MQTT Forwarder influxdb
=======================

Forward your all mqtt messages to influxdb

How to build it
---------------

* Change variables inside Dockerfile.
* Build image
```
docker build -t mqtt_fwd .
```
* Run image:
```
docker run -it mqtt_fwd
```


