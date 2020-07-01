.MODEL SMALL
.STACK
.DATA
 ;variables
 msj1 db "DIGITE EL NOMBRE DEL ARCHIVO A COPIAR: ","$";
 db 13,10,13,10,"$"
 msj2 db "DIGITE EL NOMBRE DE LA COPIA: ","$";
 db 13,10,13,10,"$"
 msjs db "ARCHIVO COPIADO EXITOSAMENTE $";
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

public _coparchi
_coparchi proc

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
                                       

mov ax,3d00h                  ;apertura archivo origen         
mov dx,offset captura
int 21h
mov [manejae],ax


mov ax,3c00h              ;Creamos archivo destino
xor cx,cx
mov dx,offset captura2
int 21h
mov [manejas],ax    

mov ah,3fh              ;LECTURA DEL FICHERO
mov bx,[manejae]
mov cx,60
mov dx,offset cad
int 21h 

push ax                 ;guardar bytes leidos

mov cx,cx               ;escribir los bytes leídos
mov ah,40h
mov bx,[manejas]
mov dx,offset cad
int 21h

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
 MOV BYTE PTR [BX+2],0     ; ponemos el cero al final
 ret

 end inicio
_coparchi endp
end