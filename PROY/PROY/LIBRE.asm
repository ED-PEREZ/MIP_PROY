.MODEL SMALL
.STACK
.DATA
 menu db ,' ',10,13
 db ,' ----------------->PIANO<----------------- ',10,13
 db ,' ',10,13
 db ,' ',10,13
 db ,' | 1 | | 2 | 3 | 4 | 5 | 6 | 7 | 8 |' ,10,13
 db ,' | Do| | Re| Mi| Fa| So| La| Si|Do#| $',10,13
 db ,' ',10,13
 db ,' ',10,13 

.code
inicio:
public _libre
_libre proc

principal proc far
 push ds
 mov bh, 30h
 call borrar
 mov dh, 5
 mov dl, 10
 call cursor
 sub ax,ax
 push ax

 mov ax,@DATA
 mov ds,ax
 lea dx,menu
 mov ah,09
 int 21h

 denuevo: call ingresa
 cmp ah,01h
 je dos
 call frecuencia
 call inicializa
 call cargar
 call sonido
 call retardo
 call desactivar
 
 jmp denuevo
 dos: ret
principal endp

ingresa proc near
 ingr: mov ah,00
 int 16h
 cmp ah,01h
 je fin
 cmp al,061h
 je a
 cmp al,073h
 je b
 cmp al,064h
 je c
 cmp al,066h 
 je d
 cmp al,067h
 je e
 cmp al,068h
 je f
 cmp al,06ah
 je g
 cmp al,071h
 je h
 jmp ingr

 a: mov cx,2093 ; do
 jmp fin
 b: mov cx,2349 ; re 
 jmp fin
 c: mov cx,2637 ; mi
 jmp fin
 d: mov cx,2794 ; fa
 jmp fin
 e: mov cx,3136 ; so
 jmp fin
 f: mov cx,3520 ; la
 jmp fin
 g: mov cx,3951 ; si
 jmp fin 
 h: mov cx,2217; do#
 fin:ret
ingresa endp  

retardo proc near
 push cx
 mov cx,12ch
 v1:mov bx,13ch

 v5:dec bx
 jnz v5
 loop v1
 pop cx
 ret
retardo endp 

borrar proc
 mov cx, 0
 mov dh, 24
 mov dl, 79
 mov al,0
 mov ah,6
 int 10h
 ret
borrar endp
cursor proc
 mov ah, 2
 mov bh, 0
 int 10h
 ret
cursor endp 

frecuencia proc near
 push ax
 push dx
 mov dx,12h
 mov ax,34dch
 div cx
 mov cx,ax
 pop dx
 pop ax 
 
 ret
frecuencia endp
inicializa proc near
 push ax
 mov al,182
 out 67,al
 pop ax
 ret
inicializa endp
cargar proc near
 push ax
 mov al,cl
 out 66,al
 mov al,ch
 out 66,al
 pop ax
 ret
cargar endp 


sonido proc near
 push ax
 in al,97
 or al,03h
 out 97,al 
 
 pop ax
 ret
sonido endp 


desactivar proc near
 push ax
 in al,97
 and al,0fch
 out 97,al
 pop ax
 ret
desactivar endp
 end principal
 endp _libre
 edn inicio
