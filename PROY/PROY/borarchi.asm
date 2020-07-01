.MODEL SMALL

.STACK

.DATA
 ;variables
 msj1 db "DIGITE EL NOMBRE DEL ARCHIVO:","$";
 db 13,10,13,10,"$"
 msjs db "ARCHIVO ELIMINADO EXITOSAMENTE","$";
 msje db "OPERACION FALLIDA$";
 db 13,10,13,10,"$"
 salto DB 13,10,'$'
 captura DB 60 DUP (0)
 maneja dw ?

.code

Mensaje MACRO texto
mov AH,9
mov DX,OFFSET texto
int 21h
ENDM

public _borarchi
_borarchi proc
inicio:
 mov AX,@DATA
 mov DS,AX

Mensaje msj1
call lee
Mensaje salto

;borrar archivo
mov ah,41h ;
LEA dx, captura+2
int 21h
jc error

Mensaje msjs
Mensaje salto
jnc salir

error:
Mensaje msje
Mensaje salto

salir:
mov ax,4c00h
int 21h

;captura1
 lee:
 LEA DX,captura             ; Puntero a la direccion para la entrada
 mov BYTE PTR [captura],60  ; Fijamos los 60 caracteres
 mov AH,10                  ; funcion de entrada de teclado
 INT 21h                    ; Llamar a la interrupcion del DOS
 mov BL,[captura+1]         ; Esta es la longitud efectiva tecleada
 mov BH,0                   ; cargada nuestra direccion
 ADD BX,OFFSET captura      ; apuntamos al final
 mov BYTE PTR [BX+2],0      ; ponemos el cero al final
 ret
 end inicio
 _borarchi endp
end