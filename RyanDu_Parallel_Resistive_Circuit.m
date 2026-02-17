% Ryan Du, 02-15-2026
% Calculates equivalent resistance, branch currents, and power for a parallel circuit

1; % Forces Octave to treat this as a script file

% --- Main Script Logic ---

% Define input values
R1 = 100;
R2 = 200;
R3 = 300;
R4 = 400;
I_total_source = 10; % Total current in Amperes

% We make an array with the initial input values.
resistors = [R1, R2, R3, R4];

% --- Modular Functions ---

function R_eq = calculate_parallel_resistance(resistor_array)
    % Calculates equivalent resistance for parallel resistors
    % Formula: 1 / ( (1/R1) + (1/R2) + ... )
    
    % We use 1./resistor_array to get the reciprocal of EACH resistor
    reciprocals = 1 ./ resistor_array; 
    
    % Then sum them up and take the inverse of the sum
    R_eq = 1 / sum(reciprocals);
end

function I_branches = calculate_current_divider(I_total, R_total, resistor_array)
    % Calculates current through individual parallel branches
    % Standard Current Divider Formula for parallel: Ix = It * (Rt / Rx)
    
    I_branches = I_total .* (R_total ./ resistor_array);
end

function P_dissipated = calculate_power_dissipated(I_branches, resistor_array)
    % Calculates power dissipated by individual resistors
    % Pn = (In^2) * Rn
    
    P_dissipated = (I_branches .^ 2) .* resistor_array;
end

function P_total = calculate_total_power(I_total, R_total)
    % Calculates total power supplied
    % Corrected Formula: Pt = (It^2) * Rt
    
    P_total = (I_total ^ 2) * R_total;
end

% 1. Calculate Total Parallel Resistance
R_total = calculate_parallel_resistance(resistors);
fprintf('Total Parallel Resistance (Rt): %.2f Ohms\n', R_total);

% 2. Calculate Voltage across the parallel bank (V = I * R)
% In parallel, the voltage is the same across ALL components.
V_total = I_total_source * R_total;
fprintf('Voltage across parallel branches: %.2f Volts\n\n', V_total);

% 3. Calculate Current through each resistor (Current Divider)
branch_currents = calculate_current_divider(I_total_source, R_total, resistors);
for i = 1:length(resistors)
    fprintf('Current through R%d (%d Ohms): %.4f Amps\n', i, resistors(i), branch_currents(i));
end
fprintf('\n');

% 4. Calculate Power dissipated by each resistor
p_dissipated = calculate_power_dissipated(branch_currents, resistors);
for i = 1:length(resistors)
    fprintf('Power dissipated by R%d: %.2f Watts\n', i, p_dissipated(i));
end
fprintf('\n');

% 5. Calculate Total Power Supplied
P_total = calculate_total_power(I_total_source, R_total);
fprintf('Total Power Supplied by Source: %.2f Watts\n', P_total);

% Verification: Sum of individual powers should equal total power
fprintf('Sum of individual power dissipations: %.2f Watts\n', sum(p_dissipated));
