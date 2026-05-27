#!/bin/bash

set -e

echo "=================================="
echo " Removing Old Jenkins Repository"
echo "=================================="

sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /etc/apt/keyrings/jenkins-keyring.asc
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc

echo "=================================="
echo " Cleaning Old APT Cache"
echo "=================================="

sudo apt clean
sudo rm -rf /var/lib/apt/lists/*
sudo apt update

echo "=================================="
echo " Installing Required Packages"
echo "=================================="

sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring fontconfig openjdk-21-jre

echo "=================================="
echo " Creating Keyrings Directory"
echo "=================================="

sudo mkdir -p /etc/apt/keyrings

echo "=================================="
echo " Downloading NEW Jenkins GPG Key"
echo "=================================="

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | \
gpg --dearmor | \
sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

echo "=================================="
echo " Adding Jenkins Repository"
echo "=================================="

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "=================================="
echo " Updating Package List"
echo "=================================="

sudo apt update

echo "=================================="
echo " Installing Jenkins"
echo "=================================="

sudo apt install -y jenkins

echo "=================================="
echo " Starting Jenkins"
echo "=================================="

sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "=================================="
echo " Jenkins Status"
echo "=================================="

sudo systemctl status jenkins --no-pager

echo "=================================="
echo " Jenkins Initial Password"
echo "=================================="

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "=================================="
echo " Jenkins Installed Successfully"
echo " Open Browser:"
echo " http://localhost:8080"
echo "=================================="
