/*
NAME			:		ASHUTOSH RAJENDRA KARVE
BITS ID		:		2024HT01021
PHONE NO	:		+91 9765541324
DATE			: 	19/10/2024
PLACE			:		PUNE
*/

#include <LPC23xx.h>    // LPC2378 specific header file

void timer_init(void) {
    T0TCR = 0x02;        // Reset Timer 0
    T0PR = 47;           // Set Prescaler to 48 (PCLK/48 = 1 MHz timer clock)
    T0MR0 = 2000000;     // Set Match Register for 2-second delay (2,000,000 ticks)
    T0MCR = 0x03;        // Interrupt and Reset on MR0 (Match Register 0)
    T0TCR = 0x01;        // Start Timer 0
}

int main() {
    timer_init();        // Initialize Timer 0
    while(1);            // Infinite loop to keep the program running
}
