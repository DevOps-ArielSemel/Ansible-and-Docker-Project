#!/bin/bash

echo "Setting up SSH keys..."

# Check if ~/.comA_key already exists before copying
if [ -f ~/.comA_key ]; then
    echo "~/.comA_key already exists, skipping copy..."
else
    echo "copy for secure location..."	
    cp /vagrant/.vagrant/machines/comA/virtualbox/private_key ~/.comA_key
    echo "setting up permissions..."
    chmod 600 ~/.comA_key
    
fi

# Check if ~/.comB_key already exists before copying
if [ -f ~/.comB_key ]; then
    echo "~/.comB_key already exists, skipping copy..."
else
    echo "copy for secure location..."
    cp /vagrant/.vagrant/machines/comB/virtualbox/private_key ~/.comB_key
    echo "setting up permissions..."
    chmod 600 ~/.comB_key
    
fi

echo "Setup completed!"


