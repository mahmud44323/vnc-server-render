# Use an Ubuntu base image
FROM ubuntu:20.04

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies xorg dbus-x11 x11-xserver-utils \
    novnc websockify supervisor \
    xfce4-terminal tightvncserver && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the environment variable for the VNC password
ENV VNC_PASSWORD=password

# Configure VNC server and NoVNC
COPY .vnc /root/.vnc
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the ports for VNC and NoVNC
EXPOSE 5900 6080

# Start the services
CMD ["/usr/bin/supervisord"]
