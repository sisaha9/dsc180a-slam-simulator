# Base image
FROM osrf/ros:melodic-desktop-full

USER root


# Update apt repo and pip2, and install python3, pip3
RUN apt-get update --fix-missing && \
    apt-get install -y python-pip \
                       python3-dev \
                       python3-pip

# Install apt dependencies, add your apt dependencies to this list
RUN apt-get install -y git \
                       build-essential \
                       cmake \
                       vim \
                       ros-melodic-genpy \
                       ros-melodic-rtabmap \
                       ros-melodic-rtabmap-ros \
                       ros-melodic-gazebo-* \
                       ros-melodic-rviz \
                       dbus

RUN apt install -y libeigen3-dev


RUN dbus-uuidgen > /etc/machine-id

# Upgrade pip
RUN pip3 install --upgrade pip

RUN pip3 install --no-cache-dir numpy==1.16.0 \
                                scipy==1.2.0 \
                                pyyaml \
                                rospkg

# Cloning
RUN mkdir catkin_ws
COPY ./Real-Time-Appearance-Based-Mapping/catkin_ws /catkin_ws

RUN /bin/bash -c "echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc "
RUN /bin/bash -c "echo 'source /catkin_ws/devel/setup.bash' >> ~/.bashrc "
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; cd catkin_ws; catkin_make; source devel/setup.bash; rospack profile"
