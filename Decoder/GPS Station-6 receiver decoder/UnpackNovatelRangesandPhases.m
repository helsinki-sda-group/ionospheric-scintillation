
function [GPS_Obs,GAL_Obs,GLO_Obs]=UnpackNovatelRangesandPhases(fnamein);
%fnamein='NMND21220016Z_2021-09-01_08-42-18.LOG';
fnamein='ArulScintSimBFN13270478_02-11-2021_14-01-30.gps';
fd=fopen(fnamein,'rb'); %Open for reading, little endian

numobs=500000;
obsdex=1;
secdex=0;
%dimensions are:
    %obsnum, sat, freq, observables
%observables are:
    %Week, ToW, Range, Range sigma, ADR, ADR sigma, CN0, Glofreq/0,
    %doppler, unused
GPS_Obs=NaN(numobs,32,3,10); 

GAL_Obs=NaN(numobs,36,3,10);

GLO_Obs=NaN(numobs,24,3,10);

c_speed=299792458;

%Parse raw file
outofdata=0;
while(~outofdata)
    %Read a byte - is it AA?
    [dat,numread]=fread(fd,1,'uint8');
    if(numread~=1) outofdata=1; break; end
    if(dat(1)==170)
        [dat,numread]=fread(fd,3,'uint8');
        if(numread~=3) outofdata=1; break; end
        %Read 4 bytes - check for 44,12,xx,MESID
        if((dat(1)==68)&&(dat(2)==18))
            %Found a Binary message, check if it's a rangeB measurement
            [dat,numread]=fread(fd,1,'uint16');
            if(numread~=1) outofdata=1; break; end
            if(dat(1)==43)
                %Gather sequence
                [dat,numread]=fread(fd,3,'uint16');
                if(numread~=3) outofdata=1; break; end
                meslength=dat(2);
                sequence=dat(3);
                if(sequence~=0) fprintf("Got a non zero sequence number %d \n",sequence); end
                %Gather idle time, status, and week
                [dat,numread]=fread(fd,2,'uint16');
                if(numread~=2) outofdata=1; break; end
                GPSWeek=dat(2);
                %Gather ToW and remainder of header
                [dat,numread]=fread(fd,3,'int32');
                if(numread~=3) outofdata=1; break; end
                GPSToW=dat(1);
                
                %Extra number of observations in packet
                [dat,numread]=fread(fd,1,'uint32');
                if(numread~=1) outofdata=1; break; end
                nmeas=dat(1);
                for measdex=1:nmeas
                       %PRN/SLOT and glofreq
                       [dat,numread]=fread(fd,2,'uint16');
                       if(numread~=2) outofdata=1; break; end
                       PRNslot=dat(1);
                       glofreq=dat(2);
                       %Pseudorange
                       [dat,numread]=fread(fd,1,'double','l');
                       if(numread~=1) outofdata=1; break; end
                       psr=dat(1);
                       %Pseudorange_sigma
                       [dat,numread]=fread(fd,1,'float','l');
                       if(numread~=1) outofdata=1; break; end
                       psr_sigma=dat(1);
                       %ADR
                       [dat,numread]=fread(fd,1,'double','l');
                       if(numread~=1) outofdata=1; break; end
                       adr=dat(1);
                       %ADR_sigma
                       [dat,numread]=fread(fd,1,'float','l');
                       if(numread~=1) outofdata=1; break; end
                       adr_sigma=dat(1);
                       %Doppler, C/N0, locktime
                       [dat,numread]=fread(fd,3,'float','l');
                       if(numread~=3) outofdata=1; break; end
                       dopp=dat(1);
                       CN0=dat(2);
                       locktime=dat(3);
                       %Chantrack status
                       [dat,numread]=fread(fd,1,'uint32','l');
                       if(numread~=1) outofdata=1; break; end
                       chantrackstat=dat(1);
                       %Isolate tracking parameters
                       Trackingstate = bitand(chantrackstat,0x0000001F,'uint32');
                       SVchannumber = bitand(chantrackstat,0x000003E0,'uint32')/32;
                       Phaselockflag = bitand(chantrackstat,0x00000400,'uint32')/1024;
                       Parityknownflag = bitand(chantrackstat,0x00000800,'uint32')/2048;
                       Codelockflag = bitand(chantrackstat,0x00001000,'uint32')/4096;
                       Correlatortype = bitand(chantrackstat,0x0000E000,'uint32')/8192;
                       Satellitesystem = bitand(chantrackstat,0x00070000,'uint32')/65536;
                       Reserved = bitand(chantrackstat,0x00080000,'uint32')/524288;
                       Grouping = bitand(chantrackstat,0x00100000,'uint32')/1048576;
                       Signaltype = bitand(chantrackstat,0x03E00000,'uint32')/2097152;
                       Reserved2 = bitand(chantrackstat,0x04000000,'uint32')/67108864;
                       PrimaryL1 = bitand(chantrackstat,0x08000000,'uint32')/134217728;
                       Carrierhalfcycle = bitand(chantrackstat,0x10000000,'uint32')/268435456;
                       Digitalfilter = bitand(chantrackstat,0x20000000,'uint32')/536870912;
                       PRNlockflag = bitand(chantrackstat,0x40000000,'uint32')/1073741824;
                       ChannelAssignment = bitand(chantrackstat,0x80000000,'uint32')/2147483648;
                       %Check if parity known, phase locked, and
                       %code locked via flags
                       if((Codelockflag==1)&&(Phaselockflag==1)&&(Parityknownflag==1))
                           %Determine constellation
                           if(Satellitesystem==0)
                               %GPS
                               if(Signaltype==0)
                                   %L1
                                   Lambda=c_speed/(1575.42e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GPS_Obs(obsdex,PRNslot,1,1)=GPSWeek;
                                   GPS_Obs(obsdex,PRNslot,1,2)=GPSToW;
                                   GPS_Obs(obsdex,PRNslot,1,3)=psr;
                                   GPS_Obs(obsdex,PRNslot,1,4)=psr_sigma;
                                   GPS_Obs(obsdex,PRNslot,1,5)=adr*Lambda;
                                   GPS_Obs(obsdex,PRNslot,1,6)=adr_sigma;
                                   GPS_Obs(obsdex,PRNslot,1,7)=CN0;
                                   GPS_Obs(obsdex,PRNslot,1,8)=0;
                                   GPS_Obs(obsdex,PRNslot,1,9)=dopp;
                                   GPS_Obs(obsdex,PRNslot,1,10)=0;
                               elseif(Signaltype==17)
                                   %L2C
                                   Lambda=c_speed/(1227.6e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GPS_Obs(obsdex,PRNslot,2,1)=GPSWeek;
                                   GPS_Obs(obsdex,PRNslot,2,2)=GPSToW;
                                   GPS_Obs(obsdex,PRNslot,2,3)=psr;
                                   GPS_Obs(obsdex,PRNslot,2,4)=psr_sigma;
                                   GPS_Obs(obsdex,PRNslot,2,5)=adr*Lambda;
                                   GPS_Obs(obsdex,PRNslot,2,6)=adr_sigma*Lambda;
                                   GPS_Obs(obsdex,PRNslot,2,7)=CN0;
                                   GPS_Obs(obsdex,PRNslot,2,8)=0;
                                   GPS_Obs(obsdex,PRNslot,2,9)=dopp;
                                   GPS_Obs(obsdex,PRNslot,2,10)=0;
                               elseif(Signaltype==14)
                                   %L5
                                   Lambda=c_speed/(1176.45e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GPS_Obs(obsdex,PRNslot,3,1)=GPSWeek;
                                   GPS_Obs(obsdex,PRNslot,3,2)=GPSToW;
                                   GPS_Obs(obsdex,PRNslot,3,3)=psr;
                                   GPS_Obs(obsdex,PRNslot,3,4)=psr_sigma;
                                   GPS_Obs(obsdex,PRNslot,3,5)=adr*Lambda;
                                   GPS_Obs(obsdex,PRNslot,3,6)=adr_sigma*Lambda;
                                   GPS_Obs(obsdex,PRNslot,3,7)=CN0;
                                   GPS_Obs(obsdex,PRNslot,3,8)=0;
                                   GPS_Obs(obsdex,PRNslot,3,9)=dopp;
                                   GPS_Obs(obsdex,PRNslot,3,10)=0;
                               end
                           elseif(Satellitesystem==1)
                               %GLONASS
                               if(Signaltype==0)
                                   %L1CA
                                   Lambda=c_speed/(1602e6+dopp+0.5625e6*glofreq);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GLO_Obs(obsdex,PRNslot-37,1,1)=GPSWeek;
                                   GLO_Obs(obsdex,PRNslot-37,1,2)=GPSToW;
                                   GLO_Obs(obsdex,PRNslot-37,1,3)=psr;
                                   GLO_Obs(obsdex,PRNslot-37,1,4)=psr_sigma;
                                   GLO_Obs(obsdex,PRNslot-37,1,5)=adr*Lambda;
                                   GLO_Obs(obsdex,PRNslot-37,1,6)=adr_sigma*Lambda;
                                   GLO_Obs(obsdex,PRNslot-37,1,7)=CN0;
                                   GLO_Obs(obsdex,PRNslot-37,1,8)=glofreq;
                                   GLO_Obs(obsdex,PRNslot-37,1,9)=dopp;
                                   GLO_Obs(obsdex,PRNslot-37,1,10)=0;
                               elseif(Signaltype==1)
                                   %L2CA
                                   Lambda=c_speed/(1246e6+dopp+0.4375e6*glofreq);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GLO_Obs(obsdex,PRNslot-37,2,1)=GPSWeek;
                                   GLO_Obs(obsdex,PRNslot-37,2,2)=GPSToW;
                                   GLO_Obs(obsdex,PRNslot-37,2,3)=psr;
                                   GLO_Obs(obsdex,PRNslot-37,2,4)=psr_sigma;
                                   GLO_Obs(obsdex,PRNslot-37,2,5)=adr*Lambda;
                                   GLO_Obs(obsdex,PRNslot-37,2,6)=adr_sigma*Lambda;
                                   GLO_Obs(obsdex,PRNslot-37,2,7)=CN0;
                                   GLO_Obs(obsdex,PRNslot-37,2,8)=glofreq;
                                   GLO_Obs(obsdex,PRNslot-37,2,9)=dopp;
                                   GLO_Obs(obsdex,PRNslot-37,2,9)=0;
                               elseif(Signaltype==6)
                                   %L3
                                   fprintf("Found GLONASS L3 obs. \n");
                               end
                           elseif(Satellitesystem==3)
                               %Galileo
                               if(Signaltype==2)
                                   %E1
                                   Lambda=c_speed/(1575.42e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GAL_Obs(obsdex,PRNslot,1,1)=GPSWeek;
                                   GAL_Obs(obsdex,PRNslot,1,2)=GPSToW;
                                   GAL_Obs(obsdex,PRNslot,1,3)=psr;
                                   GAL_Obs(obsdex,PRNslot,1,4)=psr_sigma;
                                   GAL_Obs(obsdex,PRNslot,1,5)=adr*Lambda;
                                   GAL_Obs(obsdex,PRNslot,1,6)=adr_sigma*Lambda;
                                   GAL_Obs(obsdex,PRNslot,1,7)=CN0;
                                   GAL_Obs(obsdex,PRNslot,1,8)=0;
                                   GAL_Obs(obsdex,PRNslot,1,9)=dopp;
                                   GAL_Obs(obsdex,PRNslot,1,10)=0;
                               elseif(Signaltype==17)
                                   %E5b
                                   Lambda=c_speed/(1207.14e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GAL_Obs(obsdex,PRNslot,2,1)=GPSWeek;
                                   GAL_Obs(obsdex,PRNslot,2,2)=GPSToW;
                                   GAL_Obs(obsdex,PRNslot,2,3)=psr;
                                   GAL_Obs(obsdex,PRNslot,2,4)=psr_sigma;
                                   GAL_Obs(obsdex,PRNslot,2,5)=adr*Lambda;
                                   GAL_Obs(obsdex,PRNslot,2,6)=adr_sigma*Lambda;
                                   GAL_Obs(obsdex,PRNslot,2,7)=CN0;
                                   GAL_Obs(obsdex,PRNslot,2,8)=0;
                                   GAL_Obs(obsdex,PRNslot,2,9)=dopp;
                                   GAL_Obs(obsdex,PRNslot,2,10)=0;
                               elseif(Signaltype==12)
                                   %E5a
                                   Lambda=c_speed/(1176.45e6+dopp);
                                   %observables are:
                                    %Week, ToW, Range, Range sigma, ADR,
                                    %ADR sigma, CN0, Glofreq/0, Unused
                                   GAL_Obs(obsdex,PRNslot,3,1)=GPSWeek;
                                   GAL_Obs(obsdex,PRNslot,3,2)=GPSToW;
                                   GAL_Obs(obsdex,PRNslot,3,3)=psr;
                                   GAL_Obs(obsdex,PRNslot,3,4)=psr_sigma;
                                   GAL_Obs(obsdex,PRNslot,3,5)=adr*Lambda;
                                   GAL_Obs(obsdex,PRNslot,3,6)=adr_sigma*Lambda;
                                   GAL_Obs(obsdex,PRNslot,3,7)=CN0;
                                   GAL_Obs(obsdex,PRNslot,3,8)=0;
                                   GAL_Obs(obsdex,PRNslot,3,9)=dopp;
                                   GAL_Obs(obsdex,PRNslot,3,10)=0;
                               end
                           elseif(Satellitesystem==4)
                               %BeiDou
                               fprintf("Found BDS obs. \n");
                           end %Satellite system elseif
                       end %Locked and phase parity check
                end %Measurement dex end
                
                %Extract last field 32 bit CRC
                [dat,numread]=fread(fd,1,'uint32','l');
                if(numread~=1) outofdata=1; break; end
                
                
                obsdex=obsdex+1;
                if(mod(obsdex,100)==0) secdex=secdex+1; fprintf("Processed %d seconds of data at week %d, %d tow \n",secdex,GPSWeek,GPSToW); end
            end
        end %44 12 xx 43 check
    end % AA check
    
    %Check for end of file
end %outofdata while



%Trim observations
GPS_Obs=GPS_Obs(1:obsdex-1,:,:,:);
GAL_Obs=GAL_Obs(1:obsdex-1,:,:,:);
GLO_Obs=GLO_Obs(1:obsdex-1,:,:,:);


%close raw file
fclose(fd);
