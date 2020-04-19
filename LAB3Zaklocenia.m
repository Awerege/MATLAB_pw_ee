% liczba liter imienia
I=9;
%liczba liter nazwiska
N=9;
%numer na li�cie
nr=14;
%napi�cie bazowe [kV]
Ub110=1.05*110;
Ub400=1.05*400;
Ub20=1.05*20;
%napi�cie �r�d�a zastepczego [pu]
U1pu=1.05;
%moc bazowa [MVA]
Sb=100;
%napi�cia zwarcia transforamtor�w [%]
UzT1=12.5;
UzT2=12.5;
UzTR=11;
UzTS41=12.5;
UzTS13=9;
UzTS43=15;
%moce znamionowe transformator�w [MVA]
SnT1=426;
SnT2=426;
SnTR=25;
SnTS=250;
%reaktancje podprzej�ciowe generator�w[%]
XdG1=25;
XdG2=25;
%moc znamionowa generator�w [MVA]
SnG1=426;
SnG2=426;
%napi�cie znamionowe generat�r�w [kV]
UnG1=21;
UnG2=21;
% D�ugo�cci linii [km]
w1=(30+5*nr)*(I/(I+N))
w2=(30+5*nr)*(N/(I+N))
%Reaktancja jednostkowa linii [Ohm/km]
xl1=0.36;
xl2=0.4;
%reaktancja bazowa [Ohm]
XbL1=Ub400^2/Sb
XbL2=Ub110^2/Sb
%reaktancje element�w dla sk�adowych zgodnej i przeciwnej [pu]
X1L1=(w1*xl1)/XbL1
X1L2=(w2*xl2)/XbL2
X1T1=(UzT1/100)*(Sb/SnT1)
X1T2=(UzT2/100)*(Sb/SnT2)
X2T1=(UzT1/100)*(Sb/SnT1)
X2T2=(UzT2/100)*(Sb/SnT2)
X1TR=(UzTR/100)*(Sb/SnTR)
X2TR=(UzTR/100)*(Sb/SnTR)
X1G1=(XdG1/100)*(Sb/SnG1)
X1G2=(XdG2/100)*(Sb/SnG2)
%reaktancje dla transformatora TS [pu]
X1TS41=(UzTS41/100)*(Sb/SnTS)
X2TS41=X1TS41
X1TS43=(UzTS43/100)*(Sb/SnTS)
X2TS43=X1TS43
X1TS13=(UzTS13/100)*(Sb/SnTS)
X2TS13=X1TS13
%przeliczone reaktancje transformatora 3uzwojeniowego TS na uk�ad gwiazdy [pu]
X1TS4=0.5*(X1TS41+X1TS43-X1TS13)
X2TS4=X1TS4
X1TS1=0.5*(X1TS41+X1TS13-X1TS43)
X2TS1=X1TS1
X1TS3=0.5*(X1TS43+X1TS13-X1TS41)
X2TS3=X1TS3
%obliczenie reaktancji dla sk�adowej zerowej [pu]
X0L1=X1L1*(2.8)
X0L2=X1L2*(2.8)
X0T1=X1T1*(1.0)
X0TR=X1TR*(0.85)
X0TS4=X1TS4*(1.0)
X0TS1=X1TS1*(1.0)
X0TS3=X1TS3*(1.0)

% a) PR�D W MIEJSCU ZWARCIA
%reaktancja zast�pcza Thevina 
    %dla sk��dowych zgodnej i przeciwnej [pu]
X1Thpu=(X1G1+X1T1)*(X1G2+X1T2)/(X1G1+X1T1+X1G2+X1T2)+X1L1+X1TS1+X1TS4+X1L2
X2Thpu=X1Thpu
    %dla s�adowej zerowej [pu]
% na lewo od szyn D
X0lThpu=(X0TS3*(X0TS4+X0L1+X0T1))/(X0TS3+X0TS4+X0L1+X0T1)+X0TS1+X0L2
%na prawo od szyn D
X0pThpu=X0TR;
%ca�kowita
X0Thpu=(X0lThpu*X0pThpu)/(X0lThpu+X0pThpu)
%pr�d w miejscu zwarcia [pu]
I1Kpu=U1pu/(X1Thpu+X2Thpu+X0Thpu)
I2Kpu=I1Kpu
I0Kpu=I1Kpu
%warto�ci fazowe pr�du zwarcia [pu]
IL1pu=3*I1Kpu
IL2pu=0
IL3pu=0
%warto�ci fazowe pr�du zwarcia [kA]
IL1=3*I1Kpu*(Sb/(sqrt(3)*Ub110))
IL2=0
IL3=0

