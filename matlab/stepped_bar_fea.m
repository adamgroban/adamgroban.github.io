clc
clear

% material properties
E = 200e9;

%% geometry
Le = 0.25;
A1 = 120e-6;
A2 = 100e-6;
A3 = 80e-6;

nElem = 3;
nNode = nElem + 1;

% stiffness matrix
k1 = A1*E/Le;
k2 = A2*E/Le;
k3 = A3*E/Le;
ke1 = k1 * [ 1 -1 ; -1  1 ];
ke2 = k2 * [ 1 -1 ; -1  1 ];
ke3 = k3 * [ 1 -1 ; -1  1 ];

%% assemble global stiffness matrix
K = zeros(nNode);
K(1:2,1:2) = K(1:2,1:2) + ke1;
K(2:3,2:3) = K(2:3,2:3) + ke2;
K(3:4,3:4) = K(3:4,3:4) + ke3;

%% applied forces
F = zeros(nNode,1);
F(3) = 500;
F(4) = 1000;

%% apply boundary condition (node 1 fixed) -> reduced system
freeDofs = 2:nNode;
Kr = K(freeDofs,freeDofs);
Fr = F(freeDofs);

%% solve via LU decomposition
[L,U,P] = lu(Kr);
y  = L \ (P*Fr);
ur = U \ y;

%% assemble full displacement vector
u = zeros(nNode,1);
u(1) = 0;
u(freeDofs) = ur;

u2 = u(2);
u3 = u(3);
u4 = u(4);

fprintf('u2 = %.6e m  (%.6f mm)\n', u2, u2*1000);
fprintf('u3 = %.6e m  (%.6f mm)\n', u3, u3*1000);
fprintf('u4 = %.6e m  (%.6f mm)\n', u4, u4*1000);
