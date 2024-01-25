.data
	procesadas:		.asciz ""
	paridadMjs:		.word 1
	enter: 			.asciz "\n"
	mensajeConvertida:	.asciz "Tu nueva palabra es: "
	mensajeParidad: 	.asciz "La paridad no coincide"
	mensajeProcesadas: 	.asciz "La cantidad de letras procesadas son: "
	mensajeReset:		.asciz "PRESIONE ENTER PARA CONTINUAR"
	mensaje:		.asciz "                                                                                                                                                                              "
	convertida:		.asciz "                                                                                                                                                                              "
        clave:          	.asciz "                                                                                                                                                                              "
        opcion:         	.asciz "                                                                                                                                                                              "
	inputKey:		.asciz "                                                                                                                                                                              "
	vParidad:		.asciz ""
	cls:			.asciz "x1b[H\x1b[2J"
	lencls=. -cls

	menuPrincipal:

			.asciz "\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-                 ESTE ES EL PROGRAMA CESAR                 -\n"
			.asciz "-                                                           -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-     Este progrma Encripta y Desencripta cifrado cesar     -\n"
			.asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-     1:	Encriptar / Desencriptar                    -\n"
			.asciz "-                                                           -\n"
                        .asciz "-     2         Desencriptar con palabra secreta            -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-     3:	Salir                                       -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-------------------------------------------------------------\n"
			.asciz "-     Alumno:  Guillermo Sheil    --    DNI: 40.308.544     -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "~"

	menuCesar:
			.asciz "\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-                 ESTE ES EL PROGRAMA CESAR                 -\n"
			.asciz "-                                                           -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-     Ejempo encriptar:                                     -\n"
			.asciz "-                            Hola;1;2;3;c                   -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-     Ejemplo desencriptar:                                 -\n"
                        .asciz "-                            Iqob1;1;2;3;d                  -\n"
			.asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-     2: Volver al menu principal                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-------------------------------------------------------------\n"
			.asciz "-     Alumno:  Guillermo Sheil    --    DNI: 40.308.544     -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "~"

	menuPClave:
			.asciz "\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-                 ESTE ES EL PROGRAMA CESAR                 -\n"
			.asciz "-                                                           -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "-                                                           -\n"
			.asciz "-     Ejempo desencriptar:                                  -\n"
			.asciz "-                            Iqob Odskdoq0;Hol;d            -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-                            Hola Mariano;1;2;3;            -\n"
			.asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-     2: Volver al menu principal                           -\n"
                        .asciz "-                                                           -\n"
                        .asciz "-------------------------------------------------------------\n"
			.asciz "-     Alumno:  Guillermo Sheil    --    DNI: 40.308.544     -\n"
			.asciz "-------------------------------------------------------------\n"
			.asciz "~"

