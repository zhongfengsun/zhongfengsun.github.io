function [Data]=Read_Image(Name)
%Name='Image1'  or 'Image2' 
Data=imread(strcat(Name,'.png'));
end