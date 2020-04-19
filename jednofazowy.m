% Analiza obwodu jednofazowego w stanie ustalonym
% Dane parametry elementów
format compact
R1=10;
R2=20;
R3=30;
R4=40;
C=1e-3;
g=5;
f=50;
omega=2*pi*f;

modE1=40;
argE1=pi/4;

modE2=80;
argE2=pi/4;

modI=10;
argI=pi/2;

% Wartoœci symboliczne elementów
G1=1/R1;
G2=1/R2;
G3=1/R3;
G4=1/R4;

YC=-1i/(omega*C);

I=modI*exp(1i*argI);


E1=modE1*exp(1i*argE1);
E2=modE2*exp(1i*argE2);

% Macierz admitancyjna Y
Y=[G1+G2+YC -G2
 -G2-5 G2+G3];

% Wektor wymuszenia
J=[I
 E2*G3];

% Rozwi¹zanie równania wêz³owego
V=Y\J;

% Pr¹dy ga³êziowe
IR1=I;
IR2=(V(2)-V(1))/R2;
IR3=(V(2)-E2)/R3;
IR4=E2/R4;
IC=I+IR2;
IS=g*V(1);
IE1=IR3;
IE2=-IR3+IR4;
% Napiêcia na elementach
UR1=V(1);
UR2=V(2)-V(1);
UR3=-E2+V(2)+E1;
UR4=E2;
UE1=E1;
UE2=E2;
UI=V(1);
UIS=V(2);
% Moce elementów Ÿród³owych
SI=2*V(1) * conj(I);
SE1=E1 * conj(IE1);
SE2=E2 * conj(IE2);
SIs=UIS * conj(IS);
% Moce pozosta³ych elementów
SR1=V(1) * conj(IR1);
SR2=UR2 * conj(IR2);
SR3=UR3 * conj(IR3);
SR4=UR4 * conj(IR4);
SC=V(1) * conj(IC);
% Bilans pr¹dów wêz³owych
Bil_w1=I+IR2-IC;
Bil_w2=IS-IR2-IR3;
Bil_w3=IR3+IE2-IR4;

% Bilans napiêæ oczkowych
Bil_o1=UR1-V(1);
Bil_o2=-V(1)-UR2+UIS;
Bil_o3=UIS-UR3+E1-UR4;
Bil_o4=E2-UR4;

% Bilans mocy
Bil_moc=-SI+SR1+SR2+SR3+SR4+SC-SIs-SE1-SE2;

% Wykresy wektorowe pr¹dów w wêz³ach
Iw1=[I IR2 -IC];
Iw2=[IS -IR2 -IR3];
Iw3=[IR3 IE2 -IR4];
subplot(3,3,1); compass(Iw1); title('Pr¹dy wêz³a 1')
subplot(3,3,2); compass(Iw2); title('Pr¹dy wêz³a 2')
subplot(3,3,3); compass(Iw3); title('Pr¹dy wêz³a 3')

% Wykresy wektorowe napiêæ oczkowych
Uo1=[UR1 -V(1)];
Uo2=[-V(1) -UR2 UIS];
Uo3=[UIS -UR3 E1 -UR4];
Uo4=[E2 -UR4];
subplot(3,3,4); compass(Uo1); title('Napiêcia oczka 1')
subplot(3,3,5); compass(Uo2); title('Napiêcia oczka 2')
subplot(3,3,6); compass(Uo3); title('Napiêcia oczka 3')
subplot(3,3,7); compass(Uo4); title('Napiêcia oczka 4') 