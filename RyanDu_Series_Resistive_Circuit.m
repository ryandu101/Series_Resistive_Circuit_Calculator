% Ryan Du, 02-10-2026
% Calculates total resistance, current, voltage drops, and power for a series circuit

1; % Forces Octave to treat this as a script file rather than a function file

% --- Modular Functions ---

function R_eq = calculate_series_resistance(resistor_array)
    % Calculates the equivalent resistance of resistors in series
    % R_total = R1 + R2 + ... + Rn
    R_eq = sum(resistor_array);
end

function V_drops = calculate_voltage_drops(resistor_array, R_total, V_source)
    % Calculates the voltage drop across each resistor using the Voltage Divider rule
    % Vx = (Rx / Rt) * Vs
    % The './' operator performs element-wise division across the array
    V_drops = (resistor_array ./ R_total) .* V_source;
end

function P_dissipated = calculate_power_dissipated(V_drops, resistor_array)
    % Calculates the power dissipated by each individual resistor
    % Px = (Vx^2) / Rx
    % The '.^' and './' operators perform element-wise math
    P_dissipated = (V_drops .^ 2) ./ resistor_array;
end

function P_total = calculate_total_power(V_source, R_total)
    % Calculates the total power supplied by the voltage source
    % Pt = (Vs^2) / Rt
    P_total = (V_source ^ 2) / R_total;
end

% --- Main Script Logic ---

% Define the input values
R1 = 100;
R2 = 200;
R3 = 300;
R4 = 400;
V_source = 100;

% Create an array of the resistors
resistors = [R1, R2, R3, R4];

% 1. Calculate total resistance
R_total = calculate_series_resistance(resistors);
fprintf('Total Series Resistance: %d Ohms\n', R_total);

% 2. Calculate total current (Optional, but good for verification)
I_total = V_source / R_total;
fprintf('Total Current: %.4f Amps\n\n', I_total);

% 3. Calculate voltage drops
v_drops = calculate_voltage_drops(resistors, R_total, V_source);
for i = 1:length(resistors)
    fprintf('Voltage drop across R%d (%d Ohms): %.2f Volts\n', i, resistors(i), v_drops(i));
end
fprintf('\n');

% 4. Calculate power dissipated by each resistor
p_dissipated = calculate_power_dissipated(v_drops, resistors);
for i = 1:length(resistors)
    fprintf('Power dissipated by R%d: %.2f Watts\n', i, p_dissipated(i));
end
fprintf('\n');

% 5. Calculate total power supplied
P_total = calculate_total_power(V_source, R_total);
fprintf('Total Power Supplied: %.2f Watts\n', P_total);

% Verification: The sum of individual power dissipations should equal total power
fprintf('Sum of individual power dissipated: %.2f Watts\n', sum(p_dissipated));