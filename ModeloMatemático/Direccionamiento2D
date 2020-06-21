%%Hablaremos del emisor/tag como el punto fijado en cualquier punto del plano

%%
global a
a=[0 0 0 0;0 0 0 0;0 0 0 0];
C1=[-1 0 0];
C2=[1 0 0];
C3=[0 1 0];
C4=[0 -1 0];
Puntos=[C1;C2;C3;C4];

%distancia entre puntos
D1_2=norm([C1;C2]);
D2_3=norm([C2;C3]);
D3_4=norm([C3;C4]);
D1_4=norm([C1;C4]);
D2_4=norm([C2;C4]);




for i=1:1:length(Puntos)
scatter3(Puntos(i,1),Puntos(i,2),Puntos(i,3));hold on
end

PosTag=[2 0 11]*1;%PosTag=[5 3 0];PosTag=[5 -3 0];PosTag=[-5 3 0];PosTag=[-5 -3 0];

limits=[-10,20,-10,20,-10,20]
axis(limits)
scatter3(PosTag(1),PosTag(2),PosTag(3)); 
hold on
%plot3(C1(1),C1(2),C2(3),PosTag(1),PosTag(2),PosTag(3));

%Distancia euclidiana entre dos puntos

d1=PosTag-C1
d2=PosTag-C2
d3=PosTag-C3
d4=PosTag-C4

A=PosTag-Puntos 

CT=vecnorm(A')
CTdelay=CT-max(CT)
x=CTdelay(1)-CTdelay(2);
y=CTdelay(4)-CTdelay(3);
%vector direcci�n 2D del emisor
scatter3(x,y,0); 

%plot superficie
quiver3(PosTag(1),PosTag(2),PosTag(3),-d1(1),-d1(2),-d1(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d2(1),-d2(2),-d2(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d3(1),-d3(2),-d3(3))
quiver3(PosTag(1),PosTag(2),PosTag(3),-d4(1),-d4(2),-d4(3))
%%

for i=1:1:length(Puntos)
scatter3(Puntos(i,1),Puntos(i,2),Puntos(i,3));hold on
end
