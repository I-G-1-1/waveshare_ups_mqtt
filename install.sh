#Install stuff through apt
echo "Install python3-smbus and python3-pip via apt"
sudo apt install python3-smbus python3-pip

#Install stuff through pip
echo "Install paho-mqtt and pyyaml through pip"
sudo pip3 install paho-mqtt pyyaml

#Copy script to /usr/local/bin
echo "Copy python code into /usr/local/bin/"
sudo cp -v *.py /usr/local/bin/
sudo chmod 774 /usr/local/bin/waveshare_ups.py

sudo mkdir /srv/ups2mqtt
sudo chown pi:pi /srv/ups2mqtt
sudo chmod 774 /srv/ups2mqtt
python3 -m venv /srv/ups2mqtt
#source /srv/ups2mqtt/bin/activate
#pip3 install paho-mqtt pyyaml

#Copy yaml but don't overwrite
CONFIG=waveshare_ups.yaml
echo "Copy config to $CONFIG if it doesn't exist already"
#sudo cp -v -n $CONFIG /etc/$CONFIG
sudo cp -v -n $CONFIG /home/homeassistant/.homeassistant/$CONFIG
sudo chmod 664 /home/homeassistant/.homeassistant/$CONFIG

#Copy systemd script, run daemon-reload
echo "Copy service file"
SERVICE=waveshare_ups.service
sudo cp -v $SERVICE /etc/systemd/system/$SERVICE
sudo chmod 664 /etc/systemd/system/$SERVICE
echo "Reload systemd daemons"
sudo systemctl daemon-reload