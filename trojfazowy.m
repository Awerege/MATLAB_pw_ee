%Definicja elementów
Rab=5; Lab=0.6; Cab=4*10^-12;
Rbc=15; Lbc=0.3; Cbc=2*10^-12;
Rca=10; Lca=0.8; Cca=1*10^-12;
k=0.599; M=k*sqrt(Lca*Lbc);
Rp=5; Lp=0.01; Cp=5*10^-6;
Ea=[50*sqrt(2)*exp(i*0)
 25*sqrt(2)*exp(i*0)
 10*sqrt(2)*exp(i*0)
 5*sqrt(2)*exp(i*0)];
Eb=[50*sqrt(2)*exp(i*(-2/3*pi))
 25*sqrt(2)*exp(i*0)
 10*sqrt(2)*exp(i*(2/3*pi))
 5*sqrt(2)*exp(i*(-2/3*pi))];
Ec=[50*sqrt(2)*exp(i*2/3*pi)
 25*sqrt(2)*exp(i*0)
 10*sqrt(2)*exp(-i*2/3*pi)
 5*sqrt(2)*exp(i*2/3*pi)];
w = [50*2*pi
 3*50*2*pi
 5*50*2*pi
 7*50*2*pi];
%Inicjacja wartoœci
Ias=0; Ibs=0; Ics=0; Iabs=0; Ibcs=0; Icas=0; Ulas=0; Ulbs=0; Ulcs=0; Uabs=0;
Ubcs=0; Ucas=0; Eas=0;
Ebs=0; Ecs=0; Slas=0; Slbs=0; Slcs=0; SEas=0; SEbs=0; SEcs=0; SRabs=0;
SLabs=0; SCabs=0; SRbcs=0; SLbcMs=0;SCbcs=0;
SRcas=0; SLcaMs=0; SCcas=0; wh0=1:4; wh1=1:4; wh2=1:4; wh3=1:4; oh1=1:4;
oh2=1:4; oh3=1:4;
Zla=1:4; Zlb=1:4; Zlc=1:4; Yla=1:4; Ylb=1:4; Ylc=1:4; Yab=1:4; Ybc=1:4;
Yca=1:4; Uab=1:4; Ubc=1:4; Uca=1:4;
Iab=1:4; Ibc=1:4; Ica=1:4; Ula=1:4; Ulb=1:4; Ulc=1:4; Ia=1:4; Ib=1:4; Ic=1:4;
Sla=1:4; Slb=1:4; Slc=1:4;
SEa=1:4; SEb=1:4; SEc=1:4; SRab=1:4; SLab=1:4; SCab=1:4; SRbc=1:4; SLbcM=1:4;
SCbc=1:4; SRca=1:4; SLcaM=1:4; SCca=1:4;
for i=1:4
%Impedancie przewodów
Zla(i)=((Rp+i*w(i)*Lp)*(-i/(w(i)*Cp)))/(Rp+i*w(i)*Lp-i/(w(i)*Cp));
Zlb(i)=((Rp+i*w(i)*Lp)*(-i/(w(i)*Cp)))/(Rp+i*w(i)*Lp-i/(w(i)*Cp));
Zlc(i)=((Rp+i*w(i)*Lp+i*w(i)*M)*(-i/(w(i)*Cp)))/(Rp+i*w(i)*Lp+i*w(i)*M*i/(w(i)*Cp));
%Admitancje przewodów
Yla(i)=1/Zla(i);
Ylb(i)=1/Zlb(i);
Ylc(i)=1/Zlc(i);
%Admitancje ga³êzi
Yab(i)=1/(Rab+i*w(i)*Lab-i/(w(i)*Cab));
Ybc(i)=1/(Rbc+i*w(i)*Lbc-i*w(i)*M-i/(w(i)*Cbc));
Yca(i)=1/(Rca+i*w(i)*Lca-i*w(i)*M-i/(w(i)*Cca));
%Macierz admitancyjna
Y = [Yab(i)+Yla(i)+Yca(i), -Yab(i), -Yca(i)
 -Yab(i), Ylb(i)+Yab(i)+Ybc(i), -Ybc(i)
 -Yca(i), -Ybc(i), Ylc(i)+Ybc(i)+Yca(i)];
