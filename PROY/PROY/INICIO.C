#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
void fichero();
void main()
{
    int opc;
    do
    {
        system("cls");
        printf("\tMenu Principal\n\n");
        printf("1 - Manejo de archivos\n");
        printf("2 - Proyecto libre\n");
        printf("0 - Salir\n\n");
        printf("Elija: ");
        scanf("%d", &opc);
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
            system("pause");
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
        printf("\tMenu de Manejo de Archivos\n\n");
        printf("1 - Crear Directorio\n");
        printf("2 - Borrar Directorio\n");
        printf("3 - Crear Archivo\n");
        printf("4 - Copiar Archivo\n");
        printf("5 - Eliminar Archivo\n");
        printf("6 - Mover Archivo\n");
        printf("7 - Editar Archivo\n");
        printf("8 - SALIR\n");
        printf("Elija: ");
        o = getche();
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

void libre(){}
