# Coleco-VRAM-Check
Homebrew for Colecovision VRAM checking

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
