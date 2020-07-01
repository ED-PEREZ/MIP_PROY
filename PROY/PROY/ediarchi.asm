.MODEL SMALL
.STACK
.DATA

 ;variables
 msj1 db "DIGITE EL NOMBRE DEL ARCHIVO:","$";
 db 13,10,13,10,"$"
 msj2 db "DIGITE TEXTO:","$";
 db 13,10,13,10,"$"
 msj3 db "ARCHIVO MODIFICADO EXITOSAMENTE $";
 salto DB 13,10,'$'
 captura DB 60 DUP (0)
 captura2 DB 60 DUP (0)
 maneja dw ?

.code

Mensaje MACRO texto
mov AH,9
mov DX,OFFSET texto
int 21h
ENDM

public _ediarchi
_ediarchi proc
inicio:
mov AX,@DATA
mov DS,AX

Mensaje msj1
call lee
Mensaje salto

Mensaje msj2
call lee2
Mensaje salto

;abrir el archivo
mov ax,3d02h ;
xor CX,cx ;
LEA dx,captura+2
int 21h
mov maneja,ax              ;Handle
mov cx,1

editar: 
push cx
mov ah,40h
mov bx,maneja
mov cx,60
lea dx,captura2+2           ;texto
int 21h
pop cx
loop editar
mov ah,3eh                  ;CIERRE DE ARCHIVO
mov bx,maneja
int 21h

Mensaje salto
Mensaje msj3
Mensaje salto

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
 LEA DX,captura2            ; Puntero a la dirección para la entrada
 MOV BYTE PTR [captura2],60 ; Fijamos los 60 caracteres
 MOV AH,10                  ; función de entrada de teclado
 INT 21h                    ; LLamar a la interrupción del DOS
 MOV BL,[captura2+1]        ; Esta es la longitud efectiva tecleada
 MOV BH,0                   ; cargada nuestra direccion
 ADD BX,OFFSET captura2     ; apuntamos al final
 MOV BYTE PTR [BX+2],0      ; ponemos el cero al final
 ret
 end inicio
_ediarchi endp
end
