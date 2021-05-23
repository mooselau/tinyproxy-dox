#!/bin/bash

# Setting up variables if it is not set 
: ${PORT}:="8888"}
: ${TRUESTED_IP:="127.0.0.1"}
: ${USERNAME:="your_username"}
: ${PASSWORD:="your_password"}

# check if tinyproxy is on
if [[ $(pgrep tinyproxy) ]]
then 
  echo "TinyProxy is already running.."
else 
  # backup config file
  cp ./tinyproxy.conf ./tinyproxy.conf.bak
  
  # modify tinyproxy.conf
  echo "Configuring TinyProxy.."
  
  # modify User & Group to root by default
  sed -i 's|User.*|User root|' tinyproxy.conf
  sed -i 's|Group.*|Group root|' tinyproxy.conf

  # modify Port
  sed -i "s|Port.*|Port $PORT|" tinyproxy.conf

  # modify Output Files
  sed -i 's|#LogFile.*|LogFile "/etc/tinyproxy/tinyproxy.log"|' tinyproxy.conf
  sed -i 's|#PidFile.*|PidFile "/etc/tinyproxy/tinyproxy.pid"|' tinyproxy.conf

  # modify to add trusted IP
  sed -i  "/Allow ::1/ a Allow $TRUESTED_IP" tinyproxy.conf

  # modify BasicAuth
  sed -i "s|#BasicAuth.*|BasicAuth $USERNAME $PASSWORD|" tinyproxy.conf

  echo "Start TinyProxy.."
  tinyproxy -c ./tinyproxy.conf
fi

# tail log
tail -f /etc/tinyproxy/tinyproxy.log
