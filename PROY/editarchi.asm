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
 ncar db 60 dup('')

.code
public _editarchi
_editarchi proc
inicio:
 MOV AX,@DATA
 MOV DS,AX
 mov ah,09h
 mov dx,offset msj1
 int 21h
 call lee
 mov ah,09h
 mov dx,offset salto
 int 21h

 mov ah,09h
 mov dx,offset msj2
 int 21h
 call lee2

editar:                 ;abrir el archivo
mov ah,3dh
mov al,1h               ;Abrimos el archivo en solo escritura.
LEA dx, captura+2
int 21h
jz salir                ;Si hubo error
;Escritura de archivo
mov bx,ax
mov cx,offset ncar               ;num de caracteres a grabar
lea dx,captura2+2  
mov ah,40h
int 21h

mov ah,09h
mov dx,offset salto
int 21h
mov ah,09h
mov dx,offset msj3
int 21h
mov ah,09h
mov dx,offset salto
int 21h

cmp cx,ax
jne salir ;error salir
mov ah,3eh ;Cierre de archivo
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
 LEA DX,captura2            ; Puntero a la dirección para la entrada
 MOV BYTE PTR [captura2],offset ncar  ; Fijamos los 60 caracteres
 MOV AH,10                  ; función de entrada de teclado
 INT 21h                    ; LLamar a la interrupción del DOS
 MOV BL,[captura2+1]        ; Esta es la longitud efectiva tecleada
 MOV BH,0                   ; cargada nuestra direccion
 ADD BX,OFFSET captura2     ; apuntamos al final
 MOV BYTE PTR [BX+2],0      ; ponemos el cero al final
 ret
 end inicio
_editarchi endp
end
