clc
clear
format short

%litery imienia
I=9;
%litery nazwiska 
N=9;
%numer na li?cie
Nr=14;
%d?ugo?ci linii
w1=(30+5*Nr)*(I/(I+N))
w2=(30+5*Nr)*(N/(I+N))
%nap zastepcze thvenina
U1pu=1.05;
%napi?cie bazowe [kV]
Ub=1.05*110;
%moc bazowa [MVA]
Sb=100;
%Reaktancja jednostkowa linii [Ohm/km]
xl=0.4;
%reaktancja bazowa [Ohm]
Xb=Ub^2/Sb;
%napi?cia zwarcia transforamtorów [%]
UzT1=11;
UzT2=11;
SnT1=16;
SnT2=16;
%moc zwarciowa podsystemu [MVA]
SkQ1=840;
SkQ2=1030;
% Reaktancje elementów [pu]
X1L1=(w1*xl)/Xb
X2L1=(w1*xl)/Xb
X1L2=(w2*xl)/Xb
X2L2=(w2*xl)/Xb
X1T1=(UzT1/100)*(Sb/SnT1)
X1T2=(UzT1/100)*(Sb/SnT1)
X2T1=(UzT2/100)*(Sb/SnT2)
X2T2=(UzT2/100)*(Sb/SnT2)
X1Q1=Sb/SkQ1
X2Q1=Sb/SkQ1
X1Q2=Sb/SkQ2
X2Q2=Sb/SkQ2

%aaaaaaaaaaaaaaaaaaaa
%reaktacja zstpecza thevenina
X1Thpu=(X1T1*X1T2)/(X1T1+X1T2)+((X1Q1+X1L1)*(X1Q2+X1L2))/((X1Q1+X1L1)+(X1Q2+X1L2))
X2Thpu=(X1T1*X1T2)/(X1T1+X1T2)+((X1Q1+X1L1)*(X1Q2+X1L2))/((X1Q1+X1L1)+(X1Q2+X1L2))

%prad w miejscu zwarcia
I1Kpu=i*U1pu/(i*(X1Thpu+X2Thpu))
I2Kpu=-i*U1pu/(i*(X1Thpu+X2Thpu))

%pr¹dy fazowe [pu] w miejscu zwarcia
IL1pu=0
IL2pu=(-i*sqrt(3))*I1Kpu
IL3pu=(i*sqrt(3))*I1Kpu

%pr¹dy fazowe [kA]
IL1=IL1pu*Sb/(sqrt(3)*Ub)
IL2=IL2pu*Sb/(sqrt(3)*Ub)
IL3=IL3pu*Sb/(sqrt(3)*Ub)

%przenoszenie sk³¹dowych pr¹du na górna stronê trafo
I1gpu=I1Kpu*exp(i*150*pi/180)
I2gpu=I2Kpu*exp(-i*5*30*pi/180)

%skó³¹dowa symetrczyna pr¹du zwarcia dop³ywaj¹ca linia L1
I1zpu=I1gpu*((X1Q2+X1L2)/(X1Q1+X1L1+X1Q2+X1L2))
I2zpu=I2gpu*((X2Q2+X2L2)/(X2Q1+X2L1+X2Q2+X2L2))

%(-0.5-sqrt(3)*j/2)

%pr¹dy fazowe [pu] w lini L1
IL1zpu=I1zpu+I2zpu
IL2zpu=(-0.5-sqrt(3)*j/2)*I1zpu+(-0.5+sqrt(3)*j/2)*I2zpu
IL3zpu=(-0.5+sqrt(3)*j/2)*I1zpu+(-0.5-sqrt(3)*j/2)*I2zpu

%pr¹dy fazowe [kA] w lini L1
IL1z=IL1zpu*Sb/(sqrt(3)*Ub)
IL2z=IL2zpu*Sb/(sqrt(3)*Ub)
IL3z=IL3zpu*Sb/(sqrt(3)*Ub)


%bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
%reaktancje zastepcze thevenina zwarcia a

X1Thapu=X1Q1+X1L1+X1T1
X2Thapu=X1Q1+X1L1+X1T1

%reaktancje zastepcze thevenina zwarcia b
X1Thbpu=X1T2+X1L2+X1Q2
X2Thbpu=X1T2+X1L2+X1Q2

%sk³¹dowe symetryczne pradu zwarcia a
I1Kapu=i*U1pu/(i*(X1Thapu+X2Thapu))
I2Kapu=-i*U1pu/(i*(X1Thapu+X2Thapu))

%sk³¹dowe symetryczne pradu zwarcia b
I1Kbpu=i*U1pu/(i*(X1Thbpu+X2Thbpu))
I2Kbpu=-i*U1pu/(i*(X1Thbpu+X2Thbpu))


%pr¹dy fazowe [pu] a
IL1apu=0
IL2apu=(-i*sqrt(3))*I1Kapu
IL3apu=(i*sqrt(3))*I1Kapu

%pr¹dy fazowe [kA] a
IL1a=IL1apu*Sb/(sqrt(3)*Ub)
IL2a=IL2apu*Sb/(sqrt(3)*Ub)
IL3a=IL3apu*Sb/(sqrt(3)*Ub)


%pr¹dy fazowe [pu] b
IL1bpu=0
IL2bpu=(-i*sqrt(3))*I1Kbpu
IL3bpu=(i*sqrt(3))*I1Kbpu

%pr¹dy fazowe [kA] b
IL1b=IL1bpu*Sb/(sqrt(3)*Ub)
IL2b=IL2bpu*Sb/(sqrt(3)*Ub)
IL3b=IL3bpu*Sb/(sqrt(3)*Ub)

%Obliczanie pr¹du zwarciowego w linii L1
%przeliczenie na góre trafo

I1gapu=I1Kapu*exp(i*5*30*pi/180)
I2gapu=I2Kapu*exp(-i*5*30*pi/180)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calkowity prad zwarcia a dop³ywajacy linia L1
I1zapu=I1gapu
I2zapu=I2gapu

%pr¹dy fazowe [pu] w lini L1
IL1zapu=I1zapu+I2zapu
IL2zapu=(-0.5-sqrt(3)*j/2)*I1zapu+(-0.5+sqrt(3)*j/2)*I2zapu
IL3zapu=(-0.5+sqrt(3)*j/2)*I1zapu+(-0.5-sqrt(3)*j/2)*I2zapu

%pr¹dy fazowe [kA] w lini L1
IL1za=IL1zapu*Sb/(sqrt(3)*Ub)
IL2za=IL2zapu*Sb/(sqrt(3)*Ub)
IL3za=IL3zapu*Sb/(sqrt(3)*Ub)

%ccccccccccccccccccccc
%Reaktancje zastêpcze i pr¹d w miejscu zwarcia
X1Thpu=(X1T1+X1Q1+X1L1)*(X1T2+X1Q2+X1L2)/(X1T1+X1Q1+X1L1+X1T2+X1Q2+X1L2)
X2Thpu=(X1T1+X1Q1+X1L1)*(X1T2+X1Q2+X1L2)/(X1T1+X1Q1+X1L1+X1T2+X1Q2+X1L2)

%Skladowe symetryczne pr¹du zwarcia
I1Kapu=i*U1pu/(i*(X1Thpu+X2Thpu))
I2Kapu=-i*U1pu/(i*(X1Thpu+X2Thpu))


%pr¹dy fazowe [pu] b
IL1pu=0
IL2pu=(-i*sqrt(3))*I1Kpu
IL3pu=(i*sqrt(3))*I1Kpu

%pr¹dy fazowe [kA] b
IL1=IL1pu*Sb/(sqrt(3)*Ub)
IL2=IL2pu*Sb/(sqrt(3)*Ub)
IL3=IL3pu*Sb/(sqrt(3)*Ub)

