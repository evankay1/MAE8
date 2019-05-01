function [T, X, Y, Z, U, V, W] = missile(X0, Y0, Z0, m0, mf, Thmag0, theta, phi, Tburn)
% This file solves for the position and velocities of the missiles from
% when they are launched until they impact with the terrain.

load terrain.mat
r = 0.2;
A = pi*r^2;
rho = 1.2;
g = 9.81;
dt = 0.005;

% Initialize
U(1)=0;
V(1)=0;
W(1)=0;
T(1)=0;
X(1)=X0;
Y(1)=Y0;
Z(1)=Z0;
m(1)=m0;
n=1;

% Euler Cromer

while Z(n)>=interp2(x_terrain,y_terrain,h_terrain,X(end),Y(end)) || (n==1)

    T(n+1)=T(n)+dt;
    [Th_x, Th_y, Th_z] = thrust(T(n), Thmag0, theta, phi, Tburn, U(n), V(n), W(n));
    [m] = mass(T(n), m0, mf, Tburn);
    Vmag=sqrt(U(n)^2+V(n)^2+W(n)^2);
    [Cd] = drag_coeff(Vmag);
    
    %Euler-Cromer Method
    U(n+1)=U(n)+(Th_x/m-(Cd*rho*A*U(n)*Vmag)/(2*m))*dt;
    V(n+1)=V(n)+(Th_y/m-(Cd*rho*A*V(n)*Vmag)/(2*m))*dt;
    W(n+1)=W(n)+(Th_z/m-(Cd*rho*A*W(n)*Vmag)/(2*m)-g)*dt;
    
    X(n+1)=X(n)+U(n+1)*dt;
    Y(n+1)=Y(n)+V(n+1)*dt;
    Z(n+1)=Z(n)+W(n+1)*dt;
    n=n+1;
end

end

   