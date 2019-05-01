function [X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn] = read_input(input_filename,M_id)
    
% This function reads the data from the input file 


missile = importdata(input_filename,'\t',7);

[r,c] = size([missile.data]);
if M_id <= 0 || M_id > r
    X0 = NaN;
    Y0 = NaN;
    Z0 = NaN;
    m0 = NaN;
    mf = NaN;
    Thmag0 = NaN;
    theta = NaN;
    phi = NaN;
    Tburn = NaN;
    disp('Error: Invalid Missile ID');
else
    X0 = missile.data(M_id,2);
    Y0 = missile.data(M_id,3);
    Z0 = missile.data(M_id,4);
    m0 = missile.data(M_id,5);
    mf = missile.data(M_id,6);
    Thmag0 = missile.data(M_id,7);
    theta = missile.data(M_id,8);
    phi = missile.data(M_id,9);
    Tburn = missile.data(M_id,10);
end
end


% Example
% function [X0,Y0,Z0,m0,mf,Thmag0,theta,phi,Tburn] = read_input(missile_data.txt,#)