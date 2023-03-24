clc
clear all;
close all;
%Inputs from the tracking loops of the Inphase prompt values obtained form
%GNSS SDR for each visible satellites
fid1 = fopen('Z:\personal files\data_s4\ip_2_26.txt','rt');
%Inputs from the tracking loops of the quadrature phase prompt values obtained 
%from GNSS SDR for each visible satellites
fid2= fopen('Z:\personal files\data_s4\qp_2_26.txt','rt');
%Inputs from the accumaulted doppler values obtained from the GNSS SDR 
%for each visible satellites
fid3 = fopen('Z:\personal files\data_s4\accdopp2_26.txt','rt');
Ip=fscanf(fid1,'%f',1020000);
Qp=fscanf(fid2,'%f',1020000);
a=atan(Qp./Ip);
carrier_phase=fscanf(fid3,'%f',1020000);
start_index=0;
%calculation of bit transitions in the navigation data
 %The technique of detecting the first zero crossing, which is finding bit 
 %transition in the prompt correlator output of tracking data which is the 
 %beginning of the navigation data. If the first phase transition is found
 %within the first 20 ms of data, consider this point as beginning of 
 %the first navigation data else the phase transition occurs at a later 
 %point of time, then multiple numbers of 20 ms are subtracted from it. 
 %The remainder is the beginning of the first navigation data. 
for i=1:length(Ip)
% ***** Truncate to 1 bit precision *****
 if Ip(i)>0
 data(i)=1;
 else
 data(i)=0;
 end
 % ***** Detect zero crossings *****
 if i>1
 if data(i)~=data(i-1)
crossing(i)=1;
 else
 crossing(i)=0;
 end
 end
 end
% ***** Indexes of zero crossings *****
 crossing_index = find(crossing);
offset = mod(crossing_index(length(crossing_index)),20);
if (offset==0) offset=20; end
 if (offset==1) offset=21; end
 total_bits = floor((length(Ip)-offset)/20)+2;

 for i=1:total_bits
 if i==1
 mean_value(i) = mean(data(1:offset-1));
  elseif i==total_bits
 mean_value(i) = mean(data(offset+(i-2)*20:length(data)));
  else
 mean_value(i) = mean(data(offset+(i-2)*20:offset+(i-2)*20+19));
  end
 if (mean_value(i)>.10)&&(mean_value(i)<.90)
 %fprintf('Possible loss of bit synchronization - bit number %d - mean value %2.2f\n',i,mean_value(i));
end
out(i) = round(mean_value(i));
end

for i=1:length(out)
    if out(i)==0
out(i)=-1;
end
end

