screenlength=1200*3673.6*10^3/2592;
distance=3.5*10^7;
wavelength=632;
slitwidth=100000;




counter=0;
% find intensity at every point on the screen
for x=0:screenlength/1200:screenlength
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

figure();
hold on
plot(intensityIndex-600:intensityIndex+599,redIntensity(redIndex-600:redIndex+599),'red')
plot(intensityIndex-600:intensityIndex+599,intensity(intensityIndex-600:intensityIndex+599),'black')
xlabel('Screen Position')
ylabel('Intensity')