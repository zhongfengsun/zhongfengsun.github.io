function [Data]=Read_Image(Name)
%Name='ShiGanLi'
Data=imread(strcat(Name,'.jpg'));
end