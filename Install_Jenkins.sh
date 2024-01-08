#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

# Enable error handling
set -e

# Informative messages
echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository to sources list..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list..."
sudo apt-get update

# Install Jenkins and required packages
echo "Installing Jenkins and required packages..."
sudo apt-get install jenkins fontconfig default-jre -y

# Display Java version
java -version

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Wait for Jenkins to start
echo "Waiting for Jenkins to start..."
sleep 20

# Check Jenkins service status
sudo systemctl status jenkins

