/* 
NAME			: Ashutosh Rajendra Karve
BITS ID 	: 2024ht01021
PHONE NO	: +91 9765541324
DATE			: 19-10-2024
PLACE			: PUNE
*/
#include <stdint.h>
#include "lcd.h"
#include <lpc23xx.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// Function for delay
void wait(int time) {
    int i, j;
    for (i = 0; i < time; i++)
        for (j = 0; j < 1000; j++);
}
int main() {
    char voltage_display[20] = "";
    uint32_t adc_value = 0;
    float voltage = 0;  
    PCONP |= (1 << 12);    	 		// Initialize the ADC    
    PINSEL1 |= (1 << 14);       // Configuring P0.23 as AD0.0
    PINSEL1 &= ~(1 << 15);     
    AD0INTEN |= (1 << 0);       // Enabling interrupt for AD0.0
    // Configure the ADC: select AD0.0, 4 MHz clock, 10-bit resolution, operational mode
    AD0CR &= ~(1 << 0);        // Clear the channel select bits
    AD0CR |= (1 << 9);         // Set the clock divider to achieve a 4 MHz clock
    AD0CR |= (1 << 16);        // Disable BURST mode (manual control)
    AD0CR |= (1 << 21);        // Enable the ADC
    // Initialize the LCD
    lcd_init();
    lcd_clear();
	
    set_cursor(0, 0);					// Displaying BITS ID on the first row
    lcd_print((unsigned char *)"BITS 2024HT01021");

    while (1) {
        set_cursor(0, 1);
        while (!(AD0STAT & (1 << 0))) {};				        				// Wait for the ADC conversion to complete
				adc_value = (AD0DR0 & 0x0000FFC0) >> 6;					        // Retrieve the ADC result
        voltage = ((adc_value / 1023.0) * 3.3);									// Convert the ADC value to voltage
				sprintf(voltage_display, "Voltage : %.2fV ", voltage);		        // Format the voltage as a string for display
        lcd_print((const unsigned char *)voltage_display);			// Display the voltage and date on the second row
				lcd_print((const unsigned char *)"Date: 19/10");
        wait(1);
    }
}
