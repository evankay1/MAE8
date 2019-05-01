clear all;   
close all;   
clc;        
format long; 
name='Evan Kay';
id='A12631982';
hw_num='project';

global g
colors='rbmckgy';

for i=1:7
[X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn] = read_input('missile_data.txt',i); 
[T{i},X{i},Y{i},Z{i},U{i},V{i},W{i}] = missile(X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn);
end

% TASK ONNNEEEE %

% Figure 1 %
load terrain.mat
figure(1);
hold on;
ground = surf(x_terrain/1000,y_terrain/1000,h_terrain./1000);
shading interp;
xlabel('X (km)'); 
ylabel('Y (km)'); 
zlabel('Z (km)');
view(3); 
axis([0 30 0 30 0 3.5]); 
grid on; 
title('Missile Trajectories and Landing Points on Terrain')

for i=1:7
    plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'Color',colors(i),'LineWidth',4);
    plot3(X{i}(end)/1000,Y{i}(end)/1000,Z{i}(end)/1000,'p','Color',colors(i),'Linewidth',15);
    hold on;
end

legend('Terrain','M-1','M-1 Landing','M-2','M-2 Landing','M-3',...
    'M-3 Landing','M-4','M-4 Landing','M-5','M-5 Landing','M-6',...
    'M-6 Landing','M-7','M-7 Landing');
hold off;

% Figure 2 %
figure(2);hold on;
subplot(2,1,1);

for i=1:7
    Ma{i} = sqrt(U{i}.^2+V{i}.^2+W{i}.^2)/340;
end

for i=1:7
    plot(T{i},Ma{i},'Color',colors(i),'LineWidth',3);hold on;
end
title('Evolution of Speed and Acceleration');
xlabel('Time (s)');
ylabel('Mach Number');hold on;


 
subplot(2,1,2);
for i=1:7
    Vmag{i} = sqrt(U{i}.^2+V{i}.^2+W{i}.^2);
    Acc{i} = diff(Vmag{i})./diff(T{i});
    sub{i} = (diff(Vmag{i})./diff(T{i}))/9.81;
end

for i=1:7
    plot(T{i}(1:end-1),sub{i},'Color',colors(i),'LineWidth',3);hold on;
end

grid on;
xlabel('Time(s)');
ylabel('Acceleration / g');
legend('M-1','M-2','M-3','M-4','M-5','M-6','M-7')

% Figure 3 %

figure(3);
hold on;

for i=1:7
    plot(Ma{i},Z{i},'Color',colors(i),'LineWidth',3);hold on; 
end

% Bottom Point %
for i = 1:7
for n=1:length(Ma{i})-1
    if Ma{i}(n+1)>1 && Ma{i}(n-1)<1
       alt = [Z{i}(Ma{i}==Ma{i}(n))];
       mach = [Ma{i}(Ma{i}==Ma{i}(n))];
       plot(mach,alt,'h','Color',colors(i),'Linewidth',5)
    end
end
end
% Top Points %
for i = 1:7
for n=2:length(Ma{i})-1
    if Ma{i}(n+1)<1 && Ma{i}(n-1)>1
       alt = [Z{i}(Ma{i}==Ma{i}(n))];
       mach = [Ma{i}(Ma{i}==Ma{i}(n))];
       plot(mach,alt,'h','Color',colors(i),'Linewidth',5)
    end
end
end
     
grid on;
title('Sonic Barrier');
xlabel('Mach Number');
ylabel('Altitude (km)');hold on;
legend('M-1','M-2','M-3','M-4','M-5','M-6','M-7');

% TASK TWOOOOOOO %

missile_ID = [1 2 3 4 5 6 7];
landing_time = [T{1}(end) T{2}(end) T{3}(end) T{4}(end) T{5}(end) T{6}(end) T{7}(end)];
travel_distance = [sum(sqrt(diff(X{1}).^2+diff(Y{1}).^2+diff(Z{1}).^2)) ...
    sum(sqrt(diff(X{2}).^2+diff(Y{2}).^2+diff(Z{2}).^2)) ...
    sum(sqrt(diff(X{3}).^2+diff(Y{3}).^2+diff(Z{3}).^2)) ...
    sum(sqrt(diff(X{4}).^2+diff(Y{4}).^2+diff(Z{4}).^2)) ...
    sum(sqrt(diff(X{5}).^2+diff(Y{5}).^2+diff(Z{5}).^2)) ...
    sum(sqrt(diff(X{6}).^2+diff(Y{6}).^2+diff(Z{6}).^2)) ...
    sum(sqrt(diff(X{7}).^2+diff(Y{7}).^2+diff(Z{7}).^2))];

