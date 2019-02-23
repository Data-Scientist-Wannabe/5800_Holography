% Simulate the double slit
% by Quentin Anthony

clear
close all
clc
    
% near field ~ 1um
% far field ~ 1m
% all distances are in nm

screenlength=1200*3673.6*10^3/2592;
distance=.2*10^7;
wavelength=632;
slitwidth=10^5;
double_slit_separation=2*10^5;

counter=0;
% find intensity at every point on the screen
for x=0:screenlength/1200:screenlength
    counter=counter+1;
    wave(counter)=0;
    % add contributions from 1000 point sources
    for n=screenlength/2-slitwidth/2-double_slit_separation:slitwidth/1000:screenlength/2+slitwidth/2-double_slit_separation
        r=sqrt(distance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    for n=screenlength/2-slitwidth/2+double_slit_separation:slitwidth/1000:screenlength/2+slitwidth/2+double_slit_separation
        r=sqrt(distance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    intensity(counter)=abs(wave(counter))^2;
end

figure();
hold on
plot(intensity,'black')
xlabel('Screen Position')
ylabel('Intensity')
xlim([200 1000])
