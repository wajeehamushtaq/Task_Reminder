
COMMENT;
     TASK REMINDER TO 
	 ADD DATESS
	 AND TASK
	 AND SET REMINDER
	 DISPLAY TASK
	 ;

	 ;*********FILE HANDLING********
	 ;*********START*********

INCLUDE Irvine32.inc

           ; DATA SEGMENT
.data;

filename BYTE "Asm1.txt",0
BUFFER_SIZE = 5000
buffer BYTE BUFFER_SIZE DUP(?)
filehandle DWORD ?
startString BYTE "******************WELCOME TO TASK REMINDER****************",0
string BYTE "Enter the day from 1 to 7 to find your tasks: ",0ah,0dh,0
str1 BYTE BUFFER_SIZE DUP(?)

day DWORD ?
com byte "------------------------------------------------",0ah,0dh,0
strTime BYTE "Enter your timmer in seconds: ",0
time dword ?
rem byte "You need to complete the following task!!",0
startTime DWORD ?
	n word ?
choice WORD ?
convert DWORD 1000
msg1 byte "File Opened Successfully",0 
msg2 byte "File Don't Exist So We Create New File",0
msg3 byte "File closed!",0 

s byte "INVALIDE INPUT",0AH,0DH,0
   msg  dd ?
  sunday    db "12-15-2019,",0ah,0dh,0
  monday    db "12-16-2019,",0ah,0dh,0
  tuesday   db "12-17-2019,",0ah,0dh,0
  wednesday db "12-18-2019,",0ah,0dh,0
  thursday  db "12-19-2019,",0ah,0dh,0
  friday    db "12-20-2019,",0ah,0dh,0
  saturday  db "12-21-2019,",0ah,0dh,0

  sunS db  "math,Chem,Phy# ",0ah,0dh,0
  monS db  "math,eng,comp# ",0ah,0dh,0
  tueS db  "math,isl,comp# ",0ah,0dh,0
  wedS db  "pakStudie,DSA# ",0ah,0dh,0
  ThuS db  "coal,isl,CStw# ",0ah,0dh,0
  friS db  "comp,ppsd,psp# ",0ah,0dh,0
  satS db "isl,twps,calc# ",0ah,0dh,0
  
  daysOfWeek dd sunday, monday,tuesday, wednesday
             dd thursday,friday,saturday,0ah,0dh,0
			
subjOfWeek dd sunS,monS,tueS,weds,ThuS,friS,satS,0ah,0dh,0 
 msg5 byte "DOES NOT WRITE!",0,0ah,0dh
 msg4 byte "WRITE SUCCESSFULLY FILE",0,0ah,0dh
 bytesWritten dword 230 dup(0) 

menu db "Please select a choice:",13,10
     db "1. ADD",13,10
     db "2. ADD REMINDER",13,10
     db "3. FIND",13,10
     db "4. Exit",13,10,0
      ; CODE SEGMENT
.code

;DECLARE THE PROTOTYPE FOR GETLINE FUNCTION
getLine PROTO, line:DWORD, inputStr:PTR BYTE, outputStr:PTR BYTE
;*********MAIN PROCEDURE****
main PROC

mov edx,offset com
call writestring
call crlf

MOV edx,OFFSET startString
	CALL WriteString
	CALL crlf
	;DISPLAYING MENU FOR TASK REMINDER PROGRAM
mov edx,offset com
call writestring
call crlf
display_menu:
  mov  edx, offset menu
  call WriteString
  CALL crlf
  mov edx,offset com
call writestring
call crlf
  CALL READINT
  ;ENTER CHOICE TO SELECT THE MENU ITEM
  MOV choice,ax 

  .IF choice==1
  CALL ADDTASK
	.ENDIF
  .IF choice==2
  CALL ADDREMINDER
   .ENDIF
  .IF choice==3
  jmp FINDTASK
   .ENDIF
   .IF choice>3
   ;cout invalid number
  jmp NEXT
   .ENDIF
  .IF choice<0
  jmp NEXT
   .ENDIF

   ;///////////////////ADD TASK METHOD/////////////////////////////////
   
   ADDTASK:

   call Clrscr;FOR CLEARING SCREEN
   mov edx,offset com
call writestring
call crlf
   ;OPEN THE OUTPUT FILE
   INVOKE CreateFile,ADDR filename,  ; ptr to filename    
