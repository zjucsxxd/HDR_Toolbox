function stack = ReadLDRStack(dir_name, format, bNormalization)
%
%       stack = ReadLDRStack(dir_name, format, bNormalization)
%
%       This function reads an LDR stack from a directory, dir_name, given
%       an image format.
%
%        Input:
%           -dir_name: the path where the stack is
%           -format: the LDR format of the images that we want to load in
%           the folder dir_name. For example, it can be 'jpg', 'jpeg',
%           'png', 'tiff', 'bmp', etc.
%           -bNormalization: is a flag for normalizing or not the stack in
%           [0, 1].
%
%        Output:
%           -stack: a stack of LDR images, in floating point (single)
%           format. No normalization is applied.
%
%     This function reads a stack of images from the disk
%
%     Copyright (C) 2011-15  Francesco Banterle
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

if(~exist('bNormalization', 'var'))
    bNormalization = 0;
end

list = dir([dir_name,'/*.',format]);
n = length(list);

if(n > 0)
    info = imfinfo([dir_name,'/',list(1).name]);
    
    colorChannels = 0;
    
    norm_value = 255.0;
    
    if(exist('info.NumberOfSamples', 'var'))
        colorChannels = info.NumberOfSamples;
    else
        switch info.ColorType
            case 'grayscale'
                colorChannels = 1;
                
                switch info.BitDepth
                    case 8
                        norm_value = 255.0;
                    case 16
                        norm_value = 65535.0;
                end
                
            case 'truecolor'
                colorChannels = 3;

                switch info.BitDepth
                    case 24
                        norm_value = 255.0;
                    case 48
                        norm_value = 65535.0;
                end
        end
    end  
    
    stack = zeros(info.Height, info.Width, colorChannels, n, 'single');

    for i=1:n
        disp(list(i).name);
        %read an image, and convert it into floating-point
        img = single(imread([dir_name, '/', list(i).name]));  

        %store in the stack
        stack(:,:,:,i) = img;    
    end
    
    if(bNormalization)
        stack = stack / norm_value;
    end
else
    disp('The stack is empty!');
    stack = [];
end

end