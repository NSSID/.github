name: jadi gnii gitu

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Create User and Add to sudo Group
      run: |
        sudo adduser npc
        sudo usermod -aG sudo npc
        sudo chpasswd <<<"npc:npc"

    - name: Install SSH Server
      run: |
        sudo apt update
        sudo apt install openssh-server -y
        sudo service ssh restart

    - name: Install Ngrok
      run: |
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
        unzip ngrok-stable-linux-amd64.zip

    - name: Authenticate Ngrok
      run: ./ngrok authtoken ${{ secrets.NGROK_AUTH_TOKEN }}

    - name: Create Ngrok Tunnel
      run: ./ngrok tcp 22
