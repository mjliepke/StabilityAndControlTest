function C_M_alpha = C_M_alpha(AR, AR_tail, M, sweep_quarter, sweep_half, sweep_half_tail, nabla, V, x_a_bar, lf, lf_up, l_h, h_h, c_r, c_t, bf, b, printoutput)
%C_M_ALPHA returns total C_M_alpha from fuselage, tail and wings
% Built by Matt Liepke for AE 413 Test1
%   AR      : aspect ratio of wing
%   AR_tail : horz tail aspect ratio
%   M       : Mach at flight
%   sweep_quarter: quarter sweep of wing
%   sweep_half: half sweep of wing
%   sweep_half_tail: half sweep of horz tail;
%   nabla   : ratio of dynamic pressure, tail/wing
%   V       : volumetric ratio of tail/wing
%   x_a_bar : normalized dist from wing AC -> CG divided by chord
%   lf      : length of fuselage in ft
%   lf_up   : length of fuselage in upwash in ft
%   l_h     : length from wing AC to tail AC 
%   h_h     : vert height of horz tail from wing 
%   c_r     : root chord of wing
%   c_t     : tip chord of wing
%   bf      : fuselage width in inches(array of 5 sections: [ a b c d e])
%   b       : span of wing

K = 1;%all the calculations in class had K == 1 or very close
%fuselageCont2 = C_M_alpha_fuselage_liepke(lf, lf_up, l_h, h_h, c_r, c_t, bf, b, sweep_quarter);
fuselageCont = C_M_alpha_fuselage_shivers(lf, lf_up, l_h, h_h, c_r, c_t, bf, b, sweep_quarter);
wingCont = C_L_alphawing(AR, M, K, sweep_half) * x_a_bar;
tailCont = -C_L_alphawing(AR_tail, M, K, sweep_half_tail) * nabla * V;

if(printoutput)
    fprintf("Contribution to C_M_alpha:\n\tFuselage : %.5f\n\tWing : %.5f\n\tTail : %.5f\n",fuselageCont, wingCont, tailCont);
end
C_M_alpha = fuselageCont + wingCont + tailCont;
end
