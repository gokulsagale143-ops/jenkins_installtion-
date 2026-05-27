#!/bin/bash

# Exit script if any command fails
set -e

echo "==============================="
echo " Updating Ubuntu Packages"
echo "==============================="
sudo apt update -y

echo "==============================="
echo " Installing Required Packages"
echo "==============================="
sudo apt install -y fontconfig openjdk-21-jre curl wget gnupg

echo "==============================="
echo " Checking Java Version"
echo "==============================="
java -version

echo "==============================="
echo " Creating Jenkins Keyring Directory"
echo "==============================="
sudo mkdir -p /etc/apt/keyrings

echo "==============================="
echo " Removing Old Jenkins Key (if exists)"
echo "==============================="
sudo rm -f /etc/apt/keyrings/jenkins-keyring.asc

echo "==============================="
echo " Downloading Correct Jenkins GPG Key"
echo "==============================="
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

echo "==============================="
echo " Adding Jenkins Repository"
echo "==============================="
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "==============================="
echo " Updating Package Repository"
echo "==============================="
sudo apt update -y

echo "==============================="
echo " Installing Jenkins"
echo "==============================="
sudo apt install -y jenkins

echo "==============================="
echo " Enabling Jenkins Service"
echo "==============================="
sudo systemctl enable jenkins

echo "==============================="
echo " Starting Jenkins Service"
echo "==============================="
sudo systemctl start jenkins

echo "==============================="
echo " Jenkins Service Status"
echo "==============================="
sudo systemctl status jenkins --no-pager

echo "==============================="
echo " Jenkins Initial Admin Password"
echo "==============================="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "==============================="
echo " Jenkins Installed Successfully!"
echo " Open Browser:"
echo " http://localhost:8080"
echo "==============================="