%Macierz wymuszeñ
I = [Ea(i)*Yla(i)
 Eb(i)*Ylb(i)
 Ec(i)*Ylc(i)];
%Rozwi¹zanie równania wêz³owego
Vp=Y\I;
for l=1:3
 V(l,i)=Vp(l);
end
%Napiêcia ga³êziowe
Uab(i)=V(1,i)-V(2,i);
Ubc(i)=V(2,i)-V(3,i);
Uca(i)=V(1,i)-V(3,i);
%Pr¹dy ga³êziowe
Iab(i)=Uab(i)*Yab(i);
Ibc(i)=Ubc(i)*Ybc(i);
Ica(i)=Uca(i)*Yca(i);
%Napiêcia przewodowe
Ula(i)=-V(1,i)+Ea(i);
Ulb(i)=-V(2,i)+Eb(i);
Ulc(i)=-V(3,i)+Ec(i);
%Pr¹dy przewodowe
Ia(i)=Ula(i)*Yla(i);
Ib(i)=Ulb(i)*Ylb(i);
Ic(i)=Ulc(i)*Ylc(i);
%Sumy pr¹dów harmonicznych
Ias=Ias+Ia(i);
Ibs=Ibs+Ib(i);
Ics=Ics+Ic(i);
Iabs=Iabs+Iab(i);
Ibcs=Ibcs+Ibc(i); Icas=Icas+Ica(i);
%Sumy napiêæ harmonicznych
Ulas=Ulas+Ula(i);
Ulbs=Ulbs+Ulb(i);
Ulcs=Ulcs+Ulc(i);
Uabs=Uabs+Uab(i);
Ubcs=Ubcs+Ubc(i);
Ucas=Ucas+Uca(i);
Eas=Eas+Ea(i);
Ebs=Ebs+Eb(i);
Ecs=Ecs+Ec(i);
%Moce na przewodach fazowych
Sla(i)=Ula(i)*conj(Ia(i));
Slb(i)=Ulb(i)*conj(Ib(i));
Slc(i)=Ulc(i)*conj(Ic(i));
%Moce na Ÿród³ach
SEa(i)=Ea(i)*conj(Ia(i));
SEb(i)=Eb(i)*conj(Ib(i));
SEc(i)=Ec(i)*conj(Ic(i));
%Moce na elementach
SRab(i)=Iab(i)*Rab*conj(Iab(i));
SLab(i)=Iab(i)*Lab*conj(Iab(i));
SCab(i)=Iab(i)*(-i/(w(i)*Cab))*conj(Iab(i));
SRbc(i)=Ibc(i)*Rbc*conj(Ibc(i));
SLbcM(i)=Ibc(i)*(i*w(i)*(Lbc-M))*conj(Ibc(i));
SCbc(i)=Ibc(i)*Cbc*conj(Ibc(i));
SRca(i)=Ica(i)*Rca*conj(Ica(i));
SLcaM(i)=Ica(i)*(i*w(i)*(Lca-M))*conj(Ica(i));
SCca(i)=Ica(i)*Cca*conj(Ica(i));
%Sumy mocy
Slas=Slas+Sla(i);
Slbs=Slbs+Slb(i);
Slcs=Slcs+Slc(i);
SEas=SEas+SEa(i);
SEbs=SEbs+SEb(i);
SEcs=SEcs+SEc(i);
SRabs=SRabs+SRab(i);
SLabs=SLabs+SLab(i);
SCabs=SCabs+SCab(i);
SRbcs=SRbcs+SRbc(i);
SLbcMs=SLbcMs+SLbcM(i);
SCbcs=SCbcs+SCbc(i);
SRcas=SRcas+SRca(i);
SLcaMs=SLcaMs+SLcaM(i);
SCcas=SCcas+SCca(i);
end
%Bilans pr¹dów w wêz³ach
w0=-Ias-Ibs-Ics;
w1=Ias-Iabs-Icas;
w2=Ibs+Iabs-Ibcs;
w3=Ics+Ibcs+Icas;
ws0=[-Ias-Ibs-Ics];
ws1=[Ias-Iabs-Icas];
ws2=[Ibs Iabs -Ibcs];
ws3=[Ics Ibcs Icas];
%Bilans napiêæ w oczkach
o1=Eas-Ulas-Uabs+Ulbs-Ebs;
o2=Ebs-Ulbs-Ubcs+Ulcs-Ecs;
o3=Ucas-Ubcs-Uabs;
os1=[Eas -Ulas -Uabs Ulbs -Ebs];
os2=[Ebs -Ulbs -Ubcs Ulcs -Ecs];
os3=[Ucas -Ubcs -Uabs];
%Bilans mocy
bilans_mocy=Slas+Slbs+Slcs-SEas-SEbs-SEcs+SRabs+SLabs+SCabs+SRbcs+SLbcMs+SCbcs+SRcas+SLcaMs+SCcas;
%Bilanse pr¹dów w wêz³ach dla ka¿dej harmonicznej
wh01=[-Ia(1) -Ib(1) -Ic(1)];
wh11=[Ia(1) -Iab(1) -Ica(1)];
wh21=[Ib(1) Iab(1) -Ibc(1)];
wh31=[Ic(1) Ibc(1) Ica(1)];
wh02=[-Ia(2) -Ib(2) -Ic(2)];
wh12=[Ia(2) -Iab(2) -Ica(2)];
wh22=[Ib(2) Iab(2) -Ibc(2)];
wh32=[Ic(2) Ibc(2) Ica(2)];
wh03=[-Ia(3) -Ib(3) -Ic(3)];
wh13=[Ia(3) -Iab(3) -Ica(3)];
wh23=[Ib(3) Iab(3) -Ibc(3)];
wh33=[Ic(3) Ibc(3) Ica(3)];
wh04=[-Ia(4) -Ib(4) -Ic(4)];
wh14=[Ia(4) -Iab(4) -Ica(4)];
wh24=[Ib(4) Iab(4) -Ibc(4)];
wh34=[Ic(4) Ibc(4) Ica(4)];
%Bilans napiêæ w wêz³ach dla ka¿dej harmonicznej
oh11=[Ea(1) -Ula(1) -Uab(1) Ulb(1) -Eb(1)];
oh21=[Eb(1) -Ulb(1) -Ubc(1) Ulc(1) -Ec(1)];
oh31=[Uca(1) -Ubc(1) -Uab(1)];
oh12=[Ea(2) -Ula(2) -Uab(2) Ulb(2) -Eb(2)];
oh22=[Eb(2) -Ulb(2) -Ubc(2) Ulc(2) -Ec(2)];
oh32=[Uca(2) -Ubc(2) -Uab(2)];
oh13=[Ea(3) -Ula(3) -Uab(3) Ulb(3) -Eb(3)];
oh23=[Eb(3) -Ulb(3) -Ubc(3) Ulc(3) -Ec(3)];
oh33=[Uca(3) -Ubc(3) -Uab(3)];
oh14=[Ea(4) -Ula(4) -Uab(4) Ulb(4) -Eb(4)];
oh24=[Eb(4) -Ulb(4) -Ubc(4) Ulc(4) -Ec(4)];
oh34=[Uca(4) -Ubc(4) -Uab(4)];
%Wykresy wektorowe harmonicznych

