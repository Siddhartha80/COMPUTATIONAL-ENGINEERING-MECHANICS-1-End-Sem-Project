% RUN_CASES Evaluate the wedge problem for the three load cases of the project.
%
% Run from the src/ folder:   >> run_cases

clear; clc;

thetaDeg = 15;               % wedge angle [deg]
loadN    = [300 400 500];    % vertical load on wedge B [N]
muAB     = [0.1  0.2  0.3 ]; % friction coefficient, wedges A-B
muAC     = [0.2  0.4  0.6 ]; % friction coefficient, wedge A-floor C
muBD     = [0.15 0.3  0.45]; % friction coefficient, wedge B-wall D

fprintf('Wedge angle = %g deg\n\n', thetaDeg);
fprintf('%8s %6s %6s %6s | %9s %9s %9s %9s | %9s\n', ...
        'Load[N]', 'muAB', 'muAC', 'muBD', 'FRAB[N]', 'FRAC[N]', 'FSAB[N]', 'FSAC[N]', 'P[N]');
fprintf('%s\n', repmat('-', 1, 93));

for k = 1:numel(loadN)
    r = wedge_pull_force(loadN(k), muAB(k), muAC(k), muBD(k), thetaDeg);
    fprintf('%8g %6.2f %6.2f %6.2f | %9.3f %9.3f %9.3f %9.3f | %9.4f\n', ...
            loadN(k), muAB(k), muAC(k), muBD(k), r.FRAB, r.FRAC, r.FSAB, r.FSAC, r.P);
    if r.FRBD < 0
        fprintf('         Note: FRBD = %.2f N is negative (muAB > tan(theta)), so the wall\n', r.FRBD);
        fprintf('         cannot push on wedge B and the result is outside the model''s range.\n');
    end
end
