clear;

image = imread('peppers.png');

[imgHeight, imgWidth, ~] = size(image);

if ((mod(imgHeight, 8) > 0) || mod(imgWidth, 8) > 0)
    image = resizeImageTo8(image);
end

q = 80;

[bitStr, imgDimensions] = jpegEncoder(image, q);

decodedImage = jpegDecoder(bitStr, imgDimensions, q);

bpp = jpegCodedImageSize(bitStr, imgDimensions);
ssim = ssim(image, decodedImage);

disp(bpp);
disp(ssim);

subplot(1, 2, 1);
imshow(image);
title('Original Image');

subplot(1, 2, 2);
imshow(decodedImage);
title('Decoded Image');