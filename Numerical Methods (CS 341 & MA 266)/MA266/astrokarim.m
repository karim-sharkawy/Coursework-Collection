clc;clear;close all;

time = [0 20]; %time interval
initialU = [0;1]; % initial conditions


[t,x] = ode45(@(t,x) ode(t,x),time,initialU); % ODE CALL



plot(t,x(:,1)) % plots t vs u
xlabel("Time (s)")
ylabel("Distance (m)")
title("Time vs Distance")
grid on