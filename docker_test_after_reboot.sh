#!/bin/bash
echo "=== Post-Installation Docker Test Script ==="
echo "Please run this script after re-login"

# Test Docker installation
echo "1. Checking Docker version:"
docker --version

echo -e "\n2. Running test container:"
docker run hello-world
echo -e "\n3. Viewing Docker system info:"
docker info

echo -e "\n4. Pulling and running Nginx container:"
docker run -d -p 8080:80 --name my-nginx nginx
echo "Nginx container started, access at: http://localhost:8080"

echo -e "\n5. Viewing running containers:"
docker ps