figure(1)
subplot(2,2,1), compass(wh01), title(strvcat('Prady wezla 0', ' dla 1.harmonicznei'))
subplot(2,2,2), compass(wh11), title(strvcat('Prady wezla 1', ' dla 1.harmonicznei'))
subplot(2,2,3), compass(wh21), title(strvcat('Prady wezla 2', ' dla 1.harmonicznei'))
subplot(2,2,4), compass(wh31), title(strvcat('Prady wezla 3', ' dla 1.harmonicznei'))
figure(2)
subplot(2,2,1), compass(wh02), title(strvcat('Prady wezla 0', ' dla 3.harmonicznei'))
subplot(2,2,2), compass(wh12), title(strvcat('Prady wezla 1', ' dla 3.harmonicznei'))
subplot(2,2,3), compass(wh22), title(strvcat('Prady wezla 2', ' dla 3.harmonicznei'))
subplot(2,2,4), compass(wh32), title(strvcat('Prady wezla 3', ' dla 3.harmonicznei'))
figure (3)
subplot(2,2,1), compass(wh03), title(strvcat('Prady wezla 0', ' dla 5.harmonicznei'))
subplot(2,2,2), compass(wh13), title(strvcat('Prady wezla 1', ' dla 5.harmonicznei'))
subplot(2,2,3), compass(wh23), title(strvcat('Prady wezla 2', ' dla 5.harmonicznei'))
subplot(2,2,4), compass(wh33), title(strvcat('Prady wezla 3', ' dla 5.harmonicznei'))
figure (4)
subplot(2,2,1), compass(wh04), title(strvcat('Prady wezla 0', ' dla 7harmonicznei'))
subplot(2,2,2), compass(wh14), title(strvcat('Prady wezla 1', ' dla 7.harmonicznei'))
subplot(2,2,3), compass(wh24), title(strvcat('Prady wezla 2', ' dla 7.harmonicznei'))
subplot(2,2,4), compass(wh34), title(strvcat('Prady wezla 3', ' dla 7.harmonicznei'))
figure(5)
subplot(2,2,1), compass(oh11), title(strvcat('Napiecia oczka 1', ' dla 1.harmonicznei'))
subplot(2,2,2), compass(oh21), title(strvcat('Napiecia oczka 2', ' dla 1.harmonicznei'))
subplot(2,2,3), compass(oh31), title(strvcat('Napiecia oczka 3', ' dla 1.harmonicznei'))
figure (6)
subplot(2,2,1), compass(oh12), title(strvcat('Napiecia oczka 1', ' dla 3.harmonicznei'))
subplot(2,2,2), compass(oh22), title(strvcat('Napiecia oczka 2', ' dla 3.harmonicznei'))
subplot(2,2,3), compass(oh32), title(strvcat('Napiecia oczka 3', ' dla 3.harmonicznei'))
figure (7)
subplot(2,2,1), compass(oh13), title(strvcat('Napiecia oczka 1', ' dla 5.harmonicznei'))
subplot(2,2,2), compass(oh23), title(strvcat('Napiecia oczka 2', ' dla 5.harmonicznei'))
subplot(2,2,3), compass(oh33), title(strvcat('Napiecia oczka 3', ' dla 5.harmonicznei'))
figure(8)
subplot(2,2,1), compass(oh14), title(strvcat('Napiecia oczka 1', ' dla 7.harmonicznei'))
subplot(2,2,2), compass(oh24), title(strvcat('Napiecia oczka 2', ' dla 7.harmonicznei'))
subplot(2,2,3), compass(oh34), title(strvcat('Napiecia oczka 3', ' dla 7.harmonicznei'))

