close all;
clc;

image=double(snapshot(cam));
for n=1:1:9
    newImage=double(snapshot(cam));
    image=image+newImage;
end
% image=image/10-imageBackground;
image=image/10;

uint8Image=uint8(image);
imshow(uint8Image);

for n=1:1:2592
    redIntensity(n)=mean(image(:,n,1));
    greenIntensity(n)=mean(image(:,n,2));
    blueIntensity(n)=mean(image(:,n,3));
end

% greenScale=mean(redIntensity)/mean(greenIntensity);
% blueScale=mean(redIntensity)/mean(blueIntensity);
% % greenScale=max(redIntensity)/max(greenIntensity);
% % blueScale=max(redIntensity)/max(blueIntensity);
% greenIntensity=greenIntensity*greenScale;
% blueIntensity=blueIntensity*blueScale;

figure();
hold on
redIntensity=redIntensity-redIntensity(1);
plot(redIntensity,'red')
plot(greenIntensity,'green')
plot(blueIntensity,'blue')
% 
intensity=redIntensity+greenIntensity+blueIntensity;
% figure();
plot(intensity,'black')

save('redIntensity','redIntensity')
