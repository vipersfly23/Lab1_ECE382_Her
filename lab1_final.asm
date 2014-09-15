;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lab 1 - ECE 382 Calculator Program
; C2C Hunter Her, USAF / 9 Sept 2014 / 10 Sept 2014
;
; This program is implementing the basic function of adding, subtracting and multiplication
;	and max value of 255, and min value of 0. It also identifies clr function.
;
;***THIS PROGRAM CHECKS OUT WITH ALL TEST CASE ACCURATELY, A FUNCTIONALITY***
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;*************DR. COULSTON, INSERT HERE************************
.text
equationArray .byte			0x22, 0x11, 0x22, 0x22, 0x33, 0x33, 0x08, 0x44, 0x08, 0x22, 0x09, 0x44, 0xff, 0x11, 0xff, 0x44, 0xcc, 0x33, 0x02, 0x33, 0x00, 0x44, 0x33, 0x33, 0x08, 0x55


;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
				mov.w #equationArray, R5 	; R5 points to the beginning of the Array
				mov.w #0x0200,R15			; R15 stores the memory location of where to store the results
postClrOp		mov.b @R5+, R6				; First number is loaded into R6. R6 will act as the accumulator as well.
											; R5 is incremented and now points to the operation.
checkOperation		mov.b @R5+, R7			; R7 stores the operation.

		cmp #0x0044,R7						; Checks to see if the operation is CLR_OP first
		jz CLR_OP						; IF it is CLR_OP, program will jump the CLR_OP code

		mov.b @R5+, R8						; If there isn't a clear operation, next number is stored into R8
											; R5 is now pointing at the next number operation.
		cmp #0x0011,R7						; Checks to see if it is ADD_OP
		jz ADD_OP						; if so jump to ADD_OP code
		cmp #0x0022,R7						; Checks to see if it is SUB_OP
		jz SUB_OP				; if so, jump to SUB_OP Code

		cmp #0x0033, R7						; Checks to see if it is MUL_OP
		jz MUL_OP					; If so, jump to MUL_OP code

		jmp endProgram						; If nothing matches, program is terminated. 0x55 should be the indcator but this program
											; by doing this, entering an invalid operation would also terminate the program.
ADD_OP 	add.w R8,R6							; checks to see if it is an ADD_OP
				cmp #0x00FF,R6
				jge setMaxValue
				mov.b r6, 0(R15)
				inc R15
				jmp checkOperation

SUB_OP sub.w R8,R6							; checks to see if it is a SUB_OP
					jn setMinValue
					mov.b r6, 0(R15)
					inc R15
					jmp checkOperation

CLR_OP	mov.w #0x0,R6							; checks to see if it is a CLR_OP
				mov.b #0x00,0(R15)
				inc R15
				jmp postClrOp

MUL_OP	mov.w R6, R9							; checks to see if it is a MUL_OP
				mov.w R8, R10
				AND.w #0x0001, R10

multCheck		cmp.w #0x0001, R8
				jz endMUL_OP
				cmp.w #0x0, R8
				jz valueMultZero

				rra R8
				rla R9
				jmp multCheck

setMaxValue		mov.w #0x00FF, R6
				mov.b r6, 0(R15)
				inc R15
				jmp checkOperation

setMinValue 	mov.w #0x0000, R6
				mov.b r6, 0(R15)
				inc R15
				jmp checkOperation



valueIsOdd		add.w R6,R9
				clrz
				dec R8

				jmp endMultOdd
valueMultZero
					mov.w #0x00, R6
					mov.b r6, 0(R15)
					inc R15
					jmp checkOperation

endMUL_OP	cmp.w #0x0001, R10
					jz valueIsOdd
endMultOdd			mov.w R9, R6
					cmp #0x00FF,R6
					jge setMaxValue
					clrn
					jn setMinValue
					mov.b r6, 0(R15)
					inc R15
					jmp checkOperation


endProgram	jmp endProgram

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET

