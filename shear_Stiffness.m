% --------------------------------------------------------------------
% E: youngs modulus; I: moment of inertial; L: length of each story
% --------------------------------------------------------------------
function k=shear_Stiffness(E,I,L)
k=E*I/(L*L*L)*12;
