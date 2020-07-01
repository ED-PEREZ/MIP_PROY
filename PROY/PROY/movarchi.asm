.MODEL SMALL
.STACK
.DATA
 ;variables
 msj1 db "DIGITE LA DIRECCION DEL ARCHIVO A MOVER: ","$";
 db 13,10,13,10,"$"
 msj2 db "DIGITE LA NUEVA DIRECCION DEL ARCHIVO: ","$";
 db 13,10,13,10,"$"
 msjs db "ARCHIVO MOVIDO EXITOSAMENTE $";
 msje db "OPERACION FALLIDA$";
 salto DB 13,10,'$'
 captura DB 60 DUP (0)
 captura2 DB 60 DUP (0)
 manejae dw ?
 manejas dw ?
 cad db 120 DUP (?)

.code

Mensaje MACRO texto
mov AH,9
mov DX,OFFSET texto
int 21h
ENDM

public _movarchi
_movarchi proc

inicio:
mov ax,@DATA
mov ds,ax  
mov es,ax

Mensaje msj1
call lee
Mensaje salto

Mensaje msj2
call lee2
Mensaje salto 
                                       
mov ah,56h
lea dx,captura
lea di,captura2
int 21h
jnz error

Mensaje msjs
Mensaje salto

error:
Mensaje msje
Mensaje salto

.exit

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
 MOV BYTE PTR [BX+2],0     ; ponemos el cero al final
 ret

 end inicio
_movarchi endp
end