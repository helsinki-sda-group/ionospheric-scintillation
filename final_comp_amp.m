%Run the code for plotting the amplitude index

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%comparsion of s4 index values for GPS STATION-6 receivers for all SVN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\s41.txt','rt');
fid2= fopen('Z:\personal files\data_s4\s42.txt','rt');
fid3= fopen('Z:\personal files\data_s4\s43.txt','rt');
fid4= fopen('Z:\personal files\data_s4\s44.txt','rt');
fid5= fopen('Z:\personal files\data_s4\s45.txt','rt');
fid6= fopen('Z:\personal files\data_s4\s46.txt','rt');
fid7= fopen('Z:\personal files\data_s4\s47.txt','rt');
fid8= fopen('Z:\personal files\data_s4\s48.txt','rt');
s1=fscanf(fid1,'%f',16);
s2=fscanf(fid2,'%f',16);
s3=fscanf(fid3,'%f',16);
s4=fscanf(fid4,'%f',16);
s5=fscanf(fid5,'%f',16);
s6=fscanf(fid6,'%f',16);
s7=fscanf(fid7,'%f',17);
s8=fscanf(fid8,'%f',18);
figure(1)
plot(s1,'g','LineWidth',2);
hold on
plot(s2,'b','LineWidth',2);
hold on
plot(s3,'r','LineWidth',2);
hold on
plot(s4,'c','LineWidth',2);
hold on
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
ylabel('amplitude', 'FontSize', 12)
title('GPS Station-6 Receiver')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%comparsion of s4 index values for GNSS SDR for all SVN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid1 = fopen('Z:\personal files\data_s4\s41_sdr.txt','rt');
fid2= fopen('Z:\personal files\data_s4\s42_sdr.txt','rt');
fid3= fopen('Z:\personal files\data_s4\s43_sdr.txt','rt');
fid4= fopen('Z:\personal files\data_s4\s44_sdr.txt','rt');
fid5= fopen('Z:\personal files\data_s4\s45_sdr.txt','rt');
fid6= fopen('Z:\personal files\data_s4\s46_sdr.txt','rt');
fid7= fopen('Z:\personal files\data_s4\s47_sdr.txt','rt');
fid8= fopen('Z:\personal files\data_s4\s48_sdr.txt','rt');
s11=fscanf(fid1,'%f',16);
s22=fscanf(fid2,'%f',16);
s33=fscanf(fid3,'%f',16);
s44=fscanf(fid4,'%f',16);
s55=fscanf(fid5,'%f',16);
s66=fscanf(fid6,'%f',16);
s77=fscanf(fid7,'%f',17);
s88=fscanf(fid8,'%f',17);
figure(2)
plot(s11,'g','LineWidth',2);
hold on
plot(s22,'b','LineWidth',2);
hold on
plot(s33,'r','LineWidth',2);
hold on
plot(s44,'c','LineWidth',2);
hold on
rgb = [23 88 36]/256;
plot(s55,'Color',rgb,'LineWidth',2);
hold on
plot(s66,'k','LineWidth',2);
hold on
plot(s77,'y','LineWidth',2);
hold on
plot(s88,'m','LineWidth',2);
legend('SVN-2','SVN-8','SVN-9','SVN-10','SVN-21','SVN-24','SVN-26','SVN-28');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('amplitude', 'FontSize', 12)
title('GNSS SDR')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%comparsion of s4 index values GNSS SDR vs GPS Station-6 for scintillation 
%added SVN's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
plot(s33(2:16),'Color','r','LineWidth',2);
hold on
plot(s3(2:16),'c+:','LineWidth',2);
hold off
legend('GNSS SDR','GPS station-6');
xlabel('Time-minutes', 'FontSize', 12)
ylabel('amplitude', 'FontSize', 12)
title('SVN-3,GNSS SDR vs GPS station-6 ')