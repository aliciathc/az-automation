#! /bin/bash

set -e

echo "Installing nodejs-legacy.."
sudo apt-get install nodejs-legacy -y
sleep 3
echo "Done"

echo "Installing npm..."
sudo apt-get install npm -y
sleep 3
echo "Done"

echo "Installing curl..."
sudo apt-get install curl -y
sleep 3
echo "Done"

echo"Downloading from https://deb.nodesource.com/setup.."
curl -sL https://deb.nodesource.com/setup | sudo bash -
sleep 3
echo "Done"

echo "Installing nodejs.."
sudo apt-get install -y nodejs
sleep 3
echo "Done"

echo "Installing azure-cli..."
sudo npm install -g azure-cli 
sleep 3

echo "All Installation packages has been completed!"



