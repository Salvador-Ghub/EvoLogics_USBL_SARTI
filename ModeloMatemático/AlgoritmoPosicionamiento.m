clear all;%close all;
tic

double CTang
double CTdelayang
%iniciamos las posiciones de las antenas iz, dr, ar, ab.
dreal=47.5*10^-3;
%dreal=0.1;
C1=[-1 0 0]*dreal;
C2=[1 0 0]*dreal; 
C3=[0 1 0]*dreal;
C4=[0 -1 0]*dreal;
C5=[0 0 1]*dreal; 


PuntosAng=[C1;C2;C3;C4;C5];%juntamos posiciones en un array
errora=0;

PosTag=[3500 3500 3500];%%%Posici�n del emisor
PosTagReal=PosTag;
RanguloXZ=rad2deg(atan(PosTag(3)/(sqrt(PosTag(1)^2+PosTag(2)^2))))

Rangulorad=(atan(PosTag(3)/(sqrt(PosTag(1)^2+PosTag(2)^2))))
radXZ=atan(PosTag(3)/PosTag(1));
radXZR=radXZ;
scatter3(PosTag(1),PosTag(2),PosTag(3));hold on;
Aang=PosTag-PuntosAng;%resta de las posiciones por coordenadas respecto al emisor
CTang=vecnorm(Aang');%calcula la distancia de cada punto al emisor
CTdelayang=CTang-max(CTang);%interpretamos esta distancia como los retardos de se�al
%el valor m�s alto ser� restado al resto para que tenga mayor peso el
%primero en recibir la se�al
x=CTdelayang(1)-CTdelayang(2);%determina la componente x del vector de direcci�n del emisor en el plano x-y
y=CTdelayang(4)-CTdelayang(3);%determina la componente y del vector de direcci�n del emisor en el plano x-y
%es un peso que permite conocer el �ngulo de donde procede la se�al
scatter3(x,y,0);hold on; 

%muestra en plot 3D las posiciones de las antenas
for i=1:1:length(PuntosAng)
    switch i
        case 1
            form='+';
        case 2
            form='*';
        case 3
            form='o';
        case 4
            form='x';
        otherwise
            form='.';
    end
scatter3(PuntosAng(i,1),PuntosAng(i,2),PuntosAng(i,3),form);hold on
end

%muestra una flecha desde el origen de coordenadas hasta dos veces la
%distancia donde se encuentra el emisor
%figure
quiver3(0,0,0,PosTag(1)*2,PosTag(2)*2,PosTag(3)*2);hold on
alphaR=anguloVector(PosTag(1),PosTag(2));%�ngulo en el plano x-y real
alphaO=anguloVector(x,y);
%�ngulo en el plano x-y extraido de retardos (los valores de PosTag 
%cercanos a dos unidades con decimales distintos provocan un error de
%c�lculo peque�o)
error=alphaO-alphaR;%calculamos la diferencia entre ambos
%el error es cercano a un grado cuanto m�s cerrado sea el �ngulo sobre uno
%de los ejes

%en este momento disponemos de un �ngulo(con cierto error) en el plano x-y

%tratamos de rotar el eje z los mismos grados que la posici�n del emisor
%para tomar el nuevo plano X Z como zona de b�squeda en altura y longitud
%del emisor usando el descenso del gradiente en ese plano
newPuntosAng=[];%array vac�o para almacenar las posiciones de los puntos rotados



if alphaO>=0 && alphaO<90
        cuadrante=1;
    elseif alphaO>=90 && alphaO<180
        cuadrante=2;
    elseif alphaO>=180 && alphaO<270
        cuadrante=3;
    else 
        cuadrante=4;
end
%[C2-> C3A C1<- C4V] representaci�n de cada sensor
TablaA=[90, 180, 270, 0];%vector de rotaci�n de ejes, depende del cuadrante en el que est�
for i=1:cuadrante
TablaA = circshift(TablaA,1);%TablaA rotado
end

a=[90, 180, 270, 0];%�ngulos a restar de alpha  por cuadrante
for i=1:cuadrante
a = circshift(a,-1);%vector a rotado a la izquierda
end
aV=alphaO-a(3);%�ngulo a restar a alpha por cuadrante

TablaN=TablaA-aV;

for i=1:4
    %alpha=anguloVector(PuntosAng(i,1),PuntosAng(i,2))
   alpha=TablaN(i);
    newPuntosAng=[newPuntosAng ;dreal*cos(deg2rad(alpha)) dreal*sin(deg2rad(alpha)) 0];
       
end

for i=1:1:4
      switch i
        case 1
            form='*';
        case 2
            form='o';
        case 3
            form='+';
        case 4
            form='x';
        otherwise
            form='.';
    end
scatter3(newPuntosAng(i,1),newPuntosAng(i,2),newPuntosAng(i,3),form);hold on
quiver3(0,0,0,newPuntosAng(i,1),newPuntosAng(i,2),newPuntosAng(i,3));hold on
end
%newPuntosAng == [C2-> C3A C1<- C4V] representaci�n de cada sensor
%ordenar a [C1 C2 C3 C4] para que sean iguales que los originales
newPuntosAngO=[newPuntosAng(3,:);newPuntosAng(1,:);newPuntosAng(2,:); newPuntosAng(4,:);C5]

%%c�lculo de �ngulo

rx=rand(1,1)*3500;%vector de dos valores random entre 0 y 3500
rz=rand(1,1)*3500*2-3500;
rxz=[rx rz];
rxz=[1750 0];
beta=-pi/2;
%rxz=[2.1 2005];
%random=rxz;

h=(pi/2)/3;
lr=1;
grad=zeros(2);
derivadas=[];
derva=1;
derv=1;
grad=[-1 -1;-1 -1];
k=1;
errorTnA=10;%valor de error imaginario grande
   
    
        for mi=1:7
            PosTag=[rxz(1)*cos(beta+h) 0 rxz(1)*sin(beta+h)];
            %scatter3(PosTag(1),PosTag(2),PosTag(3));
            AangA=PosTag-newPuntosAngO;
            CTangA=vecnorm(AangA');
            CTdelayangS=CTangA-max(CTangA);%delay simulado
            error=CTdelayangS-CTdelayang;
            errorTn=sum(abs(error));
            if errorTn<errorTnA
                anguloE=beta+h;
                errorTnA=errorTn;
                rad2deg(beta+h)
            end
            hd=rad2deg(beta+h);
            h=h+(pi/2)/3;
            
        end
       
        
        errorTnA=10;
        betaEl=(pi/2)/3;
        betaInicial=anguloE-betaEl;
        l=1;
        n=1;
        anguloV=betaInicial;
        rad2deg(anguloV)
        for my=1:40
            
            PosTag=[rxz(1)*cos(anguloV) 0 rxz(1)*sin(anguloV)];
           rad2deg(anguloV)
    
            %scatter3(PosTag(1),PosTag(2),PosTag(3));hold on
   
            AangA=PosTag-newPuntosAngO;
            CTangA=vecnorm(AangA');
            CTdelayangS=CTangA-max(CTangA);%delay simulado
            error=CTdelayangS-CTdelayang;
            errorTn=sum(abs(error));
           
            if errorTn>=errorTnA
                %anguloE=beta+h
                l=l*(-1);
                n=n/2;
            end
            errorTnA=errorTn;
            %if my<31
            anguloV=anguloV+((pi/2)/3)*n*l;
            %end
        end
radXZrealCalculadaRad=anguloV;
radXZ=alphaO;
radXY=alphaO;
%%c�lculo de �ngulo



rxz=[1750 0];
h=1750;
lr=1;
grad=zeros(2);
derivadas=[];
derva=1;
derv=1;
grad=[1 1;1 1];
k=1;
vectorInicial=rxz;
vectorNuevo=(vectorInicial+h);
for i=1:30
    hold on        
    
    %%XXXXXXXXXXXXXXXXXXXX
   
    %%funcion nuevo punto
     PosTag2=[(vectorNuevo(1))*cos(anguloV) 0 (vectorNuevo(1))*sin(anguloV)];%posici�n tag simulado
     %PuntosRotados=PuntosAng-newPuntosAngO;
     AangA=PosTag2-newPuntosAngO;  
     CTangA=vecnorm(AangA');
     CTdelayangS=CTangA-max(CTangA);%delay simulado
     error=CTdelayangS-CTdelayang;
     errorTn=sum(abs(error));
%%funcion

%%funcion punto anterior
     PosTag1=[(vectorInicial(1))*cos(anguloV) 0 (vectorInicial(1))*sin(anguloV)];%posici�n tag simulado
     AangB=PosTag1-newPuntosAngO;  
     CTangB=vecnorm(AangB');
     CTdelayangS=CTangB-max(CTangB);%delay simulado
     error=CTdelayangS-CTdelayang;
     errorTa=sum(abs(error));
%%funcion
    deriv=(errorTn-errorTa)/(abs(h));
    grad(1)=deriv;
    %XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    
    if grad(1,1)>=0
        h=(h/2)*-1;
    end  
    
rxz(1)=PosTag2(1);
rxz(2)=PosTag2(3);
scatter3(rxz(1),errorTn,rxz(2));
[rxz(1),i,rxz(2)]  

vectorInicial=vectorNuevo;
vectorNuevo=vectorInicial+h;

%pause(0.01)
end


scatter3(rxz(1)*cosd(alphaO),rxz(1)*sind(alphaO),rxz(2),'filled')
PosTagTracked=[rxz(1)*cosd((alphaO)),rxz(1)*sind((alphaO)),rxz(2)]

AangA=PosTagTracked-PosTagReal;
ErrorFinal=vecnorm(AangA');
hold on;
scatter3(PosTagReal(1),PosTagReal(2),PosTagReal(3),30,ErrorFinal, 'filled')

xlabel('X [m]') 
ylabel('Y [m]') 
zlabel('Z [m]') 
toc
