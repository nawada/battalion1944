#!/bin/sh

# Worked on ubuntu1804 in Vultr

isAlive=`ps aux | grep BattalionServer | grep -v grep | wc -l`

if [ $isAlive = 1 ]; then
  :
else
  steamcmd +login anonymous +app_updte 805140 +quit
  '/home/steam/.steam/SteamApps/common/Battalion 1944 Dedicated Server/Linux/Run.sh'
fi