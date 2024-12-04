# Morse
Team Dot Dash: Morse Code Translator
Team 2 Members: Ezan Khan, Keimaree Smith, Jonathan Thea, Tadiwanashe Zinyongo

We are developing a Morse code translator that allows users to input dots and dashes via push buttons on an FPGA to output letters and numbers.

The user will have the following 5 input buttons on the FPGA where the: left button inputs a dot, center button inputs a dash, top button clears all characters, bottom button deletes one character, right button inputs our sequence of dots & dashes. 

The output will be displayed on our FPGAs 7 segment display.

On the FPGA/hardware side, we will need: 5 buttons (dot, dash, clear, delete, enter) and an eight character 7-segment display

On the Verilog/software side, we will need: Debouncer (5 button inputs), Morse Encoder (store position & input seq), Morse Decoder (turn seq into character), and FSM (output characters to 7-seg display).

Presentation View: https://docs.google.com/presentation/d/15q4PTmuv1oU9G7g7d1FIshKvqw2tgNeB3cpf65LR72M/edit?usp=sharing 