[c mxh1] = max(Z{1});
[c mxh2] = max(Z{2});
[c mxh3] = max(Z{3});
[c mxh4] = max(Z{4});
[c mxh5] = max(Z{5});
[c mxh6] = max(Z{6});
[c mxh7] = max(Z{7});

max_height_position = {[X{1}(mxh1) Y{1}(mxh1) Z{1}(mxh1)] ...
    [X{2}(mxh2) Y{2}(mxh2) Z{2}(mxh2)] ...
    [X{3}(mxh3) Y{3}(mxh3) Z{3}(mxh3)] ...
    [X{4}(mxh4) Y{4}(mxh4) Z{4}(mxh4)] ...
    [X{5}(mxh5) Y{5}(mxh5) Z{5}(mxh5)] ...
    [X{6}(mxh6) Y{6}(mxh6) Z{6}(mxh6)] ...
    [X{7}(mxh7) Y{7}(mxh7) Z{7}(mxh7)]};
max_height_Ma = [Ma{1}(mxh1) Ma{2}(mxh2) Ma{3}(mxh3) Ma{4}(mxh4) ...
    Ma{5}(mxh5) Ma{6}(mxh6) Ma{7}(mxh7)];
max_height_Acc = [[Acc{1}(mxh1) Acc{2}(mxh2) Acc{3}(mxh3) ...
    Acc{4}(mxh4) Acc{5}(mxh5) Acc{6}(mxh6) Acc{7}(mxh7)]];
landing_location = {[X{1}(end) Y{1}(end) Z{1}(end)] ...
    [X{2}(end) Y{2}(end) Z{2}(end)] ...
    [X{3}(end) Y{3}(end) Z{3}(end)] ...
    [X{4}(end) Y{4}(end) Z{4}(end)] ...
    [X{5}(end) Y{5}(end) Z{5}(end)] ...
    [X{6}(end) Y{6}(end) Z{6}(end)] ...
    [X{7}(end) Y{7}(end) Z{7}(end)]};
landing_Ma = [Ma{1}(end) Ma{2}(end) Ma{3}(end) Ma{4}(end) Ma{5}(end) Ma{6}(end) Ma{7}(end)];
landing_Acc = [Acc{1}(end) Acc{2}(end) Acc{3}(end) Acc{4}(end) Acc{5}(end) Acc{6}(end) Acc{7}(end)];


for i=1:7
flight_stat(i).missile_ID = missile_ID(i);
flight_stat(i).landing_time = landing_time(i);
flight_stat(i).travel_distance = travel_distance(i);
flight_stat(i).max_height_position = max_height_position{i};
flight_stat(i).max_height_Ma = max_height_Ma(i);
flight_stat(i).max_height_Acc = max_height_Acc(i);
flight_stat(i).landing_location = landing_location(i);
flight_stat(i).landing_Ma = landing_Ma(i);
flight_stat(i).landing_Acc = landing_Acc(i);
end    

% TASK THRREEEEEEE %

fileID = fopen('report.txt','w');

fprintf(fileID,'Evan Kay\n');
fprintf(fileID,'A12631982\n');
fprintf(fileID,'%s,%s,%s,%s,%s\n','M_ID','landing time (s)',...
    'travel distance (m)','landing speed (m/s)',...
    'landing acceleration (m/s^2)');
for i = 1:7
fprintf(fileID,'%.1g,%15.9e,%15.9e,%15.9e,%15.9e\n',...
    i,T{i}(end),flight_stat(i).travel_distance,Vmag{i}(end),Acc{i}(end));
end
fclose(fileID);

% FINISHHHINGGG STUUFFFFF %

p1a = 'See figure 1';
p1b = 'See figure 2';
p1c = 'See figure 3';
p2a = flight_stat(1);
p2b = flight_stat(2);
p2c = flight_stat(3);
p2d = flight_stat(4);
p2e = flight_stat(5);
p2f = flight_stat(6);
p2g = flight_stat(7);
p3 = evalc('type report.txt');