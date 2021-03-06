# dsc180a-slam-simulator

Track taken from Georgia Tech AutoRally project: https://github.com/AutoRally

Robot taken from Andres Garcia: https://github.com/AndresGarciaEscalante/Real-Time-Appearance-Based-Mapping

Robot modified to use Intel D455 parameters in RGBD camera. mapping.launch file modified to load configurations from .yaml and localization mode added for benchmarking purposes. Added a ground truth for benchmarking purposes as well

Can be paired with https://github.com/sisaha9/slamevaluations to run benchmarks on generated data


# Run instructions

1. Run uncluttered_world_proper tag from dockerhub: https://hub.docker.com/repository/docker/sisaha9/180asims/general
2. Everything has been sourced already. Open 4 more terminals and connect them to the same container instance with docker exec
3. Run roslaunch autorally_gazebo autoRallyTrackWorldMine.launch in the main terminal
4. To open teleop type rosrun teleop_twist_keyboard teleop_twist_keyboard.py in terminal 2
5. To start RTABMAP mapping type roslaunch autorally_gazebo mapping.launch localization:=false in terminal 3
6. To generate ground truth data first run rosrun rtabmap_ros odom_msg_to_tf odom:=ground_truth/state \_frame_id:=robot_footprint_gt in terminal 4
7. In terminal 5 run rosrun tf static_transform_publisher 0 0 0 0 0 0 world map 100
8. Move around the track till you feel you have gained sufficient map data
9. Save your rtabmap.db file and kill all the processes
10. Follow steps 3-7 again except when loading the mapping.launch you will set localization:=true. Move around the terminal till you feel like the robot has localized
11. Run rtabmap-report --poses /root/.ros/rtabmap.db. This will generate 3 text files in the .ros folder. Copy them out of the container and use the slamevaluations tool linked above to generate metrics and plots on it
12. To hyperparameter tune edit the .yaml file in catkin_ws/src/autorally_gazebo/params/param1.yaml. Redo all the steps above to generate the data. Soon a library to process all this information will be released so that you can efficiently hyperparameter tune these


# Not using Docker (untested)
1. Install ros-melodic-desktop-full
2. Install other dependencies from the Dockerfile
3. source /opt/ros/melodic/setup.bash
4. Run catkin_make in the catkin_ws folder
5. source the devel/setup.bash in catkin_ws (or run setup.sh)
6. Open 4 more terminals and source the melodic and devel again (or run setup.sh)
7. Follow steps 3-12 above
