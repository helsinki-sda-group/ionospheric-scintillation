clc;
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      60 sec data (GNSS SDR)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\ph1.txt','rt');
fid2= fopen('Z:\personal files\data_s4\ph2.txt','rt');
fid3= fopen('Z:\personal files\data_s4\ph3.txt','rt');
fid4= fopen('Z:\personal files\data_s4\ph4.txt','rt');
fid5= fopen('Z:\personal files\data_s4\ph5.txt','rt');
fid6= fopen('Z:\personal files\data_s4\ph6.txt','rt');
fid7= fopen('Z:\personal files\data_s4\ph7.txt','rt');
fid8= fopen('Z:\personal files\data_s4\ph8.txt','rt');
s1=fscanf(fid1,'%f',16);
s2=fscanf(fid2,'%f',16);
s3=fscanf(fid3,'%f',16);
s4=fscanf(fid4,'%f',16);
s5=fscanf(fid5,'%f',16);
s6=fscanf(fid6,'%f',16);
s7=fscanf(fid7,'%f',16);
s8=fscanf(fid8,'%f',16);
figure(1)
plot(s1,'g','LineWidth',2);
hold on
plot(s2,'b','LineWidth',2);
hold on
plot(s3,'r','LineWidth',2);
hold on
plot(s4,'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(s5,'Color',rgb,'LineWidth',2);
hold on
plot(s6,'k','LineWidth',2);
hold on
plot(s7,'y','LineWidth',2);
hold on
plot(s8,'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GNSS SDR(phi-60)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      60 sec data (GPS station-6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\hdr1_60.txt','rt');
fid2= fopen('Z:\personal files\data_s4\hdr2_60.txt','rt');
fid3= fopen('Z:\personal files\data_s4\hdr3_60.txt','rt');
fid4= fopen('Z:\personal files\data_s4\hdr4_60.txt','rt');
fid5= fopen('Z:\personal files\data_s4\hdr5_60.txt','rt');
fid6= fopen('Z:\personal files\data_s4\hdr6_60.txt','rt');
fid7= fopen('Z:\personal files\data_s4\hdr7_60.txt','rt');
fid8= fopen('Z:\personal files\data_s4\hdr8_60.txt','rt');
s11=fscanf(fid1,'%f',20);
s22=fscanf(fid2,'%f',20);
s33=fscanf(fid3,'%f',20);
s44=fscanf(fid4,'%f',20);
s55=fscanf(fid5,'%f',20);
s66=fscanf(fid6,'%f',20);
s77=fscanf(fid7,'%f',20);
s88=fscanf(fid8,'%f',20);
figure(2)
plot(s11(2:17),'g','LineWidth',2);
hold on
plot(s22(2:17),'b','LineWidth',2);
hold on
plot(s33(1:16),'r','LineWidth',2);
hold on
plot(s44(2:17),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(s55(2:17),'Color',rgb,'LineWidth',2);
hold on
plot(s66(2:17),'k','LineWidth',2);
hold on
plot(s77(2:17),'y','LineWidth',2);
hold on
plot(s88(2:17),'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GPS station-6(phi-60)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%30 sec data (GPS Station-6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\hdr1_30.txt','rt');
fid2= fopen('Z:\personal files\data_s4\hdr2_30.txt','rt');
fid3= fopen('Z:\personal files\data_s4\hdr3_30.txt','rt');
fid4= fopen('Z:\personal files\data_s4\hdr4_30.txt','rt');
fid5= fopen('Z:\personal files\data_s4\hdr5_30.txt','rt');
fid6= fopen('Z:\personal files\data_s4\hdr6_30.txt','rt');
fid7= fopen('Z:\personal files\data_s4\hdr7_30.txt','rt');
fid8= fopen('Z:\personal files\data_s4\hdr8_30.txt','rt');
s11a=fscanf(fid1,'%f',20);
s22b=fscanf(fid2,'%f',20);
s33c=fscanf(fid3,'%f',20);
s44d=fscanf(fid4,'%f',20);
s55e=fscanf(fid5,'%f',20);
s66f=fscanf(fid6,'%f',20);
s77g=fscanf(fid7,'%f',20);
s88h=fscanf(fid8,'%f',20);
figure(3)
plot(s11a(2:17),'g','LineWidth',2);
hold on
plot(s22b(2:17),'b','LineWidth',2);
hold on
plot(s33c(1:16),'r','LineWidth',2);
hold on
plot(s44d(2:17),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(s55e(2:17),'Color',rgb,'LineWidth',2);
hold on
plot(s66f(2:17),'k','LineWidth',2);
hold on
plot(s77g(5:17),'y','LineWidth',2);
hold on
plot(s88h(2:17),'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GPS station-6(phi-30)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      10 sec data (GPS station-6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\hdr1_10.txt','rt');
fid2= fopen('Z:\personal files\data_s4\hdr2_10.txt','rt');
fid3= fopen('Z:\personal files\data_s4\hdr3_10.txt','rt');
fid4= fopen('Z:\personal files\data_s4\hdr4_10.txt','rt');
fid5= fopen('Z:\personal files\data_s4\hdr5_10.txt','rt');
fid6= fopen('Z:\personal files\data_s4\hdr6_10.txt','rt');
fid7= fopen('Z:\personal files\data_s4\hdr7_10.txt','rt');
fid8= fopen('Z:\personal files\data_s4\hdr8_10.txt','rt');
q11=fscanf(fid1,'%f',20);
q22=fscanf(fid2,'%f',20);
q33=fscanf(fid3,'%f',20);
q44=fscanf(fid4,'%f',20);
q55=fscanf(fid5,'%f',20);
q66=fscanf(fid6,'%f',20);
q77=fscanf(fid7,'%f',20);
q88=fscanf(fid8,'%f',20);
figure(4)
plot(q11(2:17),'g','LineWidth',2);
hold on
plot(q22(2:17),'b','LineWidth',2);
hold on
plot(q33(1:16),'r','LineWidth',2);
hold on
plot(q44(2:17),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(q55(2:17),'Color',rgb,'LineWidth',2);
hold on
plot(q66(2:17),'k','LineWidth',2);
hold on
plot(q77(5:17),'y','LineWidth',2);
hold on
plot(q88(3:17),'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GPS station-6(phi-10)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                      3 sec data (GPS station-6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\hdr1_3.txt','rt');
fid2= fopen('Z:\personal files\data_s4\hdr2_3.txt','rt');
fid3= fopen('Z:\personal files\data_s4\hdr3_3.txt','rt');
fid4= fopen('Z:\personal files\data_s4\hdr4_3.txt','rt');
fid5= fopen('Z:\personal files\data_s4\hdr5_3.txt','rt');
fid6= fopen('Z:\personal files\data_s4\hdr6_3.txt','rt');
fid7= fopen('Z:\personal files\data_s4\hdr7_3.txt','rt');
fid8= fopen('Z:\personal files\data_s4\hdr8_3.txt','rt');
r11=fscanf(fid1,'%f',20);
r22=fscanf(fid2,'%f',20);
r33=fscanf(fid3,'%f',20);
r44=fscanf(fid4,'%f',20);
r55=fscanf(fid5,'%f',20);
r66=fscanf(fid6,'%f',20);
r77=fscanf(fid7,'%f',20);
r88=fscanf(fid8,'%f',20);
figure(5)
plot(r11(2:17),'g','LineWidth',2);
hold on
plot(r22(2:17),'b','LineWidth',2);
hold on
plot(r33(1:16),'r','LineWidth',2);
hold on
plot(r44(2:17),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(r55(2:17),'Color',rgb,'LineWidth',2);
hold on
plot(r66(2:17),'k','LineWidth',2);
hold on
plot(r77(2:17),'y','LineWidth',2);
hold on
plot(r88(2:17),'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GPS station-6(phi-3)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       1 sec data (GPS station-6)                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\hdr1_1.txt','rt');
fid2= fopen('Z:\personal files\data_s4\hdr2_1.txt','rt');
fid3= fopen('Z:\personal files\data_s4\hdr3_1.txt','rt');
fid4= fopen('Z:\personal files\data_s4\hdr4_1.txt','rt');
fid5= fopen('Z:\personal files\data_s4\hdr5_1.txt','rt');
fid6= fopen('Z:\personal files\data_s4\hdr6_1.txt','rt');
fid7= fopen('Z:\personal files\data_s4\hdr7_1.txt','rt');
fid8= fopen('Z:\personal files\data_s4\hdr8_1.txt','rt');
t11=fscanf(fid1,'%f',20);
t22=fscanf(fid2,'%f',20);
t33=fscanf(fid3,'%f',20);
t44=fscanf(fid4,'%f',20);
t55=fscanf(fid5,'%f',20);
t66=fscanf(fid6,'%f',20);
t77=fscanf(fid7,'%f',20);
t88=fscanf(fid8,'%f',20);
figure(6)
plot(t11(2:17),'g','LineWidth',2);
hold on
plot(t22(2:17),'b','LineWidth',2);
hold on
plot(t33(1:16),'r','LineWidth',2);
hold on
plot(t44(2:17),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(t55(2:17),'Color',rgb,'LineWidth',2);
hold on
plot(t66(2:17),'k','LineWidth',2);
hold on
plot(t77(2:17),'y','LineWidth',2);
hold on
plot(t88(2:17),'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GPS station-6(phi-1)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%comparsion of Scintillation added SVN-9 GNSS SDR 1,30,10,60 with GNSS SDR%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% fid1 = fopen('Z:\personal files\data_s4\phi_divideby60.txt','rt');
% fid2= fopen('Z:\personal files\data_s4\phi_divideby30.txt','rt');
% fid3= fopen('Z:\personal files\data_s4\phi_divideby10.txt','rt');
% fid4= fopen('Z:\personal files\data_s4\phi_divideby3.txt','rt');
% fid5= fopen('Z:\personal files\data_s4\ph3.txt','rt');
fid1 = fopen('Z:\personal files\data_s4\ph_3_960.txt','rt');
fid2= fopen('Z:\personal files\data_s4\ph_3_480.txt','rt');
fid3= fopen('Z:\personal files\data_s4\ph_3_160.txt','rt');
fid4= fopen('Z:\personal files\data_s4\ph_3_48.txt','rt');
fid5= fopen('Z:\personal files\data_s4\ph_3_16.txt','rt');
u11=fscanf(fid1,'%f',960);
u22=fscanf(fid2,'%f',480);
u33=fscanf(fid3,'%f',160);
u44=fscanf(fid4,'%f',48);
u55=fscanf(fid5,'%f',16);
figure(7);
plot(u55(1:1:end),'r','LineWidth',2)
hold on
plot(s33(1:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-9,phi-60,GNSS SDR vs GPS station-6 ')
figure(8);
plot(u44(1:3:end),'r','LineWidth',2)
hold on
plot(s33c(1:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-9,phi-30,GNSS SDR vs GPS station-6 ')
figure(9);
plot(u33(1:10:end),'r','LineWidth',2)
hold on
plot(q33(1:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-9,phi-10,GNSS SDR vs GPS station-6 ')
figure(10);
plot(u22(1:30:end),'r','LineWidth',2)
hold on
plot(r33(1:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-9,phi-3,GNSS SDR vs GPS station-6 ')
figure(11);
plot(u11(1:60:end),'r','LineWidth',2)
hold on
plot(t33(1:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-9,phi-1,GNSS SDR vs GPS station-6 ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%GNSS_SDR_phi1,3,10,30 and 60 plots%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\ph_6_960.txt','rt');
fid2 = fopen('Z:\personal files\data_s4\ph_2_48.txt','rt');
fid3 = fopen('Z:\personal files\data_s4\ph_3_480.txt','rt');
% fid3 = fopen('Z:\personal files\data_s4\phi_divideby30.txt','rt');
fid4 = fopen('Z:\personal files\data_s4\ph_4_48.txt','rt');
fid5 = fopen('Z:\personal files\data_s4\ph_5_48.txt','rt');
fid6 = fopen('Z:\personal files\data_s4\ph_6_48.txt','rt');
fid7 = fopen('Z:\personal files\data_s4\ph_7_480.txt','rt');
fid8 = fopen('Z:\personal files\data_s4\ph_8_48.txt','rt');
v1=fscanf(fid1,'%f',960);
v2=fscanf(fid2,'%f',48);
v3=fscanf(fid3,'%f',960);
v4=fscanf(fid4,'%f',48);
v5=fscanf(fid5,'%f',960);
v6=fscanf(fid6,'%f',160);
v7=fscanf(fid7,'%f',480);
v8=fscanf(fid8,'%f',48);
figure(12)
plot(s1(1:3:end),'g','LineWidth',2);
hold on
plot(s2(1:1:end),'b','LineWidth',2);
hold on
plot(s3(1:1:end),'r','LineWidth',2);
hold on
plot(s4(1:1:end),'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(s5(1:1:end),'Color',rgb,'LineWidth',2);
hold on
plot(s6(1:1:end),'k','LineWidth',2);
hold on
% plot(v7(1:3:end),'y','LineWidth',2);
hold on
plot(s8(1:1:end),'m','LineWidth',2);
hold off
% legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('GNSS SDR(phi-60)')
% SVN-2-s11-60 sec % s11a-30 sec % q11-10sec % r11-3sec % t11-1sec-color-g
% SVN-8-s22-60 sec % s22b-30 sec % q22-10sec % r22-3sec % t22-1sec-color-b
% SVN-9-s33-60 sec % s33c-30 sec % q33-10sec % r33-3sec % t33-1sec-color-r
% SVN-10-s44-60 sec % s44d-30 sec % q44-10sec % r44-3sec % t44-1sec-color-c
% SVN-21-s55-60 sec % s55e-30 sec % q55-10sec % r55-3sec % t55-1sec-color-
% SVN-24-s66-60 sec % s66f-30 sec % q66-10sec % r66-3sec % t66-1sec-color-k
% SVN-26-s77-60 sec % s77g-30 sec % q77-10sec % r77-3sec % t77-1sec-color-y
% SVN-28-s88-60 sec % s88h-30 sec % q88-10sec % r88-3sec % t88-1sec-color-m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%Non scintillation SVN comparsion of sigma phi-1,3,10,30 and 60%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(13)
plot(s11(1:16),'c+:','LineWidth',2);
hold on
plot(s1(1:1:end),'Color','g','LineWidth',2);
hold off
legend('GPS station-6','GNSS SDR');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('phase-rad', 'FontSize', 12)
title('SVN-2,phi-60,GNSS SDR vs GPS station-6 ')

