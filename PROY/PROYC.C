#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
void fichero();
void libre();
void main()
{
    char opc;
    system("color 70");
    do
    {
        system("cls");
        printf(" _______________________________\n");
        printf("|    ----Menu Principal----\t|\n");
        printf("|1 - Manejo de archivos   \t|\n");
        printf("|2 - Proyecto libre   \t\t|\n");
        printf("|0 - Salir    \t\t\t|\n");
        printf("|_______________________________|\n");
        printf("->Elija: ");
        scanf("%c", &opc);
        switch (opc)
        {
        case '1':
        {
            fichero();
            break;
        }
        case '2':
        {
            libre();
            break;
        }
        case '0':
        {
            system("pause>0");
            break;
        }
        default:
        {
            printf("\n\nOpcion invalida");
        }
        }
    } while (opc != '0');
}
void fichero()
{
    char o;
    do
    {
        system("cls");
        printf(" _______________________________________\n");
        printf("|\tMenu de Manejo de Archivos\t|\n");
        printf("|1 - Crear Directorio\t\t\t|\n");
        printf("|2 - Borrar Directorio\t\t\t|\n");
        printf("|3 - Crear Archivo\t\t\t|\n");
        printf("|4 - Copiar Archivo\t\t\t|\n");
        printf("|5 - Eliminar Archivo\t\t\t|\n");
        printf("|6 - Mover Archivo\t\t\t|\n");
        printf("|7 - Editar Archivo\t\t\t|\n");
        printf("|0 - SALIR\t\t\t\t|\n");
        printf("|_______________________________________|\n");
        printf("->Elija: ");
        o = getche();
        clrscr();
        switch (o)
        {
        case '1':
        {
            creadir();
            break;
        }
        case '2':
        {
            crearchi();
            break;
        }
        case '3':
        {
            crearchi();
            break;
        }
        case '4':
        {
            coparchi();
            break;
        }
        case '5':
        {
            borarchi();
            break;
        }
        case '6':
        {
            ediarchi();
            break;
        }
        case '7':
        {
            movarchi();
            break;
        }
        case '8':
        {
            ediarchi();
            break;
        }
        case '0':
        {
            break;
        }
        default:
        {
            printf("\n\nOpcion invalida");
        }
        }
    } while (o != '0');
}

void libre(){
    system("cls");
    printf("EL LIBRE ESTA EN PROCESO");
    system("pause>0");
}
