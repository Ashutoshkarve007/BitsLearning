/*
Name		:		Ashutosh Rajendra Karve
Bits-ID	:   2024HT01021
Phone no:		+91 9765541324
Date		:		17-10-2024

*/

#include <LPC23xx.h>    // Include LPC2378 header file

// Declare adc_value as a global variable
unsigned int adc_value;

void ADC_Init(void) {
    // Set PINSEL1 for ADC0.0 (P0.23)
    PINSEL1 |= (1 << 14); // Configure P0.23 as AD0.0

    // ADC Control Register setup
    AD0CR = (1 << 0)   // Select AD0.0
          | (4 << 8)   // ADC clock = PCLK/5
          | (1 << 21); // Enable ADC

    // Power on the ADC
    PCONP |= (1 << 12); // Power up ADC
}

unsigned int ADC_Read(void) {
    AD0CR |= (1 << 24);        // Start conversion
    while (!(AD0GDR & (1 << 31)));  // Wait for conversion to complete
    return (AD0GDR >> 4) & 0xFFF;   // Return 12-bit result
}

int main() {
    //unsigned int adc_value;
    
    ADC_Init(); // Initialize ADC

    while (1) {
        adc_value = ADC_Read(); // Read ADC value from AD0.0
        // Here, you would typically send adc_value to UART for display
        // For demonstration purposes, we assume a logging mechanism
    }
}
