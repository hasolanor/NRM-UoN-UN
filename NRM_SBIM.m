%Parameter assignment for SBIM (Solano et. al, 2020)
% 0: Variables associated with physicochemical mechanisms
% 1: Variables associated with mechanical mechanisms
Da0=parameters(1);
Da1=parameters(2);
k0s=parameters(3);
k0cs=parameters(4);
k1s=parameters(5);
k1cs=parameters(6);

%Retention function regarding both mechanisms over the rock
F=@(c,s) (Da0./cond.v).*(c-k0s.*s-k0cs.*c.*s.*cond.c)+...
    Da1.*(c-k1s.*s-k1cs.*c.*s.*cond.c);

%PDE-customised array
pdefun = @(t,x,s,u) [F(u,s); -F(u,s)+...
        (iPe(1)+iPe(2)./cond.v).*diff(u,2)-diff(u)];

%PDE-customised solution with ChebFun
[solution.t, solution.s, solution.u] = ...
        pde23t(pdefun, t, init.sol0, init.bc, opts);