GENERIC_WRITE,   ; mode = Can read  
DO_NOT_SHARE,   ; share mode   
NULL,    ; ptr to security attributes 
OPEN_EXISTING,  ; open an existing file  
FILE_ATTRIBUTE_NORMAL, ; normal file attribute    
0    ; not used
   mov filehandle, eax   ; Copy handle to variable 
cmp eax, INVALID_HANDLE_VALUE ; checking if the handle is valid or not 
je Lz  
jne L2  
Lz:   
mov edx,offset msg2   ; Print if the handle is not valid   
call WriteString  
mov edx,OFFSET filename 
call CreateOutputFile
jmp L5 
L2:   
call crlf   
mov edx,offset msg1   ; Print if the handle is valid    
call WriteString 
call crlf
mov filehandle, eax
;SET FILE POINTER TO THE END TO AVOID OVERWRITE
INVOKE SetFilePointer,    fileHandle,  ; file handle   
  0,   ; distance low   
  0,   ; distance high  
  FILE_END
  mov ebx, 0
  mov eax,filehandle
loop_start:
  cmp ebx, 7
  jge loop_end
  mov edx, daysOfWeek[ebx*4]; eax now contains the pointer to the ; next element in the array of days
  mov ecx,12
  call writetofile;CALLING WRITE TO FIE PROCEDURE

    mov eax,filehandle
   mov edx, subjOfWeek[ebx*4]; eax now contains the pointer to the ; next element in the array of days
  mov ecx,14
  call writetofile;CALLING WRITE TO FIE PROCEDURE

   INVOKE SetFilePointer,    fileHandle,  ; file handle   
  5,   ; distance low   
  0,   ; distance high  
  FILE_END
    mov eax,filehandle
  add ebx, 1
  jmp loop_start
loop_end:

 cmp eax,0 ;CHECK IF WRITE SUCCESSFULLY INTO THE FILE
 jle j1
 mov edx,offset msg4
 call writestring
 jmp L3
 j1:
 call writeint 
 mov edx,offset msg5
 call writestring
 jmp L5
;jmp L3  
L3:  
invoke CloseHandle, filehandle ; Calling CloseHandle function        ; to close the file by passing filehandle   
cmp eax, 0    ; eax becomes zero if file is not closed 
jne L4  
je L5 
L4:    
call crlf   
mov edx, offset msg3   ; print file close message   
call writestring 
jmp L5
L5:  
call crlf
mov edx,offset com
call writestring
call crlf
JMP display_menu
; jmp _exit
   ;*************ADD REMINDER*************

   ADDREMINDER:
   call Clrscr 
 
 mov edx,offset com
call writestring
call crlf
   FIND PROTO, line:DWORD, inputStr:PTR BYTE, outputStr:PTR BYTE
	;OPEN INPUT FILE
	MOV edx,OFFSET filename
	CALL OpenInputFile
	MOV filehandle,eax
	;SET FILE POINTER TO THE START OF FILE
	INVOKE SetFilePointer, filehandle, 0,	0,	FILE_BEGIN

	MOV eax,filehandle
	MOV edx,OFFSET buffer
	MOV ecx,BUFFER_SIZE
	CALL ReadFromFile	;READ FROM FILE INTO BUFFER

	MOV edx,OFFSET string
	CALL WriteString	
	;TAKE DAY NUMBER FROM USER
	CALL ReadInt
	MOV day,eax

	INVOKE FIND, day, ADDR buffer, ADDR str1;CALLING GETLINE TO OUTPUT THE SUBJECTS
	MOV edx,OFFSET str1
	CALL WriteString
	CALL ReadInt
	;JMP display_menu
    call crlf 	
	invoke CloseHandle, filehandle ; Calling CloseHandle function        ; to close the file by passing filehandle   
  cmp eax, 0    ; eax becomes zero if file is not closed 
 jne h4  
 je h5 
 h4:    
call crlf   
mov edx, offset msg3   ; print file close message   
call writestring 
jmp h5
h5:  
call crlf
mov edx,offset com
call writestring
call crlf
	MOV edx,OFFSET strTime
	CALL WriteString
	CALL ReadInt
	;********TIMER********
	mul convert; convert seconds into millisecond
	mov ecx, eax 
	mov edx, OFFSET rem
	call GetMSeconds
	mov startTime, eax
L1:
	call crlf