% b) PR�DY ZWARCIOWE DOP�YWAJ�CE LINIAMI L1 ORAZ L2
%dla sk�adowej symetrycznej zgodnej i przeciwnej [pu]
I1L2pu=I1Kpu
I2L2pu=I1Kpu
%sk�adowej symetrycznej zgodnej [pu]
I0L2pu=I0Kpu*(X0TR/(X0TR+X0lThpu))
%warto�c fazowe pr�du zwarciowego w linii L2 [pu]
IL1L2pu=I0L2pu+I1L2pu+I2L2pu
IL2L2pu=I0L2pu+(-0.5+sqrt(3)*j/2)*I1L2pu+(-0.5-sqrt(3)*j/2)*I2L2pu
IL3L2pu=I0L2pu+(-0.5-sqrt(3)*j/2)*I1L2pu+(-0.5+sqrt(3)*j/2)*I2L2pu
%warto�ci fazowe pr�du zwarciowego w linii L2 [kA]
IL1L2=IL1L2pu*(Sb/(sqrt(3)*Ub110))
IL2L2=IL2L2pu*(Sb/(sqrt(3)*Ub110))
IL3L2=IL3L2pu*(Sb/(sqrt(3)*Ub110))
%pr�d zwarciowy dop�ywaj�cy lini� L1
%ska�adowe symetryczne zgodna i przeciwna [pu]
I1L1pu=I1Kpu
I2L1pu=I1Kpu
%sk�adowa symeteryczna zerowa [pu]
I0L1pu=I0L2pu*(X0TS3/(X0TS3+X0TS4+X0L1+X0T1))
%warto�c fazowe pr�du zwarciowego w linii L1 [pu]
IL1L1pu=I0L1pu+I1L1pu+I2L1pu
IL2L1pu=I0L1pu+(-0.5+sqrt(3)*j/2)*I1L1pu+(-0.5-sqrt(3)*j/2)*I2L1pu
IL3L1pu=I0L1pu+(-0.5-sqrt(3)*j/2)*I1L1pu+(-0.5+sqrt(3)*j/2)*I2L1pu
%warto�ci fazowe pr�du zwarciowego w linii L1 [kA]
IL1L1=IL1L1pu*(Sb/(sqrt(3)*Ub400))
IL2L1=IL2L1pu*(Sb/(sqrt(3)*Ub400))
IL3L1=IL3L1pu*(Sb/(sqrt(3)*Ub400))

% c)PR�D WYP�YWAJ�CY Z GENERATORA G1
%sk�adowa zgodna i przeciwna pr�du dop�ywaj�ce do linii L1 przez trafo T1,
%po stronie g�rnego napi�cia [pu]
I1T1gpu=I1L1pu*((X1G1+X1T1)/(X1G1+X1T1+X1G2+X1T2))
I2T1gpu=I1L1pu*((X1G1+X1T1)/(X1G1+X1T1+X1G2+X1T2))
%sk�adowa zgodna i przeciwna pr�du wyp�ywaj�cgo z generatora G1; pr�d po
%stronie dolnego napi�cia transformatora [pu]
I1G1pu=I1T1gpu*exp(-i*5*30*pi/180)
I2G1pu=I2T1gpu*exp(i*5*30*pi/180)
%sk�adowa zerowa [pu]
I0G1pu=0
%warto�ci fazowe pr�du zwarciowego wyp�ywaj�cego z generatora
IL1G1pu=I1G1pu+I2G1pu
IL2G1pu=I1G1pu*exp(-i*120*pi/180)+I2G1pu*exp(i*120*pi/180)
IL3G1pu=I1G1pu*exp(i*120*pi/180)+I2G1pu*exp(-i*120*pi/180)
%warto�ci mianowane pr�du zwarciowego wyp�ywaj�cego z generatora
IL1G1=IL1G1pu*(100/(sqrt(3)*Ub20))
IL2G1=IL2G1pu*(100/(sqrt(3)*Ub20))
IL3G1=IL3G1pu*(100/(sqrt(3)*Ub20))
% d) OBLICZENIA DLA PRZYPADKU OTWARCIA WY��CZNIKA W
%reaktancja zast�pcza Thevina dla sk�adowej zerowej [pu]
X0oThpu=(X0TS3*(X0TS4+X0L1+X0T1))/(X0TS3+X0TS4+X0L1+X0T1)+X0TS1+X0L2
%pr�d w miejscu zwarcia [pu]
I1oKpu=U1pu/(X1Thpu+X2Thpu+X0oThpu)
%ska�adowe symetryczna zgodna zgodna pr�du dop�ywaj�cego lini� L1 [pu]
I1oL1pu=I1oKpu
%sk�adowa zgodna i przeciwna pr�du dop�ywaj�ce do linii L1 przez trafo T1,
%po stronie g�rnego napi�cia [pu]
I1oT1gpu=I1oL1pu*((X1G1+X1T1)/(X1G1+X1T1+X1G2+X1T2))
I2oT1gpu=I1oL1pu*((X1G1+X1T1)/(X1G1+X1T1+X1G2+X1T2))
%sk�adowa zgodna i przeciwna pr�du wyp�ywaj�cgo z generatora G1; pr�d po
%stronie dolnego napi�cia transformatora [pu]
I1oG1pu=I1oT1gpu*exp(-i*5*30*pi/180)
I2oG1pu=I2oT1gpu*exp(i*5*30*pi/180)
%sk�adowa zerowa [pu]
I0oG1pu=0
%warto�c fazowe pr�du zwarciowego wyp�ywaj�cego z G1 [pu]
IoL1G1pu=I0oG1pu+I1oG1pu+I2oG1pu
IoL2G1pu=I0oG1pu+(-0.5-sqrt(3)*j/2)*I1oG1pu+(-0.5+sqrt(3)*j/2)*I2oG1pu
IoL3G1pu=I0oG1pu+(-0.5+sqrt(3)*j/2)*I1oG1pu+(-0.5-sqrt(3)*j/2)*I2oG1pu
%warto�ci fazowe pr�du zwarciowego w linii L1 [kA]
IoL1G1=IoL1G1pu*(Sb/(sqrt(3)*Ub20))
IoL2G1=IoL2G1pu*(Sb/(sqrt(3)*Ub20))
IoL3G1=IoL3G1pu*(Sb/(sqrt(3)*Ub20))




















