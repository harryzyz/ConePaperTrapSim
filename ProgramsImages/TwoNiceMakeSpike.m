%% Two good make a spike

gail.InitializeWorkspaceDisplay

f = @(x,c,a) exp(- a*(x-c).^2);
wind = @(x,c,b,d) (x >= c).*(x <= b)./(1 + exp((d.*(b-c)*(b+c-2*x))./((x - c).*(b - x)))) + (x > b);
%phi = @(x,c,b,a,d) x.*(x < c) + c.*(x >=c) + (x >= c).*(x <= b).*(a-c) ./(1 + exp((d.*(b-c)*(b+c-2*x))./((x - c).*(b - x)))) + (x > b).*(a-c);
phi = @(x,c,b,a) x.*(x < c) + (x >= c).*(x < b).*(a + (c-a).*exp(((b-c)/(a-c))*(x - c)./(x - b - 1e-10))) + (x >= b).*a;
xp = 0:0.001:1;
af = 40;
wd = 0.01;
f1x = f(xp,1/2,af);
% f3x = xp;
% f3x(xp <= 1/2) = 0.5*(f(xp(xp <= 1/2), 1/2, af) ...
%    - f(phi(xp(xp <= 1/2),0.4, 0.43, 0.415, 0.2), 1/2, af));
% f3x = 0.5*(f(xp,1/2,af).*(wind(xp,0.4,0.43,wd) - wind(xp,0.57,0.6,wd)) ...
%    + f(0.4,1/2,af).* (- wind(xp,0.4,0.43,wd) + wind(xp,0.57,0.6,wd)) );
%f2x = 2*f3x - f1x;
%f2x = -f(xp,1/2,af) + (f(xp,1/2,af) - f(0.415,1/2,af)).*(wind(xp,0.4,0.43,wd)-wind(xp,0.57,0.6,wd));
pkst = 0.4;
plat = 0.42;
platst = 0.45;
f2x = xp;
f2x(xp <= 1/2) = -f(phi(xp(xp <= 1/2),pkst, platst, plat), 1/2, af);
f2x(xp > 1/2) = -f(phi(1 - xp(xp > 1/2),pkst, platst, plat), 1/2, af);
f3x = 0.5*(f1x+f2x);
figure
plot(xp, f1x, '-', 'linewidth', 4)
text(0.29, -0.15, 'reasonable \(f_1\)', 'fontsize',32)
axis([0 1 -1 1])
axis off
print('-dpng','broadpk.png')

figure
plot(xp, f2x, '-','color',MATLABOrange, 'linewidth', 4)
axis([0 1 -1 1])
axis off
text(0.29, 0.15, 'reasonable \(f_2\)', 'fontsize',32)
print -dpng choppedpk.png

figure
plot(xp, f3x, '-','color',MATLABGreen, 'linewidth', 4)
axis([0 1 -1 1])
axis off
text(0.2, -0.2, 'spiky \(0.5 f_1 + 0.5 f_2\)', 'fontsize',32)
print -dpng narrowpk.png



