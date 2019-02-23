%% Acquire Images Via Webcam 
%
% Author: Chris Esparza
% Last Revised: 04-09-2018
%

%%
% This program is an easy way to take a single photo, or a series of
% photos, using MatLab's Image Acquisition Toolbox.
%
% The following comments are a summary of steps to initialize a webcam, and
% then taking images. All information can be found on the MathWorks support
% page:
% 
%  https://www.mathworks.com/help/supportpkg/usbwebcams/ug/acquire-images-from-webcams.html
%  

%%
% Assign the webcam you plan to use using the following command:
%
%                       cam = webcam(#);
%
% where # is replaced with corresponding camera index in the list
% of available webcams. (To see this list, type "webcamlist")


% To preview the image from the camera, enter the following:
% 
%                         preview(cam);
%


% Set the pixel resolution of the camera by entering the following command:
%
%                    cam.Resolution = 'N1xN2'
%
% where N1 and N2 are replaced by values of available resolutions. (To see
% the list of resolutions, type "cam.AvailableResolutions" after assigning
% the webcam.
%

% To display the acquired image, enter:
% 
%                         imshow(img)
%

%% Initialize Camera
clear;
close all;
clc;

% Settings for our 'HD USB Camera'
webcams = webcamlist;
for n=1:1:length(webcamlist)
    if strcmp(webcams(n),'HD USB Camera')
        cam = webcam(n);
        cam.Resolution = '2592x1944';
    end
end

pause(4)

imageBackground=double(snapshot(cam));
for n=1:1:9
    newImage=double(snapshot(cam));
    imageBackground=imageBackground+newImage;
end
imageBackground=imageBackground/10;

uint8ImageBackground=uint8(imageBackground);
imshow(uint8ImageBackground);
% improfile

for n=1:1:2592
    redIntensity(n)=mean(imageBackground(:,n,1));
    greenIntensity(n)=mean(imageBackground(:,n,2));
    blueIntensity(n)=mean(imageBackground(:,n,3));
end
figure();
hold on
plot(redIntensity,'red')
plot(greenIntensity,'green')
plot(blueIntensity,'blue')

%% Taking Images 
% for i = 1:3
%     
%     % assigns a snapshot image to variable
%     img = snapshot(cam);
%     
%     % creates name for image (in this case a bitmap)
%     fname = ['singleslit0mm_BRIGHTER',num2str(i),'.bmp'];
%     
%     % writes image to file
%     imwrite(img,fname);
%     
%     % pause to watch progress
%     pause(2);
%     
% end


%% Talbot Image Capture

% clc
% 
% j = 1.51; % [mm] away from camera
% 
% while true
%     
%   n = input('1 to snap a pic, 0 to exit: ');
%   
%   if n == 1
%     % assigns a snapshot image to variable
%     img = snapshot(cam);
%     
%     % creates name for image (in this case a bitmap)
%     fname = ['Talbot_image_',num2str(j),'mm.bmp'];
%     
%     % writes image to file
%     imwrite(img,fname);
%     
%    
%     fprintf('%f mm away from camera.\n\n',j);
%     j = j + 0.01; %[mm] increments 
%         
%     clear n;
% 
%     elseif n == 0
%         
%         fprintf('\n');
%         break;
%         
%   end
% 
% end

% 4-9-18 --> left off @ 1.5 mm away from slit

% 4-11-2018 --> finished 3mm away from slit (Talbot length = 2.08 mm)

