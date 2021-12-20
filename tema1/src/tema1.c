#include <unistd.h>
#include <stdarg.h>
#include <string.h>
// stdlib il folosesc doar pentru malloc, free si abs
#include <stdlib.h>

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

void unsigned_int_to_hex_string(unsigned int number, char* hextable,
                                                        int* number_of_chars) 
{
    if (number == 0)
        return;

    unsigned_int_to_hex_string(number/16, hextable, number_of_chars);
    write_stdout(hextable + number % 16, 1);
    *number_of_chars += 1;
}

void int_to_string(int number, char* numbertable, int* number_of_chars, int sign) 
{
    if (number == 0) {
    	// cand se ajunge la numarul 0 de acolo incep afisarile, asa ca inainte
    	// sa aiba loc celelalte afisari voi afisa - in caz ca numarul e negativ
    	if (sign == 1) {
            char *minus = "-";
            write_stdout(minus, 1);
            *number_of_chars += 1;
        }

        return;
    }

    int_to_string(number/10, numbertable, number_of_chars, sign);
    // In caz ca numarul e -5(spre ex), as afisa din numbertable - 5
    // asa ca folosesc modulul restului
    write_stdout(numbertable + abs(number % 10), 1);
    *number_of_chars += 1;
}

void unsigned_int_to_string(unsigned int number, char* numbertable, 
                                                        int* number_of_chars) 
{
    if(number == 0)
        return;

    unsigned_int_to_string(number/10, numbertable, number_of_chars);
    write_stdout(numbertable + number % 10, 1);
    *number_of_chars += 1;
}

int iocla_printf(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    char *numbertable = "0123456789";
    char *hextable = "0123456789abcdef";
    // l-am declarat pointer pentru a putea sa-l folosesc ca parametru referinta
    int *number_of_chars = malloc(sizeof(int));
    *number_of_chars = 0;

    // j e un pointer fix dupa ultimul "%" gasit
    char *i = (char*)format;
    char *j = i;
    for( ; *i != '\0'; i++) {
        if (*i == '%') {
        	int caz_procent = 0;
            char specificator = *(i + 1);
            // afisez textul de dinainte de "%"
            if (i - j > 0) {
                write_stdout(j, i - j);
                *number_of_chars += i - j;
            }

            if (specificator == 's') {
                char *argument = va_arg(args, char*);
                int strlen_argument = strlen(argument);
                *number_of_chars += strlen_argument;
                write_stdout(argument, strlen_argument);

            } else if (specificator == 'u') {
                unsigned int argument = va_arg(args, unsigned int);
                unsigned_int_to_string(argument, numbertable, number_of_chars);

            } else if(specificator == 'c') {
                char argument = va_arg(args, int);
                char *character = &argument;
                write_stdout(character, 1);
                *number_of_chars += 1;

            } else if(specificator == 'd') {
                int argument = va_arg(args, int);
                int sign;
                if (argument < 0)
                	sign = 1;
                else
                	sign = 0;

                int_to_string(argument, numbertable, number_of_chars, sign);

            } else if (specificator == 'x') {
                unsigned int argument = va_arg(args, unsigned int);
                unsigned_int_to_hex_string(argument, hextable, number_of_chars);

            } else if (specificator == '%') {
                char *character = &specificator;
                write_stdout(character, 1);
                *number_of_chars += 1;
                i++;
                // pentru ca am crescut i, linia j = i + 2 va muta j-ul cu 1
                // pozitie mai mult, asa ca il scad
                caz_procent = 1;

            } else {
            	iocla_printf("Foloseste %%%% pentru afisarea de %%!\n");
            	// Afiseaza: Foloseste %% pentru afisarea de %!
            	return -1;
            }

            j = i + 2 - caz_procent;
        }
    }

    // afisez ce text mai ramane dupa ultimul specificator
    if (i - j > 0) {
        write_stdout(j, i - j);
        *number_of_chars += i - j;
    }

    // bag variabila dinamica intr-una statica pentru a elibera memoria
    int number_of_characters = *number_of_chars;
    free(number_of_chars);

	return number_of_characters;
}