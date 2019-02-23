%% Acquire Images with the raspberry pi cam
% Author: Quentin Anthony
% Checklist:
%   0. Have the Raspberry Pi support package (with Matlab > 2017a)
%   1. Connect Pi camera to board, and connect the Pi to PC via ethernet
%   2. Make sure that an SD card formatted with the Matlab support package
%   is on the Pi

%% Initialize Camera
clear;
close all;
clc;

rpi = raspi(); % Initialize the pi
cam = cameraboard(rpi,'Resolution','1920x1080'); % Initialize the cam
% Take background images
imageBackground=double(snapshot(cam));
for n=1:1:9
    newImage=double(snapshot(cam));
    imageBackground=imageBackground+newImage;
end
imageBackground=imageBackground/10;
uint8ImageBackground=uint8(imageBackground);
image(uint8ImageBackground);

for n=1:1:1920
    redIntensity(n)=mean(imageBackground(:,n,1));
    greenIntensity(n)=mean(imageBackground(:,n,2));
    blueIntensity(n)=mean(imageBackground(:,n,3));
end
figure();
hold on
plot(redIntensity,'red')
plot(greenIntensity,'green')
plot(blueIntensity,'blue')

%% Take live video
while(true)
    pause(.5);
    img = snapshot(cam);
    imshow(img)
end
%% Setup
clear all
rpi = raspi();
cam = cameraboard(rpi,'Resolution','1920x1080');