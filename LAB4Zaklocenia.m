clear
clc
format short
% liczba liter imienia
I=9;
%liczba liter nazwiska
N=9;
%numer na liœcie
nr=14;
%napiêcie bazowe [kV]
Ub110=1.05*110;
Ub20=1.05*20;
%napiêcie Ÿród³a zastepczego [pu]
U1pu=1.05;
%moc bazowa [MVA]
Sb=100;
%napiêcia zwarcia transforamtorów [%]
UzT1=10;
UzT2=10;
UzT3=10;
UzT4=10.5;
UzTS2211=10;
UzTS1110=20;
UzTS2210=30;
%moce znamionowe transformatorów [MVA]
SnT1=160;
SnT2=160;
SnT3=160;
SnT4=40;
SnTS=160;
%reaktancje podprzejœciowe generatorów[%]
XdG1=12;
XdG2=12;
XdG3=12;
%moc znamionowa generatorów [MVA]
SnG1=150;
SnG2=150;
SnG3=150;
%moc zwarciowa systemu
SkQ1=1000
SkQ2=3000
%napiêcie znamionowe generatórów [kV]
UnG1=10.5;
UnG2=10.5;
UnG3=10.5;
% D³ugoœcci linii [km]
w1=(50+5*nr)*(I/(I+N))
w2=(50+5*nr)*(N/(I+N))
%Reaktancja jednostkowa linii [Ohm/km]
xl1a=0.4;
xl1b=0.4;
%reaktancja bazowa [Ohm]
XbL1=Ub110^2/Sb;
%reaktancje elementów dla sk³adowych zgodnej i przeciwnej [pu]
X1L1a=(w1*xl1a)/XbL1
X1L1b=(w2*xl1b)/XbL1
X1T1=(UzT1/100)*(Sb/SnT1)
X1T2=(UzT2/100)*(Sb/SnT2)
X1T3=(UzT3/100)*(Sb/SnT3)
X1T4=(UzT4/100)*(Sb/SnT4)
X2T1=(UzT1/100)*(Sb/SnT1)
X2T2=(UzT2/100)*(Sb/SnT2)
X2T3=(UzT3/100)*(Sb/SnT3)
X2T4=(UzT4/100)*(Sb/SnT4)
X1Q1=Sb/SkQ1
X1Q2=Sb/SkQ2
X2Q1=X1Q1;
X2Q2=X1Q2;
X1G1=(XdG1/100)*(Sb/SnG1)
X1G2=(XdG2/100)*(Sb/SnG2);
X1G3=(XdG3/100)*(Sb/SnG3);
X2G1=X1G1;
X2G2=X1G2;
X2G3=X1G3;
%reaktancje dla transformatora TS [pu]
X1TS2211=(UzTS2211/100)*(Sb/SnTS)
X2TS2211=X1TS2211
X1TS1110=(UzTS1110/100)*(Sb/SnTS)
X2TS1110=X1TS1110
X1TS2210=(UzTS2210/100)*(Sb/SnTS)
X2TS2210=X1TS2210
%przeliczone reaktancje transformatora 3uzwojeniowego TS na uk³ad gwiazdy [pu]
X1TS22=0.5*(X1TS2210+X1TS2211-X1TS1110)
X2TS22=X1TS22
X1TS11=0.5*(X1TS2211+X1TS1110-X1TS2210)
X2TS11=X1TS11
X1TS10=0.5*(X1TS2210+X1TS1110-X1TS2211)
X2TS10=X1TS10
%obliczenie reaktancji dla sk³adowej zerowej [pu]
X0L1a=X1L1a*(2.8)
X0L1b=X1L1b*(2.8)
X0T1=X1T1*(0.85)
X0T2=X1T2*(0.85);
X0T3=X1T3*(0.85);
X0T4=X1T4*(0.85)
X0TS22=X1TS22*(1.0);
X0TS11=X1TS11*(1.0);
X0TS10=X1TS10*(1.0);
X0Q1=X1Q1*1.5
X0Q2=X1Q2*1.5
% a) PR¥D W MIEJSCU ZWARCIA
%reaktancja zastêpcza Thevina 
    %dla sk³adowych zgodnej i przeciwnej [pu]
    %wprowadzam Xstrl i Xstrp jako reaktancje wypadkowe strony lewej i
    %prawej schematu (na lewo i prawo od zwarcia)
