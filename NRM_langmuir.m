%Parameter assignment for Langmuir (Zhang (2012) explains this one)
Da=parameters(1);
ks=parameters(2);
kcs=parameters(3)^(-1); % Langmuir considers s_max:=1/kcs

%Retention function based on Langmuir attachment-detachment
F=@(c,s) Da.*(c-ks.*s-kcs.*c.*s.*cond.c);

%PDE-customised array
pdefun = @(t,x,s,u) [F(u,s); -F(u,s)+...
        (iPe(1)+iPe(2)./cond.v).*diff(u,2)-diff(u)];

%PDE-customised solution with ChebFun
[solution.t, solution.s, solution.u] = ...
        pde23t(pdefun, t, init.sol0, init.bc, opts);

