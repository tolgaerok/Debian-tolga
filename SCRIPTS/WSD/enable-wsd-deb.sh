#!/bin/bash
# Tolga Erok
# 5/1/2024


# Install wsdd
sudo apt update
sudo apt install wsdd

# Start and enable wsdd service
sudo systemctl start wsdd
sudo systemctl enable wsdd

# Allow UDP port 3702 for wsdd
sudo ufw allow 3702/udp

# Check wsdd service status
sudo systemctl status wsdd
