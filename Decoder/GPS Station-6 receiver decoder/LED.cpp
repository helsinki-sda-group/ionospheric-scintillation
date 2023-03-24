#include <iostream>
#include <atomic>
#include <csignal>
#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <unistd.h>

int main(int argc, char *argv[])

//build me with gcc LED.cpp -o LED -m64 -lstdc++

{
	
	printf("Welcome to ");
	printf("\033[0;32m"); //set text green
	printf ("L"); printf("\033[0;33m"); //set text yellow
	printf ("E"); printf("\033[0;31m"); //set text red
	printf ("D"); printf("\033[0m"); //set text back to default color
	printf(" the Low Effort Decoder\r\n");
	
	printf("\033[0;34m");
	printf("\e[9mplease enter the name of the file to decode\e[0m\r\n");
	printf("\033[0m");
	printf("\033[0;34m");
	printf("Decoding file outblocks.dat\r\n");
	printf("\033[0m");
	printf("...\r\n");
	
    FILE* fdin;
    FILE* fdoutA;
	FILE* fdoutB;
	FILE* fdoutC;
	FILE* fdoutD;
	FILE* fdouth;
    long lSize;
    uint8_t bufferin[1024*1024]__attribute__((aligned(8)));
	
	int8_t bufferoutA[2793472/4]__attribute__((aligned(8)));
	int8_t bufferoutB[2793472/4]__attribute__((aligned(8)));
	int8_t bufferoutC[2793472/4]__attribute__((aligned(8)));
	int8_t bufferoutD[2793472/4]__attribute__((aligned(8)));

    fdin=fopen("outblocks.dat","r");
    fseek (fdin , 0 , SEEK_END);
    lSize = ftell (fdin);
    rewind (fdin);
	
	fdoutA=fopen("outsamplesA.dat","w");
	fdoutB=fopen("outsamplesB.dat","w");
	fdoutC=fopen("outsamplesC.dat","w");
	fdoutD=fopen("outsamplesD.dat","w");
	fdouth=fopen("outheaders.dat","w");
     
     int first=1;

    long result = fread (bufferin,1,1024*1024,fdin);
    if (result != 1024*1024) {printf("Failed to read full MB of data - got %ld bytes \r\n",result);}
	while(result==1024*1024)
	{
    
		//Confirm synchronization with header pattern
		int64_t* i64ptr=(int64_t*)bufferin;
		if(i64ptr[0]!=0x5341414449465241)
		{
			printf("Header Synchronization Lost\r\n");
			break;
		}
		else
		{
			//printf("Header Synchronization Good\r\n");
		}  
		if(first==1)
		{
			first=0;
			if(bufferin[20]==0)
			{
				printf("3-bit data packing detected\r\n");
			}
			else
			{
				printf("4-bit data packing detected\r\n");
			}
		}
		 
		int bufferoutposA=0;
		int bufferoutposB=0;
		int bufferoutposC=0;
		int bufferoutposD=0;
		int phase=0;
		int index=0;
		uint8_t bytea, byteb, bytec, byted, bytee, bytef, byteg, byteh, bytei, bytej, bytek, bytel;
		int8_t samplearray[8]={1,3,5,7,-7,-5,-3,-1}; //Value mapping
		int8_t samplearray4[16]={1,3,5,7,9,11,13,15,-15,-13,-11,-9,-7,-5,-3,-1}; //Value mapping     
		uint8_t S1,S2,S3,S4,S5,S6,S7,S8;
		if(bufferin[20]&0x01==0)
		{
		for(index=1024; index< 1024*1024; index+=12)
		{    
			//Reorder bytes to take in to account little endian storage format vs. big endian data representation
			bytea=bufferin[index+3];        byteb=bufferin[index+2];        bytec=bufferin[index+1];        byted=bufferin[index+0];
			bytee=bufferin[index+7];        bytef=bufferin[index+6];        byteg=bufferin[index+5];        byteh=bufferin[index+4];
			bytei=bufferin[index+11];       bytej=bufferin[index+10];       bytek=bufferin[index+9];        bytel=bufferin[index+8];
			 
			//Unpack first set of 3 bytes
			S1=(bytea&0xE0)>>5;       S2=(bytea&0x1C)>>2;   S3=(bytea&0x03)<<1;   S3=S3+((byteb&0x80)>>7);
			S4=(byteb&0x70)>>4;       S5=(byteb&0x0E)>>1;    S6=(byteb&0x01)<<2;  S6=S6+((bytec&0xC0)>>6);
			S7=(bytec&0x38)>>3;       S8=(bytec&0x07);

			bufferoutB[bufferoutposB]=samplearray[S8]; bufferoutposB++;
			bufferoutB[bufferoutposB]=-samplearray[S7]; bufferoutposB++;
			bufferoutA[bufferoutposA]=samplearray[S6]; bufferoutposA++;
			bufferoutA[bufferoutposA]=-samplearray[S5]; bufferoutposA++;
			bufferoutD[bufferoutposD]=samplearray[S4]; bufferoutposD++;
			bufferoutD[bufferoutposD]=-samplearray[S3]; bufferoutposD++;
			bufferoutC[bufferoutposC]=samplearray[S2]; bufferoutposC++;
			bufferoutC[bufferoutposC]=-samplearray[S1]; bufferoutposC++;
					 
			//Unpack second set of 3 bytes
			S1=(byted&0xE0)>>5;       S2=(byted&0x1C)>>2;   S3=(byted&0x03)<<1;   S3=S3+((bytee&0x80)>>7);
			S4=(bytee&0x70)>>4;       S5=(bytee&0x0E)>>1;    S6=(bytee&0x01)<<2;  S6=S6+((bytef&0xC0)>>6);
			S7=(bytef&0x38)>>3;           S8=(bytef&0x07);
			 
			bufferoutB[bufferoutposB]=samplearray[S8]; bufferoutposB++;
			bufferoutB[bufferoutposB]=-samplearray[S7]; bufferoutposB++;
			bufferoutA[bufferoutposA]=samplearray[S6]; bufferoutposA++;
			bufferoutA[bufferoutposA]=-samplearray[S5]; bufferoutposA++;
			bufferoutD[bufferoutposD]=samplearray[S4]; bufferoutposD++;
			bufferoutD[bufferoutposD]=-samplearray[S3]; bufferoutposD++;
			bufferoutC[bufferoutposC]=samplearray[S2]; bufferoutposC++;
			bufferoutC[bufferoutposC]=-samplearray[S1]; bufferoutposC++;
					 
			//Unpack third set of 3 bytes
			S1=(byteg&0xE0)>>5;       S2=(byteg&0x1C)>>2;   S3=(byteg&0x03)<<1;   S3=S3+((byteh&0x80)>>7);
			S4=(byteh&0x70)>>4;       S5=(byteh&0x0E)>>1;    S6=(byteh&0x01)<<2;  S6=S6+((bytei&0xC0)>>6);
			S7=(bytei&0x38)>>3;           S8=(bytei&0x07);
			 
			bufferoutB[bufferoutposB]=samplearray[S8]; bufferoutposB++;
			bufferoutB[bufferoutposB]=-samplearray[S7]; bufferoutposB++;
			bufferoutA[bufferoutposA]=samplearray[S6]; bufferoutposA++;
			bufferoutA[bufferoutposA]=-samplearray[S5]; bufferoutposA++;
			bufferoutD[bufferoutposD]=samplearray[S4]; bufferoutposD++;
			bufferoutD[bufferoutposD]=-samplearray[S3]; bufferoutposD++;
			bufferoutC[bufferoutposC]=samplearray[S2]; bufferoutposC++;
			bufferoutC[bufferoutposC]=-samplearray[S1]; bufferoutposC++;
			 
			//Unpack fourth set of 3 bytes
			S1=(bytej&0xE0)>>5;       S2=(bytej&0x1C)>>2;   S3=(bytej&0x03)<<1;   S3=S3+((bytek&0x80)>>7);
			S4=(bytek&0x70)>>4;       S5=(bytek&0x0E)>>1;    S6=(bytek&0x01)<<2;  S6=S6+((bytel&0xC0)>>6);
			S7=(bytel&0x38)>>3;           S8=(bytel&0x07);
			 
			bufferoutB[bufferoutposB]=samplearray[S8]; bufferoutposB++;
			bufferoutB[bufferoutposB]=-samplearray[S7]; bufferoutposB++;
			bufferoutA[bufferoutposA]=samplearray[S6]; bufferoutposA++;
			bufferoutA[bufferoutposA]=-samplearray[S5]; bufferoutposA++;
			bufferoutD[bufferoutposD]=samplearray[S4]; bufferoutposD++;
			bufferoutD[bufferoutposD]=-samplearray[S3]; bufferoutposD++;
			bufferoutC[bufferoutposC]=samplearray[S2]; bufferoutposC++;
			bufferoutC[bufferoutposC]=-samplearray[S1]; bufferoutposC++;
			 
			 
		}
			
		 
		 
		
		fwrite(bufferoutA,1,2793472/4,fdoutA);
		fwrite(bufferoutB,1,2793472/4,fdoutB);
		fwrite(bufferoutC,1,2793472/4,fdoutC);
		fwrite(bufferoutD,1,2793472/4,fdoutD);
		fwrite(bufferin,1,1024,fdouth);
		} //3 bit data
		else
		{
		for(index=1024; index< 1024*1024; index+=4)
		{    
			//Reorder bytes to take in to account little endian storage format vs. big endian data representation
			bytea=bufferin[index+3];        byteb=bufferin[index+2];        bytec=bufferin[index+1];        byted=bufferin[index+0];
			 
			//Unpack 4 bytes
			S1=(bytea&0xF0)>>4;     S2=(bytea&0x0F);   	
			S3=(byteb&0xF0)>>4;	S4=(byteb&0x0F);       
			S5=(bytec&0xF0)>>4;   	S6=(bytec&0x0F);  	
			S7=(byted&0xF0)>>4;	S8=(byted&0x0F);

			bufferoutB[bufferoutposB]=samplearray4[S8]; bufferoutposB++;
			bufferoutB[bufferoutposB]=-samplearray4[S7]; bufferoutposB++;
			bufferoutA[bufferoutposA]=samplearray4[S6]; bufferoutposA++;
			bufferoutA[bufferoutposA]=-samplearray4[S5]; bufferoutposA++;
			bufferoutD[bufferoutposD]=samplearray4[S4]; bufferoutposD++;
			bufferoutD[bufferoutposD]=-samplearray4[S3]; bufferoutposD++;
			bufferoutC[bufferoutposC]=samplearray4[S2]; bufferoutposC++;
			bufferoutC[bufferoutposC]=-samplearray4[S1]; bufferoutposC++;
			fwrite(bufferoutA,1,523776,fdoutA);
			fwrite(bufferoutB,1,523776,fdoutB);
			fwrite(bufferoutC,1,523776,fdoutC);
			fwrite(bufferoutD,1,523776,fdoutD);
			fwrite(bufferin,1,1024,fdouth); 
		} //end for 
		} //4 bit data
		
		
		//Read next block
		result = fread (bufferin,1,1024*1024,fdin);
		
		
	}
	fclose(fdin);
	fclose(fdoutA);
	fclose(fdoutB);
	fclose(fdoutC);
	fclose(fdoutD);
	fclose(fdouth);
    return 0;
}
