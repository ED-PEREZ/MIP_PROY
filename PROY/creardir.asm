.MODEL SMALL
.STACK
.DATA
 msj1 db "DIGITE EL NOMBRE DEL DIRECTORIO:","$";
 db 13,10,13,10,"$"
 GuardarEntradaTeclado DB 80 DUP (0) ; BufferLeerDisco para leer desde el teclado
.code
public _creadir
_creadir proc
inicio:
 MOV AX,@DATA
 MOV DS,AX
 mov ah,09h
 mov dx,offset msj1
 int 21h
 call lee
 LEA dx, GuardarEntradaTeclado+2
 mov ah,39h
 int 21h
 fin:
 mov ax,4c00h
 int 21h
 lee:
 LEA DX,GuardarEntradaTeclado ; Puntero a la dirección para la entrada
 MOV BYTE PTR [GuardarEntradaTeclado],60 ; Fijamos los 60 caracteres
 MOV AH,10 ; función de entrada de teclado
 INT 21h ; LLamar a la interrupción del DOS
 MOV BL,[GuardarEntradaTeclado+1] ; Esta es la longitud efectiva tecleada
 MOV BH,0 ; cargada nuestra direccion
 ADD BX,OFFSET GuardarEntradaTeclado ; apuntamos al final
 MOV BYTE PTR [BX+2],0 ; ponemos el cero al final
 ret
 end inicio
_creadir endp
end 