Ip1=[zeros(1,21-offset) Ip'];
Qp1=[zeros(1,21-offset) Qp'];

e1=Ip1(21:(length(Ip1)));
f1=Qp1(21:(length(Ip1)));
e2= [e1 zeros(1,offset-1)];
f2= [f1 zeros(1,offset-1)];
Ip1=e2;
Qp1=f2;
phiq=atan(Qp1./Ip1);
M=20;
%Trim I and Q vectors
I=e2(1:20*floor(numel(Ip1)/20));
Q=f2(1:20*floor(numel(Qp1)/20));
%Reshape I and Q into M columns
I=reshape(I,M,numel(I)/M)';
Q=reshape(Q,M,numel(I)/M)';
%Calculate Wide Band Power
WBP1= sum(I.^2+Q.^2,2);
    %Calculate Narrow Band Power
    NBP1 = sum(I,2).^2 + sum(Q,2).^2;
    np1=NBP1-WBP1;
% e=zeros(1,20*length(crossing_index));
% e([1:20:end])=Ip(crossing_index);
% f=zeros(1,20*length(crossing_index));
% f([1:20:end])=Qp(crossing_index);

  L=20;%summing 20 for GPS L1 Signal
 %computation of narrow band power
%     nb=[];
    nb2 = [];
    for j=1:floor(length(Ip1)/L)
        nb1 =[];
        for i=L*j-L+1:(j*L)
            nb1 = (sum(Ip1(i)).^2)+(sum(Qp1(i)).^2);
        end
        nb2=[nb2 nb1];
    end
  A=zeros(1,L*length(nb2));
 A([1:L:end])=nb2;  
    %computation of wideband power
%     wb=[];
    wb2 = [];
        for j=1:floor(length(Qp1)/L)
        wb1=[];
        for i=(L*j)-L+1:(j*L)
            wb1= sum(Ip1(i)+Qp1(i)).^2;
        end
        wb2=[wb2 wb1];
        
    end
 B=zeros(1,L*length(wb2));
 B([1:L:end])=wb2;
 k=nb2-wb2;
%Summing 20 msec for GPS L1 Signal for moving window accumaultion
%mentioned in the reference paper fingure 5 by "DONGYANG XU, YU MORTON, 
%A Semi-Open Loop GNSS Carrier Tracking Algorithm for Monitoring Strong 
%EquatorialScintillation-IEEE TRANSACTIONS ON AEROSPACE AND ELECTRONIC 
%SYSTEMS VOL. 54, NO. 2 APRIL 2018"

% %computation of narrow band power
% nb=[];
% nb2 = [];
% for j=1:length(Ip)-L
%     nb1 =[];
%     for i=j:L+j-1
%         nb = (sum(Ip(j:(j-1+L)),2)).^2+(sum(Qp(j:j-1+L),2)).^2;
%         nb1=[nb1 nb];  
%     end
%     nb2=[nb2 nb1];
% end
% %%
% %summing 20 msec for GPS L1 Signal for moving avaerage accumaultion 
%computation of wideband power mentioned in the above reference paper  
% wb=0;
% wb1=[];
% wb2 = [];
% 
% for j=1:length(Ip)-L
%     wb1=[];
%     for i=j:L+j-1
%         wb= sum(Ip(i)+Qp(i),2).^2;
%         
%         wb1=[wb1 wb];
%     end
%     wb2=[wb2 wb1];
%     
% end
n=1;
s4_new=[];
phase_index1=[];
phase_index_new1=[];
%Processing the observation window in the interval of 60 seconds duration 
for seed = 1:3000:17*3000
NBP=NBP1(seed:n*3000);
WBP=WBP1(seed:n*3000);
Ip_new=Ip1(seed:n*3000);
Qp_new=Qp1(seed:n*3000);
phi=atan(Qp_new./Ip_new);
SI=NBP-WBP;
fs = 50;
%Total observation window. 60 seconds, i.e. 1 minute, is the standard
%Number of signal samples in one observation period

%% Set up paramters for the Butterworth filter
%Cut off frequency
wn = 0.1 / (fs/2);
%Filter 
[B3, A3] = butter(2, wn, 'low');
% m=6;% choosing the order of the filter
%Fs=50;
%fc = 0.1 % cut off frequency
%Wn = (fc*2)/Fs % Fs is sampling frequency, normalizing the cut off frequency
%[b,a] = butter(m,0.1,'low');
%[A1,B1,C1,D1] = tf2ss(b,a)
% y=filter(b,a,SI);   % filtered output
%The filter design is based on the ref "Ionospheric Scintillation Monitoring 
%Using Commercial SingleFrequency C/A Code Receivers" by A. J. Van Dierendonck,
%John Klobuchar and Quyen Hua
y=filtfilt(B3, A3, SI);
SI_filtered=SI./y;
l=length(SI);
m_sq=sum(SI_filtered.^2)/l;
sq_m=(sum(SI_filtered)./l)^2;
s4=sqrt((m_sq-sq_m)/sq_m);
s4_new= [s4_new s4];
phi1=sum(phi).^2/l;
phi2=(sum(phi)./l).^2;
phase_index=(sqrt((phi1-phi2)/phi2));
phase_index_new=std(phi);
phase_index1=[phase_index1 phase_index];
phase_index_new1=[phase_index_new1 phase_index_new];
%highpass filter design
wn1 = 1 / (fs * 2*pi); 
[B2, A2] = butter(2, wn1, 'high');
det_phase1_b1 = filter(B2, A2, phase_index_new1);
n=n+1;
end
figure(1);
plot(s4_new(2:end));
xlabel('Time')
ylabel('amplitude');
title('s4 index');
n=1;phase_index_new2=[];
phase_in1=[];
Phi60_AJ1=[];phaseError20ms_new=[];
for seed1 = 1:60000:17*60000
Ip_new1=Ip(seed1:n*60000);
Qp_new1=Qp(seed1:n*60000);
T_int=1e-3;
I = sum(reshape(Ip_new1, 20/(T_int*1e3), []));
Q = sum(reshape(Qp_new1, 20/(T_int*1e3), []));
phaseError20ms = atan(Q./I);
phaseError20ms_new=[phaseError20ms_new phaseError20ms];
interval=10;
carrier_phase_new=carrier_phase(seed1:n*60000);
%Choose the T value based on the phase observation sigma-phi calculation,
%keep interval T=60 for sigma-phi-60 observation,T=20 interval for sigma-phi-30, 
%T=6 interval for sigma-phi-10,similarly T=2 for sigma-phi-3 and T=1 for
%sigma-phi-1 obervation.
fs = 50;
T = 1;  
Smpl = fs*T;
stp=20;
phase_instant_50hz = reshape(carrier_phase_new,stp,[]);
phase_in = phase_instant_50hz(stp,:);
phase_in1=[phase_in1 phase_in];
carrier_phase_new1=carrier_phase(1:59983)';
phase_index_neww1=(phase_in+phaseError20ms);
phase_index_new2=[phase_index_new2 phase_index_neww1];
n=n+1;
end
%For designing State Transition Matrix and Input Vector 
%Elements, refer Table in the reference paper "Ionospheric 
%Scintillation Monitoring Using Commercial SingleFrequency C/A Code 
%Receivers" by A. J. Van Dierendonck,John Klobuchar and Quyen Hua
load coeff_ts_20ms.mat
%checking the filtered phase residuals using polynomial filtering
x=1:length(phase_index_new2);
linearCoefficients = polyfit(x, phase_index_new2, 1);
yFit = polyval(linearCoefficients,x);
%calculating the detrended phase using 3 stage filtering using the
%reference Ionospheric Scintillation Monitoring Using Commercial Single
%Frequency C/A Code Receivers by A. J. Van Dierendonck,John Klobuchar and
%Quyen Hua
det_phase_f1=filtfilt(b1f1,a1f1,phase_index_new2);
det_phase_f1=det_phase_f1(3001:end);
det_phase_f2=filtfilt(b2f1,a2f1,det_phase_f1);
det_phase_f2=det_phase_f2(3001:end);
detrended_phase=filtfilt(b3f1,a3f1,det_phase_f2);
detrended_phase=detrended_phase(3001:end);
detrended_phase = [nan(1, 9000), detrended_phase];
Phi60_AJ = std(reshape(detrended_phase, Smpl, []));
err=sqrt(phase_index_new2-yFit).^2;
Phi60_AJ_ploy = std(reshape(err, Smpl, []));
%For plotting the phase index values for phi-60, down sample the standard 
%deviation of phase index samples in the interval of 1,for plotting phi-30
%values, down sample the phase index values by 3, for plotting phi-10 values, 
%down sample the phase index values by 10, for plotting phi-3 values, down 
%sample the phase index values by 30 and for plotting phi-1 values, down 
%sample the phase index values by 60 respectively.
figure(2);
plot(Phi60_AJ)
hold on
plot(Phi60_AJ_ploy);
legend('phase detrending using lowpass filter','polynomial filtering');
xlabel('Time-min')
ylabel('rad');
figure(3);
plot(phase_index_new2);
xlabel('Time-min')
ylabel('carrier phase-cycles');
figure(4)
plot(detrended_phase);
xlabel('Time')
ylabel('cycles');
figure(5)
plot(x, phase_index_new2, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
hold on;
plot(x, yFit, 'b.-', 'MarkerSize', 15, 'LineWidth', 1);
legend('carrierphase', 'least squares Fit', 'Location', 'Northwest');
figure(6)
err=sqrt(phase_index_new2-yFit).^2;
plot(err);
hold on
plot(detrended_phase);
legend('phase detrending using lowpass filter','polynomial filtering');

