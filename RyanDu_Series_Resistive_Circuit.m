% Ryan Du, 02-10-2026
% We need to calculate total resistance, current, voltage drops, and power for a series circuit

1;  % This little makes it so that Octave actually recognizes this file as a script file rather than the whole .m file as a function file
    % I have no idea why this works

% Define the input values
R1 = 100;
R2 = 200;
R3 = 300;
R4 = 400;
V_source = 100;

% We put those resistor values into an array to make it easier to work with.
resistors = [R1, R2, R3, R4];


% --- Modular Functions ---

function R_eq = calculate_series_resistance(resistor_array)
    % Calculates the equivalent resistance of resistors in series
    % R_total = R1 + R2 + ... + Rn so we get the sum of all of the items in the array.
    R_eq = sum(resistor_array);
end

function V_drops = calculate_voltage_drops(resistor_array, R_total, V_source)
    % Calculates the voltage drop across each resistor using the Voltage Divider rule
    % Vx = (Rx / Rt) * Vs
    % We use './' operator to perform division across the array
    V_drops = (resistor_array ./ R_total) .* V_source;
end

function P_dissipated = calculate_power_dissipated(V_drops, resistor_array)
    % Calculates the power dissipated by each individual resistor
    % Px = (Vx^2) / Rx
    % We use the '.^' and './' operators to perform the calculations. 
    P_dissipated = (V_drops .^ 2) ./ resistor_array;
end

function P_total = calculate_total_power(V_source, R_total)
    % Calculates the total power supplied by the voltage source
    % Pt = (Vs^2) / Rt
    P_total = (V_source ^ 2) / R_total;
end

% 1. Calculate total resistance
R_total = calculate_series_resistance(resistors);
fprintf('Total Series Resistance: %d Ohms\n', R_total);

% 2. Calculate total current (to verify)
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

% We verify the total sum of individual power dissipation should equal total power
fprintf('Sum of individual power dissipated: %.2f Watts\n', sum(p_dissipated));