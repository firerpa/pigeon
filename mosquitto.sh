#!/bin/sh
cat <<EOL >/etc/mosquitto.conf

user mosquitto

listener 0 /run/mosquitto/server.sock

listener ${MQP_PORT:?MQP_PORT variable is not set}
socket_domain ipv4

cafile /user/root.crt
certfile /user/mosquitto.crt
keyfile /user/mosquitto.key

require_certificate true
allow_anonymous false

persistence false
autosave_interval 0

log_dest stdout

max_queued_messages 1024
max_inflight_messages 512
max_connections -1

auth_plugin /usr/lib/mosquitto-auth-plug.so

auth_opt_backends http

auth_opt_http_getuser_uri /mqtt/auth
auth_opt_http_superuser_uri /mqtt/superuser
auth_opt_http_aclcheck_uri /mqtt/acl

allow_anonymous false

message_size_limit 67108864
connection_messages false
log_timestamp true

#log_type error
#log_type warning
#log_type notice
#log_type information
#log_type debug
#log_type all

auth_opt_http_ip 127.0.0.1
auth_opt_http_port 8123
EOL

exec mosquitto-broker -c /etc/mosquitto.conf
