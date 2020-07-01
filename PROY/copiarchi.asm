.MODEL SMALL
.STACK
.DATA
 ;variables
 msj1 db "DIGITE EL NOMBRE DEL ARCHIVO A COPIAR: ","$";
 db 13,10,13,10,"$"
 msj2 db "DIGITE EL NOMBRE DE LA COPIA:","$";
 db 13,10,13,10,"$"
 msjs db "ARCHIVO COPIADO EXITOSAMENTE $";
 msje db "OPERACION FALLIDA$";
 salto DB 13,10,'$'
 captura DB 60 DUP (0)
 captura2 DB 60 DUP (0)
 manejae dw ?
 manejas dw ?
 ncar db 60 dup('')

.code

;PARA COPIAR ARCHIVO
Copiar MACRO archivo
cld 
mov cl,60
xor ch,ch
mov si,60 
mov di,offset archivo 
rep movsb 
xor al,al 
stosb    
ENDM

public _copiarchi
_copiarchi proc
inicio:
mov ax,@DATA
mov ds,ax  

mov ah,09h
mov dx,offset msj1
int 21h
call lee
mov ah,09h
mov dx,offset salto
int 21h
Copiar captura

mov ah,09h
mov dx,offset msj2
int 21h
call lee2
mov ah,09h
mov dx,offset salto
int 21h
Copiar captura2

mov ax,3d00h            ;apertura archivo origen
mov dx,offset captura
int 21h
mov [manejae],ax
;Creamos archivo destino
mov ah,3ch
xor cx,cx
mov dx,offset captura2
int 21h

mov [manejas],ax    
          ;Primero, lee Maxima_Longitud_Abrir bytes
          mov ah,3fh
          mov bx,[manejae]
          mov cx,60
          MOV dx,offset ncar
          int 21h
          ;Guarda el número de bytes leídos
          push ax
          ;Ahora escribe los bytes leídos
          mov cx,cx
          mov ah,40h
          mov bx,[manejas]
          mov dx,offset ncar
          int 21h
          pop ax
          cmp ax,60
salir:
mov ax,4c00h
int 21h

;Etiquetas para capturar cadenas

 ;captura1
 lee:
 LEA DX,captura             ; Puntero a la direccion para la entrada
 MOV BYTE PTR [captura],60  ; Fijamos los 60 caracteres
 MOV AH,10                  ; funcion de entrada de teclado
 INT 21h                    ; LLamar a la interrupcion del DOS
 MOV BL,[captura+1]         ; Esta es la longitud efectiva tecleada
 MOV BH,0                   ; cargada nuestra direccion
 ADD BX,OFFSET captura      ; apuntamos al final
 MOV BYTE PTR [BX+2],0      ; ponemos el cero al final
 ret

 ;captura2
 lee2:
 LEA DX,captura2            ; Puntero a la direccion para la entrada
 MOV BYTE PTR [captura2],60 ; Fijamos los 60 caracteres
 MOV AH,10                  ; funcion de entrada de teclado
 INT 21h                    ; LLamar a la interrupcion del DOS
 MOV BL,[captura2+1]        ; Esta es la longitud efectiva tecleada
 MOV BH,0                   ; cargada nuestra direccion
 ADD BX,OFFSET captura2     ; apuntamos al final
 MOV BYTE PTR [BX+22],0     ; ponemos el cero al final
 ret

 end inicio
_copiarchi endp
end