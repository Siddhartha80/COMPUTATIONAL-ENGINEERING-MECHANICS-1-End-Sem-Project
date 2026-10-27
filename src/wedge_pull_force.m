function result = wedge_pull_force(loadN, muAB, muAC, muBD, thetaDeg)
%WEDGE_PULL_FORCE Minimum force P needed to pull wedge A out from under wedge B.
%
%   result = WEDGE_PULL_FORCE(loadN, muAB, muAC, muBD)
%   result = WEDGE_PULL_FORCE(loadN, muAB, muAC, muBD, thetaDeg)
%
%   Two wedges are stacked between a floor (C) and a wall (D). A vertical load
%   acts on the top wedge B, and a horizontal force P pulls the bottom wedge A
%   out. Friction acts on the contact surfaces A-B, A-C and B-D and is taken at
%   its limiting value (F_S = mu * F_R). The weights of the wedges are neglected.
%
%   Inputs
%     loadN     Vertical load on wedge B                    [N]
%     muAB      Coefficient of friction between A and B     [-]
%     muAC      Coefficient of friction between A and floor [-]
%     muBD      Coefficient of friction between B and wall  [-]
%     thetaDeg  Wedge angle (default 15)                    [deg]
%
%   Output (struct, all forces in N)
%     FRAB, FSAB   Normal and friction force between A and B
%     FRBD, FSBD   Normal and friction force between B and the wall
%     FRAC, FSAC   Normal and friction force between A and the floor
%     P            Minimum horizontal force that pulls wedge A out
%
%   Equilibrium of wedge B:
%     sum Fx:  FRBD = FRAB*(sin(theta) - muAB*cos(theta))
%     sum Fy:  loadN = muBD*FRBD + FSAB*sin(theta) + FRAB*cos(theta)
%   Equilibrium of wedge A:
%     sum Fy:  FRAC = FRAB*cos(theta) + FSAB*sin(theta)
%     sum Fx:  P = FSAC + FSAB*cos(theta) - FRAB*sin(theta)

    if nargin < 5
        thetaDeg = 15;
    end

    s = sind(thetaDeg);
    c = cosd(thetaDeg);

    % Wedge B
    FRAB = loadN / (c + muAB*s + muBD*(s - muAB*c));
    FSAB = muAB * FRAB;
    FRBD = FRAB * (s - muAB*c);
    FSBD = muBD * FRBD;

    % Wedge A
    FRAC = FRAB*c + FSAB*s;
    FSAC = muAC * FRAC;
    P    = FSAC + FSAB*c - FRAB*s;

    result = struct('FRAB', FRAB, 'FSAB', FSAB, ...
                    'FRBD', FRBD, 'FSBD', FSBD, ...
                    'FRAC', FRAC, 'FSAC', FSAC, ...
                    'P', P);
end
