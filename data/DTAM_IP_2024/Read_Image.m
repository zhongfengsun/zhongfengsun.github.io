function [Data]=Read_Image(Name)
%Name='ShiGanLi'
Data=imread(strcat(Name,'.png'));
end