loop L1
	call Clrscr 
mov edx,offset com
call writestring
call crlf
	call GetMseconds;CALLING GETMSECONDS FUNCTION
	sub eax, startTime

	MOV edx,OFFSET rem
	CALL WriteString
	MOV edx,OFFSET str1
	CALL WriteString
	CALL ReadInt
	mov edx,offset com
call writestring
call crlf
	;CALL ReadInt
	call Clrscr 
	mov edx,offset com
call writestring
call crlf
	JMP display_menu

	;********FIND TASK segment**********8
   FINDTASK:
   call Clrscr 
;getLine PROTO, line:DWORD, inputStr:PTR BYTE, outputStr:PTR BYTE
	mov edx,offset com
call writestring
call crlf
MOV edx,OFFSET filename
	CALL OpenInputFile;OPEN INPUT FILE
	MOV filehandle,eax

	INVOKE SetFilePointer, filehandle, 0,	0,	FILE_BEGIN;SET FILE POINTER TO THE BEGINNING

	MOV eax,filehandle
	MOV edx,OFFSET buffer
	MOV ecx,BUFFER_SIZE
	CALL ReadFromFile;CALLING READ FROM FILE TO READ INPUT FILE
	
	mov edx,offset string
	call writestring
	call readint
	mov day,eax;READING DAYS FROM USER
	cmp eax,7;CHECK IF DAYS IS LESS THAN 7
	jg g1  
	INVOKE getLine,day, ADDR buffer, ADDR str1;CALLING GETLINE PROCEDURE TO OUTPUT LINE
	MOV edx,OFFSET str1
	CALL WriteString
	call crlf
	jmp g2
	g1:
	mov edx,offset s
	call writestring
	jmp g2
	;CALL ReadInt
	g2:
	invoke CloseHandle, filehandle ; Calling CloseHandle function        ; to close the file by passing filehandle   
  cmp eax, 0    ; eax becomes zero if file is not closed 
 jne c4  
 je c5 
 c4:    
call crlf   
mov edx, offset msg3   ; print file close message   
call writestring 
jmp c5
c5:  
call crlf
mov edx,offset com
call writestring
call crlf
JMP display_menu
	NEXT:
 exit
main ENDP

; ************** GETLINE FUNCTION **************
getLine PROC uses eax ebx esi, line:DWORD, inputStr:PTR BYTE, outputStr:PTR BYTE
.data
	lineCount DWORD 1
	currChar BYTE ?
.code
	MOV esi,outputStr
	MOV ebx,inputStr

	MOV al,[ebx]
	MOV currChar,al
;*WHILE LOOP
	.WHILE currChar != 032h
		.WHILE currChar != 023h
		;check if the line is desired line then start copying characters until 00dh appears
			MOV eax,line
			.IF lineCount == eax
				MOV al,currChar
				MOV [esi],al
				INC esi
			.ENDIF
			INC ebx
			MOV al,[ebx]
			MOV currChar,al
		.ENDW

		;If the last loop was of desired line, then break main loop.
		MOV eax,line
		.IF	lineCount == eax
			.BREAK
		.ENDIF

		INC lineCount
		ADD ebx,6            ;adding two because to skip 00ah character
		MOV al,[ebx]
		MOV currChar,al
	.ENDW
	RET
getLine ENDP
;**********FIND FUNCTION***********

FIND PROC uses eax ebx esi, line:DWORD, inputStr:PTR BYTE, outputStr:PTR BYTE
.data
	linCount DWORD 1
	cuChar BYTE ?
.code
	MOV esi,outputStr
	MOV ebx,inputStr

	MOV al,[ebx]
	MOV cuChar,al

	.WHILE cuChar != 032h
		.WHILE cuChar != 023h
		;check if the line is desired line then start copying characters until 00dh appears
			MOV eax,line
			.IF linCount == eax
				MOV al,cuChar
				MOV [esi],al
				INC esi
			.ENDIF
			INC ebx
			MOV al,[ebx]
			MOV cuChar,al
		.ENDW

		;If the last loop was of desired line, then break main loop.
		MOV eax,line
		.IF	linCount == eax
			.BREAK
		.ENDIF

		INC linCount
		ADD ebx,6            ;adding two because to skip 00ah character
		MOV al,[ebx]
		MOV cuChar,al
	.ENDW
	RET
FIND ENDP
END main
