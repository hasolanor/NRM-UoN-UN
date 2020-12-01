%Parameter assignment for ITSM (Zhang, 2012)
% 0: Variables associated with reversible site
% 1: Variables associated with irreversible site
Da0=parameters(1);
Da1=parameters(2);
k0s=parameters(3);
k0cs=parameters(4)^(-1); % ITSM considers s_max:=1/kcs
k1cs=parameters(5)^(-1); % ITSM considers s_max:=1/kcs

%Retention function for both active sites over the rock
F0=@(c,s) (Da0./cond.v).*(c-k0s.*s-k0cs.*c.*s.*cond.c);
F1=@(c,s) (Da0./cond.v).*(c-k1cs.*c.*s.*cond.c);

%PDE-customised array
pdefun = @(t,x,s0,s1,u) [F0(u,s0); F1(u,s1);...
            -F(u,s)+(iPe(1)+iPe(2)./cond.v).*diff(u,2)-diff(u)];

%PDE-customised solution with ChebFun
[solution.t, solution.s, solution.s1, solution.u] = ...
        pde23t(pdefun, t, init.sol0, init.bc, opts);

solution.s=solution.s1+solution.s2;