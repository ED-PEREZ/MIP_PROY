.MODEL SMALL
.STACK
.DATA
 ;variables
 msj1 db "DIGITE EL NOMBRE DEL ARCHIVO:","$";
 db 13,10,13,10,"$"
 msj2 db "DIGITE TEXTO:","$";
 db 13,10,13,10,"$"
 salto DB 13,10,'$'
 captura DB 60 DUP (0)
 captura2 DB 60 DUP (0)
 maneja dw ?

.code
public _crearchi
_crearchi proc
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
 mov dx,offset salto
 int 21h

 mov ah,09h
 mov dx,offset msj2
 int 21h
 call lee2
;crear archivo
 mov ah,3ch ;
 xor CX,cx ;
 LEA dx, captura+2
 int 21h
 mov maneja,ax              ;Handle
 mov cx,1
nuevo: 
push cx
mov ah,40h
mov bx,maneja
mov cx,60
lea dx,captura2             ;texto
int 21h
pop cx
loop nuevo
mov ah,3eh
mov bx,maneja
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
 MOV BH,0                   ; ; cargada nuestra direccion
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
_crearchi endp
end
