function [Data]=Read_Image(Name)
%Name='GDP_Original'  
Data=imread(strcat(Name,'.png'));
end