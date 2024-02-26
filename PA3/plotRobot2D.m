% plotRobot2D(ls,angs)
% ls: a vector containing the link lengths
% angs: a vector containing the link rotation angles
%
function plotRobot2D(ls,angs,linespec)
if(nargin<3)
  linespec='';
end
holdon=ishold;
hold on;
axis equal;

%draw invisible workspace
ltot=sum(ls);
plot([-ltot,ltot,ltot,-ltot],[-ltot,-ltot,ltot,ltot],'w');

%draw each segment
f=0;
t=0;
for j=1:length(ls)
  t=t+angs(j);
  p=f+(cos(t)+i*sin(t))*(ls(j));
  plotSeg(f,p,linespec);
  hold on;
  f=p;
end

%Restore hold
if holdon
  hold on
else
  hold off
end

function plotSeg(from,to,linespec)
d=to-from;
l=norm(d);
r1=l/10;
r2=l/15;
r3=l/7;
d=d/l;
ks=strcat('k',linespec);

mycircle(l/10,real(from),imag(from),ks);
mycircle(l/15,real(to),imag(to),ks);

pts=[from+r1*i*d,to+r2*i*d];
plot(real(pts),imag(pts),ks);
pts=[from-r1*i*d,to-r2*i*d];
plot(real(pts),imag(pts),ks);

%The axis
pts=[to,to+r3*d];
plot(real(pts),imag(pts),strcat('r',linespec));
pts=[to,to+i*r3*d];
plot(real(pts),imag(pts),strcat('g',linespec));

function mycircle(rad,px,py,opts)
t=linspace(0,2*pi,10);
plot(rad*cos(t)+px,rad*sin(t)+py,opts);