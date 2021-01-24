TITLE Project2 Program(template.asm)

; Author: Senna Titcomb
; Last Modified : 1 / 23 / 2021
; OSU email address : titcombs@oregonstate.edu
; Course number / section: 271 / 001
; Assignment Number : Program 2                Due Date : Jan 24
; Description: Write a program to calculate Fibonacci numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
; (insert variable definitions here)
	titlemessage BYTE "Fibonnaci Numbers by Senna Titcomb", 0dh, 0ah, 0
	namemessage BYTE "What's your name?", 0dh, 0ah, 0
	greeting BYTE "Hello, ", 0
	instruction1 BYTE "Enter the number of Fibonacci terms to be displayed.", 0
	instruction2 BYTE "Provide the number as an integer in the range [1 .. 46].", 0
	getvalue BYTE "How many Fibonacci terms do you want? ", 0
	error BYTE "Out of range. Enter a number in [1 .. 46]", 0dh, 0ah, 0
	result BYTE "Results certified by Senna Titcomb", 0dh, 0ah, 0
	goodbye BYTE "Goodbye, ", 0
	alignment BYTE "     |", 0
	usernamebuffer BYTE 21 DUP(0)
	username BYTE 21 DUP(0)
	value SDWORD ?
	storedval DWORD 0
	upperlimit DWORD 46
	lowerlimit DWORD 0
	counter DWORD 0
	

.code
main PROC
	call Clrscr

; print titlemessage
	mov edx, OFFSET titlemessage
	call WriteString

; print namemessage and get username
	mov edx, OFFSET namemessage
	call WriteString
	call Crlf
	mov edx, OFFSET greeting  ;print greeting
	call WriteString
	mov edx, OFFSET username
	mov ecx, SIZEOF usernamebuffer	;specifies max characters
	call ReadString			;takes username

; print instructions
	mov edx, OFFSET instruction1
	call WriteString
	call Crlf
	mov edx, OFFSET instruction2
	call WriteString
	call Crlf
	
; is input valid?

validLoop: 
		mov edx, OFFSET getvalue
		call WriteString
		call ReadInt
		mov value, eax
		mov eax, value
		cmp eax, lowerlimit		;is value greater than 1?
		jle invalid			;less than jump to error
		cmp eax, upperlimit		;is value less than 47?
		jge invalid			;greater than jump to error message
		mov eax, 0
		mov ebx, 1
		mov ecx, value
		jmp fibLoop			;valid num jump to calculation
	invalid:
		mov edx, OFFSET error
		call WriteString
		jmp validLoop	;posttest go to top

; calculate Fibonacci

counterloop:	; prints 4 values per row
		call Crlf
		mov counter, 0
		dec ecx 
		jmp fibLoop 

fibLoop:
		mov storedval, eax		;store past value
		add eax, ebx			;combine values 
		mov ebx, storedval		;change to past value
		mov edx, OFFSET alignment	;alignment of values
		call WriteString
		call WriteDec			;print value
		inc counter
		cmp counter, 4
		jge counterloop
		loop fibLoop
			

;print goodbye to user
	call Crlf
	mov edx, OFFSET result
	call WriteString
	mov edx, OFFSET goodbye
	call WriteString
	mov edx, OFFSET username
	call WriteString


; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