%pr¹du zwarciowego w linii L1
I1T1dpu=I1Kpu*((X1T2+X1Q2+X1L2)/(X1T1+X1Q1+X1L1+X1T2+X1Q2+X1L2))
I2T1dpu=-I1Kpu*((X1T2+X1Q2+X1L2)/(X1T1+X1Q1+X1L1+X1T2+X1Q2+X1L2))

%przeniesieniu na stronê górnego napiêcia transformatora T1:
I1T1gpu=I1T1dpu*exp(i*5*30*pi/180)
I2T1gpu=I2T1dpu*exp(-i*5*30*pi/180)
%Sk³adowe symetryczne pr¹du zwarciowego, dop³ywaj¹cego lini¹ L1
I1zpu=I1T1gpu
I2zpu=I2T1gpu

%pr¹dy fazowe [pu] w lini L1
IL1zpu=I1zpu+I2zpu
IL2zpu=(-0.5-sqrt(3)*j/2)*I1zpu+(-0.5+sqrt(3)*j/2)*I2zpu
IL3zpu=(-0.5+sqrt(3)*j/2)*I1zpu+(-0.5-sqrt(3)*j/2)*I2zpu

%pr¹dy fazowe [kA] w lini L1
IL1z=IL1zpu*Sb/(sqrt(3)*Ub)
IL2z=IL2zpu*Sb/(sqrt(3)*Ub)
IL3z=IL3zpu*Sb/(sqrt(3)*Ub)

%dddddddddddddddddd
%reaktacja zstpecza thevenina
X1Thpu=X1T2+((X1Q1+X1L1)*(X1Q2+X1L2)/(X1Q1+X1L1+X1Q2+X1L2))
X2Thpu=X1Thpu


%prad w miejscu zwarcia
I1Kpu=i*U1pu/(i*(X1Thpu+X2Thpu))
I2Kpu=-i*U1pu/(i*(X1Thpu+X2Thpu))

%pr¹dy fazowe [pu] w miejscu zwarcia
IL1pu=0
IL2pu=(-i*sqrt(3))*I1Kpu
IL3pu=(i*sqrt(3))*I1Kpu

%pr¹dy fazowe [kA]
IL1=IL1pu*Sb/(sqrt(3)*Ub)
IL2=IL2pu*Sb/(sqrt(3)*Ub)
IL3=IL3pu*Sb/(sqrt(3)*Ub)

%przenoszenie sk³¹dowych pr¹du na górna stronê trafo
I1gpu=I1Kpu*exp(i*5*30*pi/180)
I2gpu=I2Kpu*exp(-i*5*30*pi/180)

%skó³¹dowa symetrczyna pr¹du zwarcia dop³ywaj¹ca linia L1
I1zpu=I1gpu*((X1Q2+X1L2)/(X1Q1+X1L1+X1Q2+X1L2))
I2zpu=I2gpu*((X2Q2+X2L2)/(X2Q1+X2L1+X2Q2+X2L2))

%(-0.5-sqrt(3)*j/2)

%pr¹dy fazowe [pu] w lini L1
IL1zpu=I1zpu+I2zpu
IL2zpu=(-0.5-sqrt(3)*j/2)*I1zpu+(-0.5+sqrt(3)*j/2)*I2zpu
IL3zpu=(-0.5+sqrt(3)*j/2)*I1zpu+(-0.5-sqrt(3)*j/2)*I2zpu

%pr¹dy fazowe [kA] w lini L1
IL1z=IL1zpu*Sb/(sqrt(3)*Ub)
IL2z=IL2zpu*Sb/(sqrt(3)*Ub)
IL3z=IL3zpu*Sb/(sqrt(3)*Ub)



a=abs(5.9206e-01i)
b=angle(5.9206e-01i)*180/pi