Xstrl=X1L1a+((X1G1+X1T1)*(X1G2+X1T2)*(X1TS11+X1TS22+X1Q2))/((X1G1+X1T1)*(X1TS11+X1TS22+X1Q2)+(X1G1+X1T1)*(X1G2+X1T2)+(X1TS11+X1TS22+X1Q2)*(X1G2+X1T2))
Xstrp=X1L1b+(X1Q1*(X1T3+X1G3))/(X1Q1+X1T3+X1G3)
X1Thpu=(Xstrl*Xstrp)/(Xstrl+Xstrp)
X2Thpu=X1Thpu
    %dla s³adowej zerowej [pu]
% na lewo od miejsca zwarcia
X0lThpu=(((X0Q2+X0TS22)*X0TS10)/(X0Q2+X0TS22+X0TS10)+X0TS11)*X0T1/((((X0Q2+X0TS22)*X0TS10)/(X0Q2+X0TS22+X0TS10)+X0TS11)+X0T1)+X0L1a
%na prawo od miejsca zwarcia
X0pThpu=(X0Q1*X0T3*X0T4)/((X0Q1*X0T3)+(X0Q1*X0T4)+(X0T3*X0T4))+X0L1b
%ca³kowita
X0Thpu=(X0lThpu*X0pThpu)/(X0lThpu+X0pThpu)
%pr¹d w miejscu zwarcia [pu]
I1Kpu=U1pu/(X1Thpu+X2Thpu+X0Thpu)
I2Kpu=I1Kpu
I0Kpu=I1Kpu
%wartoœci fazowe pr¹du zwarcia [pu]
IL1pu=3*I1Kpu
IL2pu=0
IL3pu=0
%wartoœci fazowe pr¹du zwarcia [kA]
IL1=3*I1Kpu*(Sb/(sqrt(3)*Ub110))
IL2=0
IL3=0
% b)PR¥DY ZWARCIOWE PO OBU STRONACH TRANSFORMATORA T1 i T2
%pr¹d zwarciowy zgodny i przeciwny dop³ywaj¹cy lini¹ L1a po lewej stronie schematu
I1L1pu=I1Kpu*Xstrp/(Xstrp+Xstrl)
%to samo ale zerowy
I0L1pu=I0Kpu*X0pThpu/(X0lThpu+X0pThpu)

%reaktancje ga³êzi
XT1=X1G1+X1T1
XT2=X1G2+X1T2
XTS=X1TS11+X1TS22+X1Q2

%po³¹czone równolegle ga³êzie T2 i TS oraz T1 i TS
XTST2=XT2*XTS/(XT2+XTS)
XTST1=XT1*XTS/(XT1+XTS)

%sk³adowa zgodna i przeciwna pr¹du dop³ywaj¹ce do linii L1a z generatora G1 przez trafo T1,
%po stronie górnego napiêcia [pu]
licznikT1=XTST2
mianownikT1=XTST2+XT1
I1T1gpu=I1L1pu*licznikT1/mianownikT1
I2T1gpu=I1T1gpu
%TTTTTTTTTTTTTTT11111111111111
%sk³adowa zerowa pr¹du po stronie gotnej T1
licznikT10=((X0Q2+X0TS22)*X0TS10)/((X0Q2+X0TS22+X0TS10)+X0TS11)
mianownikT10=licznikT10+X0T1
I0T1gpu=I0L1pu*licznikT10/mianownikT10
%GGGGGGGÓÓÓÓÓÓRRRRRRRRAAAAAAAAAAA
%wartoœci fazowe pu pradu po stronie górnej T1
IL1T1gpu=I0T1gpu+I1T1gpu+I2T1gpu
IL2T1gpu=I0T1gpu+I1T1gpu*exp(-i*120*pi/180)+I2T1gpu*exp(i*120*pi/180)
IL3T1gpu=I0T1gpu+I1T1gpu*exp(i*120*pi/180)+I2T1gpu*exp(-i*120*pi/180)

%wartoœci mianowane pr¹du po stronie górnej T1
IL1T1g=IL1T1gpu*(100/(sqrt(3)*110*1.05))
IL2T1g=IL2T1gpu*(100/(sqrt(3)*110*1.05))
IL3T1g=IL3T1gpu*(100/(sqrt(3)*110*1.05))
%DDDDDDDDDDDóóóóóóóóóóóó£££££££££££££££££
%sk³adowa zgodna i przeciwna pr¹du wyp³ywaj¹cgo z generatora G1; pr¹d po
%stronie dolnego napiêcia transformatora [pu]
I1G1pu=I1T1gpu*exp(-i*5*30*pi/180)
I2G1pu=I2T1gpu*exp(i*5*30*pi/180)
%sk³adowa zerowa [pu]
I0G1pu=0


