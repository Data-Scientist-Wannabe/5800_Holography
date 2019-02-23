close all
clc
clear howGoodIsThatLine

% maybe change the exit early if the last two weren't better
% maybe screenlength is wrong

% screenlength=6*1200*3673.6*10^3/2592;
% screenlength=.635*10^7;
screenlength=3.68*10^6;
wavelength=632;
slitwidth=100000;

% near field ~ 1um
% far field ~ 1m
% all distances are in nm

load('redIntensity.mat')
[redMax,redIndex]=max(redIntensity);

% screenIndex=redIndex/1024*screenlength;

n=0;
state=0;
while n<length(redIntensity)
    n=n+1;
    tempRed=redIntensity(n);
    if ((tempRed<redMax*3/5) && (tempRed>redMax*2/5)) && ((state==0) || (state==2))
        if state==0
            upIndex=n;
        elseif state==2
            downIndex=n;
        end 
        state=state+1;
        if state==3
            n=length(redIntensity);
        end
    end
    if tempRed==redMax
        state=2;
    end
end
screenIndex=(downIndex+upIndex)/2/length(redIntensity)*screenlength;
downIndex=1500;

t=1;
while t<=100
    
distance=t*10^4;

counter=0;
% find intensity at every point on the screen
for x=1:screenlength/length(redIntensity):screenlength
    counter=counter+1;
    wave(counter)=0;
    % add contributions from 1000 point sources
    for n=screenIndex-slitwidth/2:slitwidth/1000:screenIndex+slitwidth/2
        r=sqrt(distance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    intensity(counter)=abs(wave(counter))^2;
end

[intensityMax,intensityIndex]=max(intensity);

scalingFactor=redMax/intensityMax;
intensity=intensity*scalingFactor;

% shift=redIndex-intensityIndex;
howGoodIsThatLine(t)=0;
for n=1:1:length(redIntensity)
    howGoodIsThatLine(t)=howGoodIsThatLine(t)+abs(intensity(n)-redIntensity(n));
end

% if (t>2)&&(howGoodIsThatLine(t)>howGoodIsThatLine(t-1))&&(howGoodIsThatLine(t-1)>howGoodIsThatLine(t-2))
%     t=100;
% end
t=t+1;
end

[minHowGoodIsThatLine,tOfBestDistance]=min(howGoodIsThatLine);
bestDistance=tOfBestDistance*10^4
% bestDistance=76500;

counter=0;
% find intensity at every point on the screen
for x=1:screenlength/length(redIntensity):screenlength
    counter=counter+1;
    wave(counter)=0;
    % add contributions from 1000 point sources
    for n=screenIndex-slitwidth/2:slitwidth/1000:screenIndex+slitwidth/2
        r=sqrt(bestDistance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    intensity(counter)=abs(wave(counter))^2;
end

[intensityMax,intensityIndex]=max(intensity);

scalingFactor=redMax/intensityMax;
intensity=intensity*scalingFactor;

figure();
hold on
plot(redIntensity(upIndex-50:downIndex+50),'red')
plot(intensity(upIndex-50:downIndex+50),'black')
xlabel('Screen Position')
ylabel('Intensity')

