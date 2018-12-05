close all
clear
clc

screenlength=3.68*10^6;
distance=5.5*10^5;
wavelength=632;
slitwidth=100000;

wave=zeros(1,1000);
intensity=zeros(1,1000);
counter=0;
% find intensity at every point on the screen
for x=1:screenlength/1000:screenlength
    counter=counter+1;
    % add contributions from 1000 point sources
    for n=screenlength/2-slitwidth/2:slitwidth/1000:screenlength/2+slitwidth/2
        r=sqrt(distance^2+(x-n)^2);
        wave(counter)=wave(counter)+exp(1i*2*pi/wavelength*r)/r;
    end
    intensity(counter)=abs(wave(counter))^2;
end

max=max(intensity);
min=min(intensity);
for n=1:1:length(intensity)
    intensity(n)=(intensity(n)-min)/(max-min);
end

n=0;
while n<length(intensity)
    n=n+1;
    if intensity(n)>.001
        if n>5
            start=n-5;
        else
            start=0;
        end
        n=length(intensity);
    end
end

n=length(intensity);
while n>0
    n=n-1;
    if intensity(n)>.001
        if n<=length(intensity)-5
            stop=n+5;
        else
            stop=length(intensity);
        end
        n=0;
    end
end

figure();
plot(intensity(start:stop),'black')
xlabel('Screen Position')
ylabel('Normalized Intensity')