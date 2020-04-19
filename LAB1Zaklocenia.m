% liczba liter imienia
I=9;
%liczba liter nazwiska
N=9;
%numer na liœcie
nr=14;
%napiêcie bazowe [kV]
Ub=1.05*110;
%moc bazowa [MVA]
Sb=100;
%napiêcia zwarcia transforamtorów [%]
UzT1=11;
UzT2=11;
UzT3=11;
UzT4HM=11;
UzT4ML=6;
UzT4HL=18;
%moce znamionowe transformatorów [MVA]
SnT1=50;
SnT2=25;
SnT3=25;
SnT4=25;
%reaktancje podprzejœciowe generatorów i silnika [%]
XdG1=14.6;
XdG2=12.8;
XdG3=12.8;
XdG4=12.8;
XdM=18;
%moc znamionowa generatorów i silnika [MVA]
SnG1=55;
SnG2=25;
SnG3=25;
SnG4=25;
SnM=15;
% D³ugoœcci linii [km]
w1=(80+5*nr)*(I/(I+N))
w2=(80+5*nr)*(N/(I+N))
%Reaktancja jednostkowa linii [Ohm/km]
xl=0.4;
%reaktancja bazowa [Ohm]
Xb=Ub^2/Sb;
% Reaktancje zgodne linii [pu]
X1L1=(w1*xl)/Xb
X1L2=(w2*xl)/Xb
%reaktancje zgodne generatorów [pu]
X1G1=(XdG1/100)*(Sb/SnG1)
X1G2=(XdG2/100)*(Sb/SnG2)
X1G3=(XdG3/100)*(Sb/SnG3)
X1G4=(XdG4/100)*(Sb/SnG4)
%reaktancja zgodna silnika [pu]
X1M=(XdM/100)*(Sb/SnM)
%reaktancje zgodne transformatorów [pu]
X1T1=(UzT1/100)*(Sb/SnT1)
X1T2=(UzT2/100)*(Sb/SnT2)
X1T3=(UzT3/100)*(Sb/SnT3)
X1T4HM=(UzT4HM/100)*(Sb/SnT4)
X1T4ML=(UzT4ML/100)*(Sb/SnT4)
X1T4HL=(UzT4HL/100)*(Sb/SnT4)
%przeliczone reaktancje transformatora 3uzwojeniowego na uk³ad gwiazdy [pu]
X1T4H=0.5*(X1T4HM+X1T4HL-X1T4ML)
X1T4M=0.5*(X1T4HM+X1T4ML-X1T4HL)
X1T4L=0.5*(X1T4HL+X1T4ML-X1T4HM)
%po 1. uproszczeniu schematu [pu]
X1G1_T1=X1G1+X1T1
X1G2_T2=X1G2+X1T2
X1G3_T3=X1G3+X1T3
X1T4M_M=X1T4M+X1M
X1T4L_G4=X1T4L+X1G4
%po 2. uproszczeniu
%reaktancja na prawo od szyn B [pu]
X1BNp=X1T4H+(X1T4L_G4*X1T4M_M)/(X1T4L_G4+X1T4M_M)
%reaktancja na dó³ od szyn C [pu]
X1CNd=(X1G2_T2*X1G3_T3)/(X1G2_T2+X1G3_T3)
%reaktancja na lewo od miejsca zwarcia [pu]
X1BNl=(X1CNd*(X1L1+X1G1_T1))/(X1CNd+X1L1+X1G1_T1)+X1L2
%reaktacja zastêpcza Thevenina widziana z miejsca zwarcia [pu]
X1Th=(X1BNp*X1BNl)/(X1BNp+X1BNl)
%napiêcie Ÿród³a zastepczego [pu]
U10=1.05;
%maksymalny pr¹d zwarcia (pocz¹tkowy)tylko sk³adowa zgodna [pu]
I1K=U10/X1Th
%pr¹d doplywajacy do szyn B z lewej strony [pu]
I1BNl=I1K*X1BNp/(X1BNl+X1BNp)
%pr¹d w punkcie prekaŸnikowym, sk³adowa zgodna [pu]
I1P=I1BNl*X1CNd/(X1L1+X1G1_T1+X1CNd)
%sk³adowa zgodna napiêcia w punkcie P [pu]
U1P=j*U10-j*X1G1_T1*I1P
%wartoœci fazowe napiêcia w punkcie P [pu]
UL1Ppu=U1P;
UL2Ppu=(-0.5-sqrt(3)*j/2)*U1P;
UL3Ppu=(-0.5+sqrt(3)*j/2)*U1P;
%wartoœci fazowe napiêcia w punkcie P [kV]
UL1P=UL1Ppu*Ub/sqrt(3)
UL2P=UL2Ppu*Ub/sqrt(3)
UL3P=UL3Ppu*Ub/sqrt(3)
%rezystancja przejœcia [Ohm]
Rp=2;
%rezystancja przejœcia [pu]
Rppu=Rp*Sb/Ub^2;
%Sk³adowa zgodna pr¹du [pu]
I1pu=(j*U10)/(j*X1Th+Rppu)
%pr¹dy fazowe [pu]
IL1pu=I1pu
IL2pu=(-0.5-sqrt(3)*j/2)*I1pu
IL3pu=(-0.5+sqrt(3)*j/2)*I1pu
%pr¹dy fazowe [kA]
IL1=IL1pu*Sb/(sqrt(3)*Ub)
IL2=IL2pu*Sb/(sqrt(3)*Ub)
IL3=IL3pu*Sb/(sqrt(3)*Ub)
%sk³adowa zgodna napiêcia w miejscu zwarcia [pu]
U1pu=I1pu*Rppu
%OBLICZENIA W JEDNOSTKACH MIANOWANYCH
%napiêcia znamionowe generatorów i silnika[kV]
UnG1=10.5;
UnG2=6.3;
UnG3=6.3;
UnG4=6.3;
UnM=15.75;
%reakatancje generatorów i silnika po stronie ni¿szego napiêcia [Ohm]
X1G1m=(XdG1/100)*(UnG1^2/SnG1)
X1G2m=(XdG2/100)*(UnG2^2/SnG2)
X1G3m=(XdG3/100)*(UnG3^2/SnG3)
X1G4m=(XdG4/100)*(UnG4^2/SnG4)
X1Mm=(XdM/100)*(UnM^2/SnM)
%napiêcia znamionowe transformatorów [kV]
UnT1=115.5;
UnT2=115.5;
UnT3=115.5;
%reaktancje transformatrów dwuuzwojeniowych [Ohm]
X1T1m=(UzT1/100)*(UnT1^2/SnT1)
X1T2m=(UzT2/100)*(UnT2^2/SnT2)
X1T3m=(UzT3/100)*(UnT3^2/SnT3)
%rektancje generatorów i silnika przeliczone na stronê 110kV [Ohm]
X1G1H=X1G1m*(115.5/10.5)^2
X1G2H=X1G2m*(115.5/6.3)^2
X1G3H=X1G3m*(115.5/6.3)^2
X1G4H=X1G4m*(115.5/6.3)^2
X1MH=X1Mm*(115.5/15.75)^2
%reaktancje linii [Ohm]
X1L1m=w1*xl
X1L2m=w2*xl
%napiêcia zwarcia T4 po przejœiu do gwiazdy [kV]
UzT4H=(UzT4HM+UzT4HL-UzT4ML)/2
UzT4M=(UzT4HM-UzT4HL+UzT4ML)/2
UzT4L=(-UzT4HM+UzT4HL+UzT4ML)/2
%reaktancje T4 na 110kV [Ohm]
X1T4Hm=(UzT4H/100)*(115.5^2/SnT4)
X1T4Mm=(UzT4M/100)*(115.5^2/SnT4)
X1T4Lm=(UzT4L/100)*(115.5^2/SnT4)
%po 1. uproszczeniu schematu [Ohm]
X1G1_T1m=X1G1H+X1T1m
X1G2_T2m=X1G2H+X1T2m
X1G3_T3m=X1G3H+X1T3m
X1T4M_Mm=X1T4Mm+X1MH
X1T4L_G4m=X1T4Lm+X1G4H
%po 2. uproszczeniu
%reaktancja na prawo od szyn B [Ohm]
X1BNpm=X1T4Hm+(X1T4L_G4m*X1T4M_Mm)/(X1T4L_G4m+X1T4M_Mm)
%reaktancja na dó³ od szyn C [Ohm]
X1CNdm=(X1G2_T2m*X1G3_T3m)/(X1G2_T2m+X1G3_T3m)
%reaktancja na lewo od miejsca zwarcia [Ohm]
X1BNlm=(X1CNdm*(X1L1m+X1G1_T1m))/(X1CNdm+X1L1m+X1G1_T1m)+X1L2m
%reaktacja zastêpcza Thevenina widziana z miejsca zwarcia [Ohm]
X1Thm=(X1BNpm*X1BNlm)/(X1BNpm+X1BNlm)
%sk³adowa zgodna pr¹du zwarcia [kA]
I1m=(1.1*110)/(X1Thm*sqrt(3))
%pr¹dy zwarcia w poszczegolnych fazach [kA]
IL1m=I1m 
IL2m=(-0.5-sqrt(3)*j/2)*I1m
IL2m=(-0.5+sqrt(3)*j/2)*I1m


















