function hsi=rgb2hsi(rgb)
%RGB2HSI Converts an RGB image to HSI
%   HSI=RGB2HSI(rgb) converts an RGB image to HSI. The input image is
%   assumed to be of size M-by-N-by-3, where the third dimension accounts
%   for three image planes:red, green, and blue, in that order. If all RGB
%   component images are equal, the HSI conversion is undefined. Ths input
%   image can be of class double (with values in the rang[0,1]), uint8, or
%   uint16.
%   The output image, HSI, is of class double, where:
%       hsi(:,:,1)= hue image normalized values to the range [0,1] by
%                   dividing all angle values by 2*pi.
%       hsi(:,:,2)=saturation image, in the range [0,1].
%       hsi(:,:,3)=intensity image, in the range [0,1].
%Extract the individual component images.
rgb=im2double(rgb);
r=rgb(:,:,1);
g=rgb(:,:,2);
b=rgb(:,:,3);
%Implement the conversion equations.
num=0.5*((r-g)+(r-b));
den=sqrt((r-g).^2+(r-b).*(g-b));
theta=acos(num./(den+eps));
H=theta;
H(b>g)=2*pi-H(b>g);
H=H/(2*pi); %��һ��
num=min(min(r,g),b);
den=r+g+b;
den(den==0)=eps;
S=1-3.*num./den;
H(S==0)=0;
I=(r+g+b)/3;
%Combine all three results into an hsi image.
hsi=cat(3,H,S,I);
end