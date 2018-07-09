function plotAxes = localDisplayImage( imageStruct , color )
%LOCAL_DISPLAY_IMAGE Displays the full local image in 'imageStruct' with
%color specified by the second parameter value.
%   Images are loaded using the path stored in 'imageStruct' as NxN
%   arrays with each value representing the grayscale intensity of a single
%   pixel.
%
%		In order to display the images in color, they must be converted to RGB
%		images which are stored as NxNx3 arrays with each value now
%		representing the intensity value in one of the three color channels
%		(red, green or blue).
%
%		For this to be possible, an interim step in necessary; that is,
%		converting the intenisty images to indexed images, so they are now
%		composed of an NxN array of values representing the pixel color (i.e.
%		color1 up to colorM), and an Mx3 array giving the RGB values of each
%		color (i.e.
%			[color1-red color1-green color1-blue;
%				color2-red color2-green color2-blue;
%				...
%				colorM-red colorM-green colorM-blue]
%
%		When converting the from indexed images to RGB images, the color maps
%		are created manually to ensure the correct colors are displayed (i.e.
%		red or yellow).


switch color
	case 'red'
		imageGray = imadjust(im2double(imread(imageStruct.redPath)));
		[imageIndexed,map] = gray2ind(imageGray,256);
		redMap = [map(:,1),zeros(256,1),zeros(256,1)]; % [R G B] channels
		imageRGB = ind2rgb(imageIndexed,redMap);
	case 'yel'
		imageGray = imadjust(im2double(imread(imageStruct.yelPath)));
		[imageIndexed,map] = gray2ind(imageGray,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)]; % [R G B] channels
		imageRGB = ind2rgb(imageIndexed,yelMap);
	case 'blend'
		yel = imadjust(im2double(imread(imageStruct.yelPath)));
		red = imadjust(im2double(imread(imageStruct.redPath)));
		[yelIndexed,map] = gray2ind(yel,256);
		yelMap = [map(:,1),map(:,1),zeros(256,1)];
		yelRGB = ind2rgb(yelIndexed,yelMap);
		[redIndexed,map] = gray2ind(red,256);
		redMap = [map(:,1),zeros(256,1),zeros(256,1)];
		redRGB = ind2rgb(redIndexed,redMap);
		imageRGB = imfuse(yelRGB,redRGB,'blend');
	case 'combine'
		% does not work on Windows machines
		yel = imadjust(im2double(imread(imageStruct.yelPath)));
		red = imadjust(im2double(imread(imageStruct.redPath)));
		imageRGB = zeros(2160,2160,3);
		imageRGB(:,:,1) = red + yel; % red channel
		imageRGB(:,:,2) = yel; % green channel
		% blue channel left as zero
	otherwise
		disp('Please enter "red", "yel", "blend" or "combine" as the second argument of imgDisplay.')
end

imageHandle = imshow(imageRGB,[],'InitialMagnification',50);
plotAxes = imageHandle.Parent;
hold on

end

