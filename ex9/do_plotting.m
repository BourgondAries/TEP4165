clc; clear all; close all;

figure;
width = 0.5;
height = 0.2;
contour(linspace(0,width,50),linspace(0,height,20),transpose(load('b.dat')),'ShowText','on');
xlabel('x');
ylabel('y');
title('Temperature contour (b)');

figure;
width = 0.5;
height = 0.2;
contour(linspace(0,width,50),linspace(0,height,20),transpose(load('e.dat')),'ShowText','on');
xlabel('x');
ylabel('y');
title('Temperature contour (e)');
