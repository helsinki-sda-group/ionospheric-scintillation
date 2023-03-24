Procedure for computing the ionospheric scintillation parameters (S4 index and sigma-phi) using software GNSS Receiver

General Procedure

Extract the prompt correlator outputs of in phase and quadrature phase components and accumulated doppler frequency using the software GNSS receiver of your interest.
As we have used FGI-GNSS receiver, please follow the instructions provided below for running software GNSS.

Step1:  Navigate the required files for running FGI GNSS SDR
Files required for running the GNSS SDR
Configuration file (RXconfig.txt)
Raw RF data captured form ARFIDAAS RF front end (outsamplesA_1582_60.dat)
Note: Based on the ARFIDAAS RF front end specification, fix the parameters specified in the configuration file. 

First navigate to “/FGI-GSRx/param/ RXconfig.txt” and open it. In this file you will find multiple path information given (E.g., line 34 or line 63). In order for the program to find these files, please copy the lines in the .txt file containing exact data paths to a newly created .txt file and change the paths to the paths on your local machine. The user has to also specify the path where ‘name.txt’ is located, if the created ‘name.txt’ configuration file is outside the directory of FGI-GSRx.
Then run the “gsrx(‘RXconfig.txt’)”
Change the file settings of the playback signal parameters in the name.txt what you have set in the recorded signal. 
(RF front end settings)
sys,msToProcess- the duration of the signal, if you set 0, the maximum number of ms (Total length of the file) will be processed.
Set the path of the file based on type of signal recorded for example you have recorded GPS L1 signal go to the GPS L1 Settings change the file name and path accordingly.
%gpsl1, rfFileName,'.\C:\Users\ganapath\Downloads\outsamplesA_1582_60.dat',
Based on the RF front end recording specifications you set in playback also use the same parameters 
gpsl1, samplingFreq, 60e6, % Sampling frequency [Hz] you specified in RF front end
gpsl1, bandWidth,55e6, % Bandwidth of the front end [Hz] you specified in RF front end.
gpsl1, sampleSize,16, % Number of bits for one sample. For complex data this is the size for I+Q. If you have used 8 bits for recording change accordingly.
gpsl1, complexData, true, % Complex or real data if the data is real then set false.
Remaining acquisition, tracking etc. parameters settings can be seen from the configuration file.
Save the tracking loop output of prompt correlators (I_P and Q_P) values for all SVN in a file. Extract Ip and Qp values.
Ip and Qp values are saved in the form of text files located in the folder ip_tracking “ip_2_26.txt” and qp_tarcking folder “qp_2_26.txt” given as input to the calculation of S4 index.
Extract the accumulated doppler frequency from all satellites and stored in a file folder named ‘accumulated doppler’
Use this one as input for calculating phase index values for example using 26th SVN use text file “accdopp2_26.txt”
Using the MATLAB code “swr_new_amp_phase_calc.m” The following steps are carried out to plot the s4 index and phase index.
Read the Ip &Qp values and carrier phase “accdopp2_26.txt” from the file already stored.
Find the bit transitions in the navigation data.
calculate the narrow and wide band power.
Processing 3000 samples in the observation window interval of 60 seconds duration.
Set up parameters for the Butterworth filter
Calculate the phase error.
Set the T value based on the phase observation in sigma-phi calculation
Load the State Transition Matrix and Input Vector for phase detrending filter.
Implement 3 stage phase detrending filter.
Check the filtered phase residuals using polynomial filtering.
For plotting the phase index values, down sample the standard deviation of phase index samples at specified intervals.

For comparing the S4 index of GPS Station-6 hardware observables with respect to the GNSS SDR, please run the “final_comp_amp.m”
Note: All the satellite’s S4 index values are saved in text files placed in a folder named ‘hdr_receiver’ for both GPS station-6 and GNSS SDR.
Example: s41.txt for GPS Station-6 receivers, “s41_sdr.txt” for GPS Station-
GNSS SDR
For comparing the sigma -phi index of GPS Station-6 hardware observables with respect to the GNSS SDR, use already stored phase values in a file named ‘phase’ please run the “final_comp_phase.m”
Note: All the satellite’s sigma-phi values are saved in files for both GPS station-6 and GNSS SDR.
Example: “ph4.txt” for GNSS SDR receivers, “hdr4_60.txt' for GPS Station-GNSS SDR receiver’s sigma phi 60 value for SVN-4.
