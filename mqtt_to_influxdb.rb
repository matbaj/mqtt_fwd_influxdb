require 'influxdb'
require 'mqtt'
require 'uri'

database = ENV['INFLUXDB_DATABASE']
uri =  URI.parse ENV['INFLUXDB_URL']
time_precision = 's'

influxdb = InfluxDB::Client.new database,
                                username: uri.user,
                                password: uri.password,
                                host: uri.host,
                                port: uri.port

uri = URI.parse ENV['MQTT_URL']
conn_opts = {
  remote_host: uri.host,
  remote_port: uri.port,
  username: uri.user,
  password: uri.password,
}
mqtt_topic = ENV['MQTT_TOPIC'] || 'influxdb/#'

MQTT::Client.connect(conn_opts) do |c|
  puts "MQTT CONNECTED"
  c.get(mqtt_topic) do |topic, message|
    puts "#{Time.now} #{topic}: #{message}"
    node_name = topic.split("/").drop(1).join("_")
    data = { values: { value: message}}
    puts data
    influxdb.write_point(node_name, data, time_precision)
  end
end
