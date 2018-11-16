

t=1;
while t<=100
    
% near field ~ 1um
% far field ~ 1m
% all distances are in nm

load('redIntensity.mat')
[redMax,redIndex]=max(redIntensity);

% screenlength=1200*3673.6*10^3/2592;
screenlength=3.68*10^6;
distance=t*10^6+10^7;
wavelength=632;
slitwidth=100000;

counter=0;
% find intensity at every point on the screen
for x=0:screenlength/1920:screenlength
    counter=counter+1;
    wave(counter)=0;
    % add contributions from 1000 point sources
    for n=screenlength/2-slitwidth/2:slitwidth/1000:screenlength/2+slitwidth/2
        r=sqrt(distance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    intensity(counter)=abs(wave(counter))^2;
end

[intensityMax,intensityIndex]=max(intensity);

scalingFactor=redMax/intensityMax;
intensity=intensity*scalingFactor;

shift=redIndex-intensityIndex;
howGoodIsThatLine(t)=0;
for n=intensityIndex-600:1:intensityIndex+599
    howGoodIsThatLine(t)=howGoodIsThatLine(t)+abs(intensity(n)-redIntensity(n+shift));
end
howGoodIsThatLine(t)=howGoodIsThatLine(t)/1200;

if (t>2)&&(howGoodIsThatLine(t)>howGoodIsThatLine(t-1))&&(howGoodIsThatLine(t-1)>howGoodIsThatLine(t-2))
    t=100;
end
t=t+1;
end

[minHowGoodIsThatLine,tOfBestDistance]=min(howGoodIsThatLine);
bestDistance=10^7+tOfBestDistance*10^6

counter=0;
% find intensity at every point on the screen
for x=0:screenlength/1920:screenlength
    counter=counter+1;
    wave(counter)=0;
    % add contributions from 1000 point sources
    for n=screenlength/2-slitwidth/2:slitwidth/1000:screenlength/2+slitwidth/2
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
plot(intensityIndex-600:intensityIndex+599,redIntensity(redIndex-600:redIndex+599),'red')
plot(intensityIndex-600:intensityIndex+599,intensity(intensityIndex-600:intensityIndex+599),'black')
xlabel('Screen Position')
ylabel('Intensity')