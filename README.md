# Morse
**Team Dot Dash: Morse Code Translator**

Team 2 Members: Ezan Khan, Keimaree Smith, Jonathan Thea, Tadiwanashe Zinyongo

Watch our demo video here: Lorem ipsum

We have designed a Morse code translator that allows users to input dots and dashes using push buttons on an FPGA. The translated letters and numbers are displayed on both the FPGA’s 7-segment display and a connected computer monitor.

**User Inputs**
The FPGA will feature five input buttons:
1. Left Button: Inputs a dot.
2. Center Button: Inputs a dash.
3. Top Button: Clears all characters.
4. Bottom Button: Deletes the last character.
5. Right Button: Confirms the sequence of dots and dashes for translation.

**Outputs**
FPGA Display: The 7-segment display will show up to 8 characters in sequence.
Computer Monitor: The most recent character will be displayed with indexed positioning to indicate its place in the sequence.

**Hardware Requirements**
1. Five input buttons for dot, dash, clear, delete, and enter.
2. Two 4-character 7-segment displays on the FPGA.
3. A monitor connected to the FPGA. 

**Software Modules**
1. Debouncer: Processes input from the 5 buttons.
2. Morse Encoder: Tracks input position and stores the sequence.
3. Morse Decoder: Converts the sequence into characters for the 7-segment display.
4. FSM (Finite State Machine): Manages character output to the 7-segment display.
5. Clock Divider: Synchronizes the VGA refresh rate.
6. ASCII_ROM: Converts input sequence into ASCII characters for VGA display.
7. Last Letter: Handles character positioning for the VGA output.
8. VGA Controller: Outputs characters to the monitor.
9. VGA_Top: Serves as the top module, integrating all other modules.

**How to Run Our Project**
1. Lorem ipsum
