#! /bin/bash

set -e

echo "##############################################"
echo "Update packages..."
echo "##############################################"
sudo apt-get update
sleep 3

echo "##############################################"
echo "Installing nodejs-legacy.."
echo "##############################################"
sudo apt-get install nodejs-legacy -y
sleep 3
echo "Done"

echo "##############################################"
echo "Installing npm..."
echo "##############################################"
sudo apt-get install npm -y
sleep 3
echo "Done"

echo "##############################################"
echo "Installing curl..."
echo "##############################################"
sudo apt-get install curl -y
sleep 3
echo "Done"

echo "##############################################"
echo "Downloading from https://deb.nodesource.com/setup.."
echo "##############################################"
curl -sL https://deb.nodesource.com/setup | sudo bash -
sleep 3
echo "Done"

echo "##############################################"
echo "Installing nodejs.."
echo "##############################################"
sudo apt-get install -y nodejs
sleep 3
echo "Done"

echo "##############################################"
echo "Installing azure-cli..."
echo "##############################################"
sudo npm install -g azure-cli 
sleep 3

echo "##############################################"
echo "All Installation packages has been completed!"
echo "##############################################"


