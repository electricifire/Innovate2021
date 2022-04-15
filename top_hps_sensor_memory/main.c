#include <stdio.h>
#include <unistd.h>
#include <fcntl.h> 
#include <sys/mman.h> 
#include "hwlib.h" 
#include <time.h>
#include "socal/socal.h"
#include "socal/hps.h" 
#include <sys/types.h>
#include <sys/stat.h>
#include "socal/alt_gpio.h"
#include "hps_0.h"


#define REG_BASE 0xFF200000
#define REG_SPAN 0x00200000

void* virtual_base;
void* led_addr;
void* sw_addr;
void* ba_curr_addr;
void* ba_volt_addr;
void* pv_curr_addr;
void* pv_volt_addr;
void* vgr_volt_addr;
void* vgs_volt_addr;
void* vgt_volt_addr;
void* vgr_curr_addr;
void* vgs_curr_addr;
void* vgt_curr_addr;
void* phase_addr;
int fd, fc;
int switches;
//electrical parameters from memory
int sbacurrent,sbavoltage;
int spvcurrent,spvvoltage;
int svgr_voltage,svgs_voltage, svgt_voltage;
int svgr_current,svgs_current, svgt_current;
int sphase;
char dir[150];
char direccion[150];
char a[150];
char as[10000]="";
char module[5] = "m01";
int status;
double p=0;

int main (){

time_t ltime; 
double seconds;
double usec=0;

//double execute_sec;
//double seconds2;	
//struct tm *mitiempo = localtime(&ltime);

char parameters[25] = "electrical_parameters";

/*
	struct tm{
			int tm_sec;
			int tm_min; 
			int tm_hour; 
	}
	*/
	
//seconds = (mitiempo->tm_hour*60*60)+(mitiempo->tm_min*60)+(mitiempo->tm_sec);

//printf("\nThe time is %s\n", ctime(&ltime));
status = mkdir("/home/root/data",S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);		
//printf("\nThe time in seconds is: %.f\n", seconds);
//cast 


fd=open("/dev/mem",(O_RDWR|O_SYNC));
virtual_base=mmap(NULL,REG_SPAN,(PROT_READ|PROT_WRITE),MAP_SHARED,fd,REG_BASE);
sw_addr=virtual_base+SW_BASE;
led_addr=virtual_base+LED_BASE;
ba_curr_addr=virtual_base+BACURRENT_BASE;
ba_volt_addr=virtual_base+BAVOLTAGE_BASE;
pv_curr_addr=virtual_base+PVCURRENT_BASE;
pv_volt_addr=virtual_base+PVVOLTAGE_BASE;
vgr_volt_addr=virtual_base+VGR_VOLTAGE_BASE;
vgs_volt_addr=virtual_base+VGS_VOLTAGE_BASE;
vgt_volt_addr=virtual_base+VGT_VOLTAGE_BASE;
vgr_curr_addr=virtual_base+VGR_CURRENT_BASE;
vgs_curr_addr=virtual_base+VGS_CURRENT_BASE;
vgt_curr_addr=virtual_base+VGT_CURRENT_BASE;
phase_addr=virtual_base+PHASE_BASE;


printf("Hello world, from Linux mounted on SD card\n");

while(1){
seconds = time(&ltime);
sprintf(dir,"/home/root/data/%s_%s_%.f.txt",module,parameters,seconds);

switches=*(uint32_t *)sw_addr;
*(uint32_t *)led_addr=switches;
sbacurrent = *(uint32_t *)ba_curr_addr;
sbavoltage = *(uint32_t *)ba_volt_addr;
spvcurrent = *(uint32_t *)pv_curr_addr;
spvvoltage = *(uint32_t *)pv_volt_addr;
svgr_voltage = *(uint32_t *)vgr_volt_addr;
svgs_voltage = *(uint32_t *)vgs_volt_addr;
svgt_voltage = *(uint32_t *)vgt_volt_addr;
svgr_current = *(uint32_t *)vgs_curr_addr;
svgs_current = *(uint32_t *)vgr_curr_addr;
svgt_current = *(uint32_t *)vgt_curr_addr;
sphase = *(uint32_t *)phase_addr;
//printf("Electrical parameters:\n");
//printf(".Battery current:\t\t\t%u \n",sbacurrent);
//printf(".Battery voltage:\t\t\t%u \n",sbavoltage);
//printf(".PV current:\t\t\t%u \n",spvcurrent);
//printf(".PV voltage:\t\t\t%u \n",spvvoltage);
//printf(".grid voltage R line:\t\t\t%u \n",svgr_voltage);
//printf(".grid voltage S line:\t\t\t%u \n",svgs_voltage);
//printf(".grid voltage T line:\t\t\t%u \n",svgt_voltage);
//printf(".grid current R line:\t\t\t%u \n",svgr_current);
//printf(".grid current S line:\t\t\t%u \n",svgs_current);
//printf(".grid current T line:\t\t\t%u \n",svgt_current);
//printf(".phase:\t\t\t%u \n",sphase);

//printf(".SW: %u\n",switches);
//printf("%i\n",(int)seconds);


if((int)seconds%60==0){
	
	usec = 0;
	//p=p+1;
	
	//if(p==2){
	//	p = 1; 
	//}	
	
	//printf("\nSe creo el archivo del tiempo: %s\n", ctime(&ltime));	
	fc=open(dir,O_WRONLY|O_CREAT,S_IRUSR|S_IWUSR);
	sprintf(direccion,"%s",dir);
	sprintf(a,"%.f,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u\n",seconds,sbacurrent,sbavoltage,spvcurrent,spvvoltage,svgr_voltage,svgs_voltage,svgt_voltage,svgr_current,svgs_current,svgt_current,sphase);	
	write(fc,a,sizeof(a));
	close(fc);
	
	//contien el archivo creado en la primera muestra
	/*if(p==1){
	sprintf(a,"%.f,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u\n",seconds,sbacurrent,sbavoltage,spvcurrent,spvvoltage,svgr_voltage,svgs_voltage,svgt_voltage,svgr_current,svgs_current,svgt_current,sphase);	
	write(fc,a,sizeof(a));
	close(fc);
	}*/
	
}
else{
	//if (p==1){
	usec = usec +1;
	fc=open(direccion,O_APPEND|O_WRONLY,S_IRUSR|S_IWUSR);
	sprintf(a,"%.6f,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u\n\r",seconds+usec/1000000,sbacurrent,sbavoltage,spvcurrent,spvvoltage,svgr_voltage,svgs_voltage,svgt_voltage,svgr_current,svgs_current,svgt_current,sphase);	
	//printf(direccion);
	printf(a);
	write(fc,a,sizeof(a));
	close(fc);
	//}
}

usleep(8000);

}
return 0;
}