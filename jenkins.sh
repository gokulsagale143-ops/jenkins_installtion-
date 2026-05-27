#!/bin/bash

# Exit immediately if a command fails
set -e

echo "Updating system packages..."
sudo apt update

echo "Installing Java..."
sudo apt install -y fontconfig openjdk-21-jre

echo "Checking Java version..."
java -version

echo "Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

echo "Adding Jenkins repository key..."
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list..."
sudo apt update

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Enabling Jenkins service..."
sudo systemctl enable jenkins

echo "Starting Jenkins service..."
sudo systemctl start jenkins

echo "Checking Jenkins status..."
sudo systemctl status jenkins --no-pager

echo "Jenkins installation completed successfully!"
