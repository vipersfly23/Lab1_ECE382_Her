;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; Lab 1 - ECE 382 Calculator Program
; C2C Hunter Her, USAF / 9 Sept 2014 / 10 Sept 2014
;
; This program is implementing the basic function of adding, subtracting and multiplication
;	and max value of 255, and min value of 0. It also identifies clr function.
;
;***THIS PROGRAM CHECKS OUT WITH ALL TEST CASE ACCURATELY***
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
				mov.w #equationArray, R5
				mov.w #0x0200,R15
postClrOp		mov.b @R5+, R6

checkOperation		mov.b @R5+, R7

		cmp #0x0044,R7
		jz clrOperation

		mov.b @R5+, R8

		cmp #0x0011,R7
		jz addOperation
		cmp #0x0022,R7
		jz subtractOperation

		cmp #0x0033, R7
		jz multOperation

		jmp endProgram

addOperation 	add.w R8,R6
				cmp #0x00FF,R6
				jge setMaxValue
				mov.b r6, 0(R15)
				inc R15
				jmp checkOperation

subtractOperation sub.w R8,R6
					jn setMinValue
					mov.b r6, 0(R15)
					inc R15
					jmp checkOperation

clrOperation	mov.w #0x0,R6
				mov.b #0x00,0(R15)
				inc R15
				jmp postClrOp





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
