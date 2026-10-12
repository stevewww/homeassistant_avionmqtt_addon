#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json
SETTINGS_YAML=settings.yaml

echo "Loading options from ${CONFIG_PATH}..."

# Extract options using jq
AVION_EMAIL=$(jq --raw-output '.avion_email' $CONFIG_PATH)
AVION_PASSWORD=$(jq --raw-output '.avion_password' $CONFIG_PATH)
MQTT_HOST=$(jq --raw-output '.mqtt_host' $CONFIG_PATH)
MQTT_USERNAME=$(jq --raw-output '.mqtt_username' $CONFIG_PATH)
MQTT_PASSWORD=$(jq --raw-output '.mqtt_password' $CONFIG_PATH)

echo "Generating settings.yaml..."

cat <<EOF > ${SETTINGS_YAML}
avion:
  email: "${AVION_EMAIL}"
  password: "${AVION_PASSWORD}"
mqtt:
  host: "${MQTT_HOST}"
  username: "${MQTT_USERNAME}"
  password: "${MQTT_PASSWORD}"
EOF

echo "Starting avionmqtt..."
exec avionmqtt -s ${SETTINGS_YAML} --log=INFO