.text

	limpiar:				@ Limpia la pantalla

		.fnstart
			mov r0,#1
			ldr r1,=cls
			ldr r2,=lencls
			mov r7,#4
			swi 0
			bx lr
		.fnend

	vaciarPantalla:				@ Empuja el el texto hacia abajo con saltos de linea

		.fnstart
			push {lr}
			bl saveRegisters

			mov r4,#0
			vuelta__vaciarPantalla:

			bl saltoDeLinea
			bl write

			add r4,r4,#1
			cmp r4, #100
			bne vuelta__vaciarPantalla

			bl loadRegisters
			pop {lr}
			bx lr
		.fnend

	cleanRegisterSub:			@ Limpia los registros desde r0 hasta r3

		.fnstart
			mov	r0,#0
			mov	r1,#0
			mov	r2,#0
			mov	r3,#0

			bx lr
		.fnend

	cleanRegister:				@ Limpia todos los registros

		.fnstart
			mov	r0,#0
			mov	r1,#0
			mov	r2,#0
			mov	r3,#0
			mov	r4,#0
			mov	r5,#0
			mov	r6,#0
			mov	r7,#0
			mov	r8,#0
			mov	r9,#0
			mov	r10,#0
			mov	r11,#0
			mov	r12,#0

			bx lr
		.fnend

	saveParameters:				@ Guarda los resgistros desde r0 hasta r3

		.fnstart
			push {r0, r1, r2, r3}

			bx lr
		.fnend

	loadParameters:				@ Carga los registros desde r0 hasta r3

		.fnstart
			pop {r0, r1, r2, r3}

			bx lr
		.fnend

	saveRegisters:				@ Guarda los registros desde r4 hasta r11

		.fnstart
			push {r4, r5, r6, r7, r8, r9, r10, r11}

			bx lr
		.fnend

	loadRegisters:				@ Guarda los registros desde r4 hasta r11

		.fnstart
			pop {r4, r5, r6, r7, r8, r9, r10, r11}

			bx lr
		.fnend

	lengthS:				@ Recibe la posicion en memoria de una cadena por r3 y devuelve por r0 la cantidad de caracteres que posee (Corta en 0)

		.fnstart
			mov r0,#0

			inicio_ciclo__lengthS:

				ldrb	r2,[r3]

				cmp	r2,#'~'
				beq	fin_ciclo__lengthS
					add r0, r0, #1
					add r3, r3, #1

					bal inicio_ciclo__lengthS

			fin_ciclo__lengthS:

			sub r3, r3, r0
			bx lr

		.fnend

	lengthZero:				@ Recibe la posicion en memoria de una cadena por r3 y devuelve por r0 la cantidad de caracteres que posee (Corta en ~)

		.fnstart
			mov r0,#0

			inicio_ciclo__lengthZero:

				ldrb	r2,[r3]

				cmp	r2,#0
				beq	fin_ciclo__lengthZero
					add r0, r0, #1
					add r3, r3, #1

					bal inicio_ciclo__lengthZero

			fin_ciclo__lengthZero:

			sub r3, r3, r0
			bx lr

		.fnend

	read:					@ Lee y almacena el ingreso por teclado en inputKey:

		.fnstart

			push {lr}
			bl saveRegisters
			bl saveParameters

                        ldr r3, =inputKey
			bl  lengthZero
			mov r12, r0

			mov r7, #3
			mov r0, #0
			mov r2, r12
			ldr r1, =inputKey
			swi 0

			bl loadParameters
			bl loadRegisters
			pop {lr}
			bx lr

		.fnend

	saltoDeLinea:				@ Prepara un salto de linea en r3

		.fnstart

			ldr r3,=enter

			bx lr
		.fnend

	write:					@ Recibe por r3 la posicion en memoria de una cadena, la impreme hasta toparse con 0 (Usa lengthZero)

		.fnstart

			push {lr}
			bl saveParameters

			bl  lengthZero
			mov r12, r0

			mov r7, #4
			mov r0, #1
			mov r2, r12
			mov r1, r3
			swi 0

			bl loadParameters
			pop {lr}
			bx lr

		.fnend

	printMenu:				@ Recibe por r3 la direccion del menu y lo imprime hasta toparse con ~ (Usa LengthS). Queda esperando que se ingrese algo por teclado y lo almacena en inputKey:

		.fnstart

                        push {lr}

			bl saveParameters
			bl  lengthS
			mov r12, r0
			bl loadParameters

			bl limpiar

			mov r7, #4
			mov r0, #1
			mov r2, r12
			mov r1, r3
			swi 0

			bl read

                        pop {lr}
			bx lr

		.fnend

	toIntOne:				@ Recibe por r3 un numero ascii y lo devuelve por r0 en mismo numero convertido en Int (Numeros del 0 al 9)

		.fnstart

			push {lr}
			bl saveRegisters

			sub r0, r3, #'0'

			bl loadRegisters
			pop {lr}
			bx lr

		.fnend

	toStrOne:				@ Recibe por r3 un numero ascii y lo devuelve por r0 en mismo numero convertido en Int (Numeros del 0 al 9)

		.fnstart

			push {lr}
			bl saveRegisters

			add r0, r3, #'0'

			bl loadRegisters
			pop {lr}
			bx lr

		.fnend

	toStr999:				@ Recibe por r3 un numero y lo convierte en ascii, luego lo almacena en procesadas: (Numeros entre 0 y 999)

		.fnstart

			push {lr}
			bl saveRegisters

			ldr r11,=procesadas

			cmp r3,#99
			bcs superior99__toStr
			cmp r3,#9
			bcs superior9__toStr
			bal superior0__toStr

			superior99__toStr:
						 @ Ejemplo r3=221
				mov r4,#100
				sdiv r5,r3,r4    @ 2 = 221 / 100
				add r6,r5,#'0'	 @ Carcter del 2 =  2 = '0'
				str r6,[r11]     @ Lo guardo en Memoria
				add r11,r11,#1	 @ Aumento pos en memoria
				mul r7,r5,r4     @ 200 = 2 * 100
				sub r3,r3,r7	 @ 21 = 221 - 200

			superior9__toStr:

				mov r4,#10
				sdiv r5,r3,r4   @ 2 = 21 / 10
				add r6,r5,#'0'  @ Caracter del 5 = 5 + '0'
				str r6,[r11]	@ Guardo en memoria
				add r11,r11,#1	@ Avanzo en memoria
				mul r7,r5,r4	@ 20 = 2 * 10
				sub r3,r3,r7	@ 1 = 21 - 20

			superior0__toStr:

				add r6,r3,#'0'	@ Caracter del 1 = 1 + '0'
				str r6,[r11]

			bl loadRegisters
			pop {lr}

			bx lr

		.fnend


	toInt:					@ Recibe por r3 la posicion de memoria de una cadena y devuelve por r1 el mismo numero convertido en int

		.fnstart

			push {lr}
			bl saveRegisters

			mov r1,#0
			mov r2,#0
			mov r4,#0
			mov r5,#0
			mov r6,#0
			mov r7,#0
			mov r8,#0
			mov r9,#0
			mov r10,#10

			mov r12, r3		@ Me guardo la posicion de la palabra para no sobreescribirla
			bl lengthZero
			mov r3, r0		@ Paso la el numero del largo que recibe a r3
			mov r0, r12		@ Guardo la posicion de la palabra que recibi

			inicio_ciclo__toInt:

			ldrb	r2,[r0]
			cmp 	r2, #0
			beq	fin_ciclo__toInt

				sub r2, r2, #'0'
				sub r5, r3, #1

				cmp r5, #0
				beq if_exponente_es1

					mov r8, #1
					mov r4, #1

					inicio_ciclo_peso:

					cmp r8,r3
					beq fin_ciclo_peso

						mul r9, r4, r10
						mov r4, r9
						add r8, r8, #1
						bal inicio_ciclo_peso

					fin_ciclo_peso:

					mul r6, r4, r2
					add r1, r1, r6

					add r0, r0, #1
					sub r3, r3, #1
					bal inicio_ciclo__toInt

				if_exponente_es1:

					add r1, r1, r2
					bal fin_ciclo__toInt

			fin_ciclo__toInt:

			bl loadRegisters
			pop {lr}
			bx lr
		.fnend

	paridad:					@ Recibe por r0 un numero y devuelve por r0 el caracter '0' si es par, o el caracter '1' si es impar
		.fnstart

			and r1, r0, #1
			cmp r1, #0

			beq es_par__paridad
			bne es_impar__paridad

			es_par__paridad:

				mov r0,#'0'
				bal fin__paridad

			es_impar__paridad:

				mov r0,#'1'

			fin__paridad:

			bx lr
		.fnend

	@ ~~~~~~~~~~~~~~~ Subrutinas Esenciales ~~~~~~~~~~~~~~~ @

	se_extraerMensaje:				@ Extra el mensaje dado por el usuario y de el la paridad

		.fnstart
			push {lr}

                        bl saveRegisters

			ldr     r4,=inputKey
                        ldr     r6,=mensaje
			ldr	r7,=paridadMjs @agre

                        inicioCiclo:

                        ldrb    r5,[r4]
                        cmp     r5, #';'
                        beq     finCiclo
			cmp	r5,#'0'
			beq	esLaParidad__se_extraerParidad @agre
			cmp	r5,#'1'
			beq	esLaParidad__se_extraerParidad @agre

                                str     r5,[r6]
                                add     r4,r4,#1
				add	r6,r6,#1
                                bal     inicioCiclo

                        finCiclo:

			ldr	r6,=mensaje

			bl loadRegisters

			pop {lr}

			bx lr

			esLaParidad__se_extraerParidad:

			str	r5,[r7] 	@ Guarda la paridad que me pasaron en el mensaje
			add	r4,r4,#1
			bal	inicioCiclo

		.fnend

	se_extraerClave:				@ Extrae la clave dada por el usuario

		.fnstart
			push {lr}

                        bl saveRegisters

			ldr     r4,=inputKey
                        ldr     r6,=clave

                        inicioCiclo__se_extraerClave:

                        ldrb    r5,[r4]
                        cmp     r5, #';'
                        beq     finCiclo__se_extraerClave

                                add     r4,r4,#1
                                bal     inicioCiclo__se_extraerClave

                        finCiclo__se_extraerClave:

			add	r4, r4, #1

                        inicioCicloNumero:	@ Aca empieza a sacar lo numeros

                        ldrb    r5,[r4]
                        cmp     r5, #';'
                        beq     finCicloNumero

				str	r5,[r6]
                                add     r4,r4,#1
				add	r6,r6,#1
                                bal     inicioCicloNumero

                        finCicloNumero:

			add	r4,r4,#1

			ldrb	r5,[r4]

			cmp	r5,#'d'
			beq	termine
			cmp	r5,#'c'
			beq	termine


			cmp	r5,#'D'
			beq	termine
			cmp	r5,#'C'
			beq	termine

			bal	inicioCicloNumero

			termine:

			bl loadRegisters

			pop {lr}

			bx lr

		.fnend

	se_extraerPSecreta:					@ Convierte la palabra secreta en el numero que le corresponde (La palabra secreta esta almacenada como la clave)

		.fnstart
			push {lr}

                        bl saveRegisters

			ldr r4,=clave
			ldr r5,=mensaje

			inicio__se_extraerPSecreta:

			ldrb r7,[r5]
			ldrb r6,[r4]

			cmp r7, #0
			beq termine__se_extraerPSecreta

				sub r8,r7,r6 @cambie inverti
				add r8,r8,#'0'

				strb r8,[r4]
				add r4,r4,#1
				ldrb r6,[r4]
				add r5,r5,#1
				cmp r6,#0
				beq termine__se_extraerPSecreta
				bal inicio__se_extraerPSecreta

				esEspacio__se_extraerPSecreta:

				add r5,r5,#1
				ldrb r7,[r5]
				cmp r7, #' '
				beq esEspacio__se_extraerPSecreta
				bal inicio__se_extraerPSecreta

			termine__se_extraerPSecreta:

			bl loadRegisters

			pop {lr}

			bx lr

		.fnend

	se_extraerOpcion:						@ Se extrae la opcion de codificar o decodificar

		.fnstart
			push {lr}

                        bl saveRegisters

			ldr     r4,=inputKey
                        ldr     r6,=opcion

                        inicioCiclo__se_extraerOpcion:

                        ldrb    r5,[r4]
                        cmp     r5, #';'
                        beq     finCiclo__se_extraerOpcion

                                add     r4,r4,#1
                                bal     inicioCiclo__se_extraerOpcion

                        finCiclo__se_extraerOpcion:

                        inicioCicloOpcion:

                        ldrb    r5,[r4]
			cmp	r5,#'d'
			beq	esOpcion__se_extraerOpcion
			cmp	r5,#'c'
			beq	esOpcion__se_extraerOpcion

			cmp	r5,#'D'
			beq	esOpcion__se_extraerOpcion
			cmp	r5,#'C'
			beq	esOpcion__se_extraerOpcion

			add	r4,r4,#1
			bal	inicioCicloOpcion

			esOpcion__se_extraerOpcion:

			str	r5,[r6]

			bl loadRegisters
			pop {lr}
			bx lr

		.fnend

	se_verificarParidad:						@ Verifica que la paridad del mensaje sea la correcta. Recibe por r0 el ascii de la paridad correcta y la compara con la del mensaje...
									@ ...devuelve por r0 el numero 0 si las paridades son iguales, sino devuelve 1
		.fnstart
			ldr r1,=paridadMjs
			ldrb r1,[r1]
			ldr r2,=vParidad

			cmp r0,r1
			beq sonIguales__se_verificarParidad

			mov r0,#1
			@str r3,[r2]
			bal end__se_verificarParidad

			sonIguales__se_verificarParidad:

			mov r0,#0
			@str r3,[r2]
			end__se_verificarParidad:

			bx lr
		.fnend

	se_decodificar:							@ Decodifica el mensaje

		.fnstart
			push {lr}
			bl saveParameters
			bl saveRegisters

				bl se_extraerMensaje

				ldr r4,=mensaje
				ldr r5,=clave
				ldr r11,=convertida

				cicloPrincipal__se_decodificar:

				ldrb r7,[r5]					@ Primer numero de la clave

				mov r3, r7
				bl toIntOne					@ Convierto primer numero clave
				mov r1, r0					@ Paso el numero convertido en int a r0

				ldrb r6,[r4]
				ldrb r12,[r11]

				cmp r6,#0					@ Repito el ciclo hasta que se acabe la cadena.
				beq finCicloPrincipal__se_decodificar

					cmp r6,#' ';				@ Comparo el caracter con un espacio en blanco.
					beq esEspacio__se_decodificar

					cmp r6,#'.';
					beq esEspacio__se_codificar

					cmp r6,#',';
					beq esEspacio__se_codificar

					cmp r6,#'?';
					beq esEspacio__se_codificar

					cmp r6,#'!';
					beq esEspacio__se_codificar

					cmp r6,#'"';
					beq esEspacio__se_codificar

					cmp r6,#'Z'
					bcs esMinuscula__se_decodificar

					sub r8,r6,r1				@ Resto al caracter el numero de la clave previamente convertido en int.
					cmp r8,#'A'
					bcc sePasa__se_decodificar
					bal siguiente__se_decodificar

					esMinuscula__se_decodificar:

						sub r8,r6,r1			@ Resto al caracter el numero de la clave previamente convertido en int.
						cmp r8,#'a'
						bcc sePasaMin__se_decodificar

					siguiente__se_decodificar:

						str r8,[r11]
						add r11, r11, #1

						add r4, r4, #1
						add r5, r5, #1

						ldrb r2,[r5]

						cmp r2, #0
						beq  ciclarClave__se_decodificar

						bal cicloPrincipal__se_decodificar

						ciclarClave__se_decodificar:

							ldr r5,=clave
							bal cicloPrincipal__se_decodificar

					sePasaMin__se_decodificar:

						mov r10,#'a'
						sub r9,r10,r8						@ Resto el numero minimo de caracteres #'a' con el total y en r9 me dice cuanto se paso
						mov r8,#'z'
						sub r9,r9,#1						@ Resto 1 para que contemple la letra 'z'
						sub r8,r8,r9						@ Le resto los caracteres que sobraron a r8

						bal siguiente__se_decodificar

					sePasa__se_decodificar:

						mov r10, #'A' 	   @Esto es porque no puedo restar con una costante en el primer item
						sub r9,r10,r8
						mov r8,#'Z'
						sub r9,r9,#1
						sub r8,r8,r9

						bal siguiente__se_decodificar

					esEspacio__se_decodificar:

						str r6,[r11]
						add r11, r11, #1
						add r4, r4, #1						@ |Siguiente caracter|
						bal cicloPrincipal__se_decodificar

						@bal siguiente__se_codificar

				finCicloPrincipal__se_decodificar:

			ldr r3,=convertida
			bl lengthZero

			mov r3,r0			 @ En r0 tengo lo que devulve lengthZero
			bl toStr999

			bl paridad                  	 @ Ahora tengo en r0 ascii de 0 si es par o 1 si es impart, esta es la paridad de la cantidad de letras
			bl se_verificarParidad      	 @ Le paso por r0 (contiene la paridad de la cantidad de letras). Y la compara con la paridad que me pasaron en el mensaje

			ldr r1,=vParidad
			str r0,[r1]		    	 @ Se guarda en memoria si la paridad que me dieron es igual a la que corresponde (Se guarda 0). En caso contrario (Se guarda 1)

			bl loadRegisters
			bl loadParameters
			pop {lr}
			bx lr

		.fnend

	se_codificar:							@ Codifica el mensaje

		.fnstart
			push {lr}
			bl saveParameters
			bl saveRegisters

				bl se_extraerMensaje

				ldr r4,=mensaje
				ldr r5,=clave
				ldr r11,=convertida

				cicloPrincipal__se_codificar:

				ldrb r7,[r5]

				mov r3, r7
				bl toIntOne								@ Convierto primer numero clave
				mov r1, r0								@ Paso el numero convertido en in a r0

				ldrb r6,[r4]
				ldrb r12,[r11]

				cmp r6,#0								@ Repito el ciclo hasta que se acabe la cadena.
				beq finCicloPrincipal__se_codificar

					cmp r6,#' ';							@ Comparo el caracter con un espacio en blanco.
					beq esEspacio__se_codificar

					cmp r6,#'.';
					beq esEspacio__se_codificar

					cmp r6,#',';
					beq esEspacio__se_codificar

					cmp r6,#'?';
					beq esEspacio__se_codificar

					cmp r6,#'!';
					beq esEspacio__se_codificar

					cmp r6,#'"';
					beq esEspacio__se_codificar

					cmp r6,#'Z'
					bcs esMinuscula

					add r8,r6,r1							@ Sumo al caracter el numero de la clave previamente convertido en int.
					cmp r8,#'Z'
					bcs sePasa__se_codificar					@ Si el caracter codificado debe empezar por la 'a' porque se le acabo el abcedario.
					bal siguiente__se_codificar

					esMinuscula:

						add r8,r6,r1						@ Sumo al caracter el numero de la clave previamente convertido en int.
						cmp r8,#'z'
						bcs sePasaMin__se_codificar

					siguiente__se_codificar:					@ Aca vuelve cuando se pasa o cuando hay un espacio {coment agregado despues}

						str r8,[r11]
						add r11, r11, #1

						add r4, r4, #1						@ |Siguiente caracter|
						add r5, r5, #1

						ldrb r2,[r5]

						cmp r2, #0
						beq  ciclarClave

						bal cicloPrincipal__se_codificar

						ciclarClave:

							ldr r5,=clave
							bal cicloPrincipal__se_codificar

					sePasaMin__se_codificar:

						sub r9,r8,#'z'						@ Resto el numero total con el numero maximo de caracteres #'Z' y en r9 me dice cuanto se paso
						mov r8,#'a'
						sub r9,r9,#1						@ Resto 1 para que contemple la letra 'a'
						add r8,r8,r9						@ Le sumo el caracteres que sobraron a r8

						bal siguiente__se_codificar

					sePasa__se_codificar:

						sub r9,r8,#'Z'						@ Resto el numero total con el numero maximo de caracteres #'Z' y en r9 me dice cuanto se paso
						mov r8,#'A'
						sub r9,r9,#1						@ Resto 1 para que contemple la letra 'a'
						add r8,r8,r9						@ Le sumo el caracteres que sobraron a r8

						bal siguiente__se_codificar

					esEspacio__se_codificar:

						str r6,[r11]   @ cambie r8 por r6
						add r11, r11, #1
						add r4, r4, #1						@ |Siguiente caracter|
						bal cicloPrincipal__se_codificar

				finCicloPrincipal__se_codificar:

			ldr r3,=convertida
			bl lengthZero
			mov r3,r0
			bl toStr999		@ En r0 tengo el largo en int
			bl paridad		@ En r0 tengo el largo en str
			str r0,[r11]		@ En r0 tengo la paridad en str

			bl loadRegisters
			bl loadParameters
			pop {lr}
			bx lr

		.fnend

