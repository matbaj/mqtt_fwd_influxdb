FROM ruby:2.2-alpine
MAINTAINER Mateusz Bajorski (github: matbaj)
RUN gem install --no-ri --no-rdoc mqtt influxdb
COPY mqtt_to_influxdb.rb /mqtt_to_influxdb.rb
ENV MQTT_URL 'mqtt://user:password@host:1883'
ENV INFLUXDB_DATABASE grafana
ENV INFLUXDB_URL http://grafana:grafana@host:8086

CMD ruby mqtt_to_influxdb.rb

