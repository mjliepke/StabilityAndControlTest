function C_L = C_L(weight, q_inf, S)
%LIFTCOEFF Provides C_L given steady flight with aircraft parameters
% Built by Matt Liepke for AE 413 Test1
C_L = weight / (q_inf * S);
end