%wartoœci fazowe pr¹du zwarciowego wyp³ywaj¹cego z generatora
IL1G1pu=I1G1pu+I2G1pu
IL2G1pu=I1G1pu*exp(-i*120*pi/180)+I2G1pu*exp(i*120*pi/180)
IL3G1pu=I1G1pu*exp(i*120*pi/180)+I2G1pu*exp(-i*120*pi/180)
%wartoœci mianowane pr¹du zwarciowego wyp³ywaj¹cego z generatora
IL1G1=IL1G1pu*(100/(sqrt(3)*10*1.05))
IL2G1=IL2G1pu*(100/(sqrt(3)*10*1.05))
IL3G1=IL3G1pu*(100/(sqrt(3)*10*1.05))



%TTTTTTTTTTTTTTTTT2222222222222222222
%sk³adowa zgodna i przeciwna pr¹du dop³ywaj¹ce do linii L1a z generatora G2 przez trafo T2,
%po stronie górnego napiêcia [pu]
licznikT2=XTST1
mianownikT2=XTST1+XT2
I1T2gpu=I1L1pu*licznikT2/mianownikT2
I2T2gpu=I1T2gpu
%sk³adowa zerowa pr¹du po stronie gornej T2
I0T2gpu=0
%GGGGGGGGóóóóóóóóóóóRRRRRRRRAAAAAAAA
%wartoœci fazowe pu pradu po stronie górnej T2

IL1T2gpu=I0T2gpu+I1T2gpu+I2T2gpu
IL2T2gpu=I0T2gpu+I1T2gpu*exp(-i*120*pi/180)+I2T2gpu*exp(i*120*pi/180)
IL3T2gpu=I0T2gpu+I1T2gpu*exp(i*120*pi/180)+I2T2gpu*exp(-i*120*pi/180)

%wartoœci mianowane pr¹du po stronie górnej T2
IL1T2g=IL1T2gpu*(100/(sqrt(3)*110*1.05))
IL2T2g=IL2T2gpu*(100/(sqrt(3)*110*1.05))
IL3T2g=IL3T2gpu*(100/(sqrt(3)*110*1.05))

%DDDDDDDóóóóóóó³³³³³³³³³³
%sk³adowa zgodna i przeciwna pr¹du wyp³ywaj¹cgo z generatora G2; pr¹d po
%stronie dolnego napiêcia transformatora [pu]
I1G2pu=I1T2gpu*exp(-i*5*30*pi/180)
I2G2pu=I2T2gpu*exp(i*5*30*pi/180)
%sk³adowa zerowa [pu]
I0G2pu=0

%wartoœci fazowe pr¹du zwarciowego wyp³ywaj¹cego z generatora
IL1G2pu=I1G2pu+I2G2pu
IL2G2pu=I1G2pu*exp(-i*120*pi/180)+I2G2pu*exp(i*120*pi/180)
IL3G2pu=I1G2pu*exp(i*120*pi/180)+I2G2pu*exp(-i*120*pi/180)
%wartoœci mianowane pr¹du zwarciowego wyp³ywaj¹cego z generatora
IL1G2=IL1G2pu*(100/(sqrt(3)*10*1.05))
IL2G2=IL2G2pu*(100/(sqrt(3)*10*1.05))
IL3G2=IL3G2pu*(100/(sqrt(3)*10*1.05))

% c) PR¥D ZWARCIOWY PO STRONIE GÓRNEGO NAPIÊCIA TRANSFORMATORA T4
%sk³adowa zgodna i przeciwna pr¹du dop³ywaj¹ce do linii L1b z generatora  przez trafo T1,
%po stronie górnego napiêcia [pu]
I1T4gpu=0
I2T4gpu=0
%prad skladowej zerowej dop³ywaj¹cy linia L1b
I0L1bpu=I0Kpu*X0lThpu/(X0lThpu+X0pThpu)

licznikT40=(X0Q1*X0T3)/(X0Q1+X0T3)
mianownikT40=licznikT40+X0T4
I0T4gpu=I0L1bpu*licznikT40/mianownikT40

%wartoœci fazowe pu pradu po stronie górnej T4

IL1T4gpu=I0T4gpu+I1T4gpu+I2T4gpu
IL2T4gpu=I0T4gpu+I1T4gpu*exp(-i*120*pi/180)+I2T4gpu*exp(i*120*pi/180)
IL3T4gpu=I0T4gpu+I1T4gpu*exp(i*120*pi/180)+I2T4gpu*exp(-i*120*pi/180)

%wartoœci mianowane pr¹du po stronie górnej T4
IL1T4g=IL1T4gpu*(100/(sqrt(3)*110*1.05))
IL2T4g=IL2T4gpu*(100/(sqrt(3)*110*1.05))
IL3T4g=IL3T4gpu*(100/(sqrt(3)*110*1.05))
