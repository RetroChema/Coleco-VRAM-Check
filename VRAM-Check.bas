	'
	' VRAM test V2.2
	'
	' by RetroChema
	' https://
	'
	' Creation date: Mar/03/2026.
	' Revision date: Mar/05/2026 v2
	' Revision date: Mar/10/2026 v2.1 Clean the array where the chips are marked as OK or ERROR in each new test execution
	' Revision date: Mar/15/2026 v2.2 Adding the chip name to the final brief of chip status, avoiding confusion between the faulty bit and the faulty chip	(Please, read REAME.md carefully!!!!
	
	CONST FIREBTNCODE = 64
	CONST CHR_ROW = 32
	
	CONST NUMBITS = 8
	DIM BITS(NUMBITS)
	
CHIPNAMES:
	DATA BYTE 1,3,5,7,0,2,4,6
	
	CONST NUMPATTERNS = 2	'Define the number of patterns to be used in the tests
PATTERNS:
	DATA BYTE &10101010,&01010101		'Define binary partterns here

	
	MODE 2		' Color for sets of 8 characters.

	VPOKE $2003, $E1	' Color for characters $18-$1f
	VPOKE $2004, $F4	' $20-$27
	VPOKE $2005, $1F	' $28-$29	'Numbers in Inverse Video
	VPOKE $2006, $1F	' $30-$37	'Numbers in Inverse Video
	VPOKE $2007, $1F	' $38-$3f	'Numbers in Inverse Video
	VPOKE $2008, $F4	' $40-$47
	VPOKE $2009, $F4	' $48-$4f
	VPOKE $200A, $F4	' $50-$57
	VPOKE $200B, $F4	' $58-$5f
	VPOKE $200C, $F4	' $60-$67
	VPOKE $200D, $F4	' $68-$6f
	VPOKE $200E, $F4	' $70-$77
	VPOKE $200F, $F4	' $78-$7f
	
	VDP(1) = $E0	' 8x8 sprites
	VDP(6) = $00	' Sprites use character bitmaps.

	P = 0.	'P keeps the binary pattern to be checked in each cell of the VRAM
	
	GOSUB CLEAN_CHIP_STATUS

	WHILE(1)
	
		GOSUB CLEAR_SCRN

		#N=0	'Number of errors found during the 16Kbytes test
		
		FOR #C = $0000 TO $3FFF		'VRAM memory map
		
			IF (#C>=$1B00 AND #C<=$1B7F) THEN	'Bytes $1B00 to $1B7F are not checked because they are used by the screen refresh
				#C=#C+$0080
			END IF
			
			FOR D=0 TO NUMPATTERNS-1		'Applies as much patters as defined (in version v2 two patters are used
			
				P = PATTERNS(D)
	
				A = VPEEK(#C)	'Store the original byte before writing data in the address		
				VPOKE #C,P		'Writes the binary pattern in the address
				R = VPEEK(#C)	'Reads the patter written before
				VPOKE #C,A		'Restores the original data in the address
				
'IF (#C >= 12000) AND (#C <= 12003) AND (D=1) THEN	'This is only for program testing purposes
'	R=&00100011	'This is only for program testing purposes
'END IF	'This is only for program testing purposes

				X = R XOR P		'Compares pattern written and pattern read. If not zero, there is an error

				IF X THEN		'If not zero, then error, shows a message
						#N=#N+1		'Increases the number of total errors
						IF (#N<23) THEN		'Only shows first 23 error messages on the screen, to avoid scrolling						
							PRINT AT #N*CHR_ROW+0,"Writ",<.3>P," Read",<.3>R," Xor",<.3>X," Add",<.5>#C
						END IF
						
						'Marks chips having errors
						V=1
						FOR I=0 TO NUMBITS-1
							IF (X AND V) THEN
								BITS(I) = 1
							END IF
							V=V*2
						NEXT I
				END IF
				
				
			NEXT D
				
			PRINT AT 23*CHR_ROW+27,#C	'Shows the memory address checked in the rigth botton
		
		NEXT #C

		PRINT AT 23*CHR_ROW+0,"N ERR ",<5>#N," -PRESS FIRE-"	'Shows the total number of errors detected
	
		'Pressing and depressing FIRE the screen changes to show the errors by memory chip
		GOSUB FIRE_BTN_CLAMP
		GOSUB CLEAR_SCRN

		GOSUB PRINT_CHIP_STATUS
		
		PRINT AT 23*CHR_ROW+0,"N ERR ",<5>#N," -PRESS FIRE-"

		GOSUB FIRE_BTN_CLAMP
		GOSUB CLEAN_CHIP_STATUS
		
	
	WEND
	
	
	
	
	FIRE_BTN_CLAMP: PROCEDURE		'Waits until FIRE button in pressed and depressed
	
		DO	'Waits pressed
		LOOP UNTIL (cont1.button = FIREBTNCODE)

		DO	'Waits depressed
		LOOP UNTIL (cont1.button <> FIREBTNCODE)
	
	END
	
	
	
	CLEAR_SCRN: PROCEDURE		'
	
		FOR #L =0 TO 32*24-1
			PRINT AT #L," "
		NEXT #L
		
		PRINT AT 0,"VRAM Check by RetroChema'26 v2.2"

	
	END
	

	PRINT_CHIP_STATUS: PROCEDURE		'

		FOR I=0 TO NUMBITS-1
			IF (BITS(I)=0) THEN
				PRINT AT I*CHR_ROW+64,"CHIP U1",CHIPNAMES(I)," BIT ",<.1>I," OK"
			ELSE
				PRINT AT I*CHR_ROW+64,"CHIP U1",CHIPNAMES(I)," BIT ",<.1>I," ERROR"			
			END IF
		NEXT I


	END

	CLEAN_CHIP_STATUS: PROCEDURE		'

		FOR I=0 TO NUMBITS-1
			
			BITS(I)=0

		NEXT I

	END

