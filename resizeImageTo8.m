function imgResized = resizeImageTo8(img)
imgHeight = size(img, 1);
imgWidth = size(img, 2);
imgResized = imresize(img, [8*ceil(imgHeight/8) 8*ceil(imgWidth/8)]);
end