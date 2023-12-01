cam = webcam('Logitech');
oriImage = snapshot(cam);
Image = oriImage;
RouteImage = findroute(Image, [350, 10]);    % range for red hue
% imshow(RouteImage*100);
Route = RouteImage(:, :, 1);

% TODO:
% drone = [x, y, height, width]     % (0,0) at left-upper side

matchCount_up = matchCount(Route, x, y, height, width, 0);
matchCount_down = matchCount(Route, x, y+height, height, width, 0);
matchCount_left = matchCount(Route, x, y, height, width, 1);
matchCount_right = matchCount(Route, x+width, y, height, width, 1);


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

    redChannel = I(:,:,1); % Red channel
    grayChannel = I(:,:,2); % Green channel
    allBlack = zeros(size(I, 1), size(I, 2), 'uint8');
    I = cat(3, redChannel-grayChannel, allBlack, allBlack);
end

function count = matchCount(Route, x, y, height, width, direction)     % 0 for up/down ; 1 for left/right
   count = 0;
    if(direction == 0) 
        for i = 0:width-1
            if(Route(y, xIi)>0) 
                count = count + 1; 
            end
        end
    elseif(direction == 1)
        for i = 0:height-1
            if(Route(y+i, x)>0)
                count = Route(y+i, x) + count;
            end
        end
    end
end