@ ~~~~~~~~~~~~~~~ Aca arranca el programa principal ~~~~~~~~~~~~~~~ @

.global main

	main:
		push {lr}

		bl vaciarPantalla
		bl cleanRegister

		menuPrincipal__programa:
		opcionIncorrecta__menuPrincipal:

		ldr r3,=menuPrincipal
		bl printMenu

		ldr r0,=inputKey
		ldrb r1,[r0]

		cmp r1,#'3'
		beq done
		cmp r1,#'2'
		beq opcionDos__programa
		cmp r1,#'1'
		beq opcionUno__programa
		bal opcionIncorrecta__menuPrincipal

		opcionUno__programa:

		ldr r3,=menuCesar
		bl printMenu

		ldr r0,=inputKey
		ldrb r1,[r0]

		cmp r1,#'2'     			 @ Vuelve al menuPrincipal
		beq menuPrincipal__programa

			bl se_extraerOpcion
			ldr r4,=opcion
			ldrb r4,[r4]

			cmp r4,#'c'
			beq codificar__programa
			cmp r4,#'d'
			beq decodificar__programa

			cmp r4,#'C'
			beq codificar__programa
			cmp r4,#'D'
			beq decodificar__programa

			bal opcionUno__programa

			codificar__programa:

				bl se_extraerClave

				bl se_codificar

				ldr r3,=mensajeConvertida
				bl write

				ldr r3,=convertida
				bl write

				bl saltoDeLinea
				bl write

				ldr r3,=mensajeProcesadas
				bl write

				ldr r3,=procesadas
				bl write

				bl saltoDeLinea
				bl write
				bl write

				ldr r3,=mensajeReset
				bl write

				bl saltoDeLinea
				bl write

				bl read
				bal opcionUno__programa

				@bal done

			decodificar__programa:

				bl se_extraerClave

				bl se_decodificar

				ldr r3,=mensajeConvertida
				bl write

				ldr r3,=convertida
				bl write

				bl saltoDeLinea
				bl write

				ldr r3,=mensajeProcesadas
				bl write

				ldr r3,=procesadas
				bl write

				bl saltoDeLinea
				bl write

				ldr r0,=vParidad
				ldrb r0,[r0]

				cmp r0,#1
				beq paridadMal__menuPrincipal

				bl saltoDeLinea
				bl write
				bl write

				ldr r3,=mensajeReset
				bl write

				bl saltoDeLinea
				bl write

				bl read
				bal opcionUno__programa

				@bal done

		opcionDos__programa:

			ldr r3,=menuPClave
			bl printMenu

			ldr r0,=inputKey
			ldrb r1,[r0]

			cmp r1,#'2'     		 @Vuelve al menuPrincipal
			beq menuPrincipal__programa

				bl se_extraerMensaje

				bl se_extraerClave

				bl se_extraerPSecreta
				bl se_decodificar

				ldr r3,=mensajeConvertida
				bl write

				ldr r3,=convertida
				bl write

				bl saltoDeLinea
				bl write

				ldr r3,=mensajeProcesadas
				bl write

				ldr r3,=procesadas
				bl write

				bl saltoDeLinea
				bl write

				ldr r0,=vParidad
				ldrb r0,[r0]

				cmp r0,#1
				beq paridadMal__menuPrincipal

				bl saltoDeLinea
				bl write
				bl write

				ldr r3,=mensajeReset
				bl write

				bl saltoDeLinea
				bl write

				bl read
				bal opcionDos__programa

				paridadMal__menuPrincipal:

				ldr r3,=mensajeParidad
				bl write

				bl saltoDeLinea
				bl write
				bl write

				ldr r3,=mensajeReset
				bl write

				bl saltoDeLinea
				bl write

				bl read
				bal menuPrincipal__programa

		bal opcionUno__programa

		pop {lr}

	done:
		bl limpiar
		bl saltoDeLinea
		bl write

		mov r7, #1
		swi 0

