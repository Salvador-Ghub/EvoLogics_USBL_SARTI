a=[0 0 0 0;0 0 0 0;0 0 0 0]
C1=[-1 0 0];
C2=[1 0 0];
C3=[0 1 0];
C4=[0 -1 0];
Puntos=[C1;C2;C3;C4];

for i=1:1:length(Puntos)
scatter3(Puntos(i,1),Puntos(i,2),Puntos(i,3));hold on
end

PosTag=[5 2 4];
limits=[-10,20,-10,20,-10,20]
axis(limits)
scatter3(PosTag(1),PosTag(2),PosTag(3)); 
hold on
%plot3(C1(1),C1(2),C2(3),PosTag(1),PosTag(2),PosTag(3));
d1=PosTag-C1
d2=PosTag-C2
d3=PosTag-C3
d4=PosTag-C4
quiver3(PosTag(1),PosTag(2),PosTag(3),-d1(1),-d1(2),-d1(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d2(1),-d2(2),-d2(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d3(1),-d3(2),-d3(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d4(1),-d4(2),-d4(3))

[x y z] = sphere; 
for r=1:0.01:9
s1=surf(x*r+PosTag(1),y*r+PosTag(2),z*r+PosTag(3));
pause(0.05)
delete(s1)
end

clear all
[x y z] = sphere; 
a=[0 0 0 2;0 0 0 0;0 0 0 0] 
 
s1=surf(x*r,y*r,z*r);
%hold on 
%s2=surf(x*a(2,4),y*a(2,4),z*a(2,4)); 
%s3=surf(x*a(3,4)+a(3,1),y*a(3,4)+a(3,2),z*a(3,4)+a(3,3)); 



PosTag=[5 1 0]*3
sep=norm(C1-C2)
h=norm(PosTag-C1)
h2=norm(PosTag-C2)
Puntos=[C1;C2;PosTag];
for i=1:1:length(Puntos)
scatter3(Puntos(i,1),Puntos(i,2),Puntos(i,3));hold on
end
dif=h-h2; %la diferencia de tiempo de una posici�n a otra es constante si se dibuja en la misma direcci�n y por la superficie de cono
v=sep+(h-h2);


[X Y Z]=meshgrid(0:0.5:1)
U=X; V=Y; W=Z;
[cx cy cz]=meshgrid([1 0 0])
coneplot(X,Y,Z,U,V,W,cx,cy,cz)
