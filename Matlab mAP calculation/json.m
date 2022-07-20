clc; clear all; close all;
fileName = 'sample_annotation.json';
fid = fopen(fileName);
raw = fread(fid,inf);
str = char(raw');
fclose(fid);
data = jsondecode(str);
fileName1 = 'image_annotations.json';
fid1 = fopen(fileName1);
raw1 = fread(fid1,inf);
str1 = char(raw1');
fclose(fid1);
data1=jsondecode(str1);

