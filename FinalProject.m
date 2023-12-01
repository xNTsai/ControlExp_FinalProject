cam = webcam('Logitech');
oriImage = snapshot(cam);
Image = oriImage;
Image = findroute(Image, [350, 10]);
imshow(Image);

rgbImage = Image;
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel

allBlack = zeros(sigze(rgbImage, 1), size(rgbImage, 2), 'uint8');
% Create color versions of the individual color channels.
just_red = cat(3, redChannel-greenChannel, allBlack, allBlack);
just_green = cat(3, allBlack, greenChannel, allBlack);
just_blue = cat(3, allBlack, allBlack, blueChannel);

function I = findroute(image, range)
    % RGB to HSV conversion
    I = rgb2hsv(image);         
    % Normalization range between 0 and 1
    range = range./360;
    % Mask creation
    if(size(range,1) > 1), error('Error. Range matriz has too many rows.'); end
    if(size(range,2) > 2), error('Error. Range matriz has too many columns.'); end
    if(range(1) > range(2))
        % Red hue case
        mask = (I(:,:,1)>range(1) & (I(:,:,1)<=1)) + (I(:,:,1)<range(2) & (I(:,:,1)>=0));
    else
        % Regular case
        mask = (I(:,:,1)>range(1)) & (I(:,:,1)<range(2));
    end
    % Saturation is modified according to the mask
    I(:,:,2) = mask .* I(:,:,2);
    % HSV to RGB conversion
    I = hsv2rgb(I);
end