%Wykresy wektorowe sum harmonicznych
figure(9)
subplot(3,3,1), compass(ws0), title('Prady wezla 0')
subplot(3,3,2), compass(ws1), title('Prady wezla 1')
subplot(3,3,3), compass(ws2), title('Prady wezla 2')
subplot(3,3,4), compass(ws3), title('Prady wezla 3')
subplot(3,3,5), compass(os1), title('Napiecia oczka 1')
subplot(3,3,6), compass(os2), title('Napiecia oczka 2')
subplot(3,3,7), compass(os3), title('Napiecia oczka 3')

omega=2*pi*50;
for k=1:40
t=k*.001;
Ea=50*exp(j*(omega*t));
Eb=50*exp(j*(omega*t-2*pi/3));
Ec=50*exp(j*(omega*t+2*pi/3));
E=[ Ea Eb Ec]; axis([-300,300,-300,300]);
compass(E)
pause(0.2)
end


omega=2*pi*50;
for k=1:40
t=k*.001;
Ea=50*exp(j*(omega*t))+25*exp(i*omega*t)+10*exp(i*(omega*t))+5*exp(i*(omega*t));
Eb=50*exp(j*(omega*t-2*pi/3))+25*exp(i*omega*t)+10*exp(i*(omega*t-2*pi/3))+5*exp(i*(omega*t-2*pi/3));
Ec=50*exp(j*(omega*t+2*pi/3))+25*exp(i*omega*t)+10*exp(i*(omega*t+2*pi/3))+5*exp(i*(omega*t+2*pi/3));
E=[ Ea Eb Ec]; axis([-300,300,-300,300]);
compass(E)
pause(0.2)
end


