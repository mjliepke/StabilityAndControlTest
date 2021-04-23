% Matt Liepke, Trim the Learjet24 and print values of throttle and elevator

[X0 U0] = air3m('trimLiepke',v,H,0);
fprintf('Altitude:\t%d[ft]\nVelocity:\t%d[ft/s]\nThrottle Trim:\t%d\nElevatorTrim:\t%d [rad]',X0(12),X0(1),U0(1),U0(7));