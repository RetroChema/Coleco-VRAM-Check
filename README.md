# Coleco-VRAM-Check
Homebrew for Colecovision VRAM checking


--------

# IMPORTANT NOTICE

The Colecovision Console design is not naming the DRAM Chips as per their binary significant bit. This means the bit stored in the UI0 Chip is not the LSB (2^0 bit) read by the TMS9928A or the Z80 CPU
In the revision of PAL Console I own, the way the chips are conected is as follows:

|Z80 CPU|TMS9928A IN|TMS9928A OUT|DRAM CHIP|
|-------|-----------|------------|----------|
|D0 (14)|CD7 (17)|RD7 (25)|UI1 (14)|
|D1 (15)|CD6 (18)|RD6 (26)|UI3 (14)|
|D2 (12)|CD5 (19)|RD5 (27)|UI5 (14)|
|D3 (8)|CD4 (20)|RD4 (28)|UI7 (14)|
|D4 (7)|CD3 (21)|RD3 (29)|UI0 (14)|
|D5 (9)|CD2 (22)|RD2 (30)|UI2 (14)|
|D6 (10)|CD1 (23)|RD1 (31)|UI4 (14)|
|D7 (13)|CD0 (24)|RD0 (32)|UI6 (14)|

*Number in brackets are the pin number

This means the faulty chips cannot be identified directly by the weigth of the wrong bits. They need to be indentified looking the correct weigth in the CPU, being D0 the LSB and D7 MSB and looking which
chip is conected  to the CPU through the TMS9928A chip.

I would like to think all the console revision were connected in the same way as the one I own, but I cannot be sure of that. Please, check the DRAM chip connections to the TMS9928A  and Z80 CPU before replace any chip in your own consoles.


In my PAL Colecovision Console the chips are disposed in the motherboard as per this distribution

| | |
|--------|--------|
|UI5 - D2|UI7 - D3|
|UI3 - D1|UI0 - D4|
|UI1 - D0|UI4 - D6|
|UI6 - D7|UI2 - D5|
|TMS9928A|TMS9928A|


In my case, I need to substitute the 6SB that was the faulty bit, so I looked for the D6 chip, which is UI4.

I am going to deliver a new version of the software indicating the reference of the faulty chip, but I cannot be sure of all the motherboards releases have exactly the same connections. Pleaase, review this carefully before substitutee any chip!!

----------

This program helps to find out the faulty DRAM Chips between the set of 8 chips included in the Colecovision console

The ROM file can be copied into your multicart and be run like any other ROM homebrew or game

The ROM file was built using CVBasic and GASM80. Thanks, NANOCHESS !!!!!

    CVBASIC github repository    nanochess/CVBasic

    GASM80 github repository     nanochess/gasm80

For compiling, use the following two sentences frm the file directory where the ".bas" file was copied to:

    CVBasic VRAM-Check.bas VRAM-Check.asm

    gasm80 VRAM-Check.asm -o VRAM-Check.rom

Take note you must copy these two files distributed in the CVBasic repository to the same directory where your VRAM-Check.bas file was copied to

    cvbasic_prologue.asm

    cvbasic_epilogue.asm


The rom file VRAM-Check.rom file has been included in this distribution for your convenience if you don.'t want to enter in building details

The program has been tested in a PAL Console. I do not have a way to test it in other models like NTSC, so I will be glad to hear about your 
experience running the test in other video systems or even an ADAM computer.

The program writes different patterns in the VRAM memory, form $0000 to $3FFF, except bytes from $1B00 to $1B7F (128 bytes). The exception was
introduced to avoid some writing/reading conflict experienced, surely because incompatibility with the creen interruptions.

The partterns are written and red and compared, If any difference is found the program shows the difference found, giving the following information:

    Pattern written (decimal format)
    
    Pattern red (decimal format)
    
    XOR between pattern written and red (decimal format)
    
    Memory address (decimal format)

Only 23 first errors are shown in this screen

Once the memory check has finished, the number of total errors in shown in the lower line

Clicking the FIRE BUTTON a second screen is shown, with a sumary of the status of each memory chip (OK or ERROR) depending of the result of the 
complete check. The program can detect problems in one or more than one chip at a time.

Clicking the FIRE BUTTON a second time, the test restarts


And... that's all folks!!!

This program helped me to find out a single DRAM Chip giving problems at my console. I experienced some artifacts when the console was cold that
were disapearing when the console was getting hot.
