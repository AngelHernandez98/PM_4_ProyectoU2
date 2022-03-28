TITLE Introduccion

; DESCRPICIÓN
; Objetivo: Archivo de Ejemplo

; Autore(s):
; Mtro. Alejandro Garcia
; Equipo #4
; Integrantes:
;			  - Angel Anastasio Hernández Hernández
;			  - Luis Armando Hernández Licea
;			  - David Jonatan Torres Orozco
;
; Proyecto de la Unidad #2: "Picas y Fijas"
;
; Semestre: 8vo Semestre ISC
; FIN DESCRIPCIÓN

INCLUDE Irvine32.inc

.data
; Área de Declaración de Variables
msj0_P2 db "						         JUEGO",0
msj1_P2 db "						    'Picas y Fijas'",0
msj2_P2 db "Ingrese un numero de 4 cifras: ",0
msj3_P2 db "Ingrese la cantidad de intentos: ",0
msj4_P2 db "Intento #", 0
msj5_P2 db ": ", 0
msj6_P2 db "Picas encontradas: ",0
msj7_P2 db "Fijas encontradas: ",0
msj8_P2 db "                                                     FELICIDADES :D",0
msj9_P2 db "                             Adivinaste el numero: ",0
msj10_P2 db " con una cantidad de ",0
msj11_P2 db " intento(s)",0
msj12_P2 db "                                                      PERDISTE :'(",0
msj13_P2 db "                                           NO PUDISTE ADIVIAR EL NUMERO: ",0
msj14_P2 db "                                                    Juego Terminado",0

var_Iterador dword 0
var_Intentos dword 0 
var_NumeroIntentos dword 0
var_NumeroPicas dword 0
var_NumeroFijas dword 0

var_NumeroGenerado dword 0
var_RespaldoNumeroGenerado dword 0
var_NumeroMillar_G dword 0
var_NumeroCentena_G dword 0
var_NumeroDecena_G dword 0
var_NumeroUnidad_G dword 0

var_NumeroAdivinar dword 0
var_NumeroMillar_A dword 0
var_NumeroCentena_A dword 0
var_NumeroDecena_A dword 0
var_NumeroUnidad_A dword 0
.code 

main PROC
;Lógica del Programa

	mov edx, offset msj0_P2
	call writeString
	call CrLf
	mov edx, offset msj1_P2
	call writeString
	call CrLf
	call CrLf
	call CrLf
	mov edx, offset msj2_P2
	call writeString
	call readInt
	mov var_NumeroGenerado, eax
	mov var_RespaldoNumeroGenerado, eax
	mov edx, offset msj3_P2
	call writeString
	call readInt
	mov var_NumeroIntentos, eax
	call CrLf

;;;;  SE PROCEDE A SEPARAR EL NUMERO "GENERADOR POR EL USUARIO"  EN EL SISTEMA DECIMAL: MILLAR, CENTENA, DECENA y UNIDAD  ;;;;
;;;;  Unidad de Millar  ;;;;
	mov eax, var_NumeroGenerado
	mov ebx, 1000d
	mov edx, 0
	div ebx
	mov var_NumeroMillar_G, eax
	mul ebx
	sub var_NumeroGenerado, eax

;;;;  Unidad de Centena  ;;;;
	mov eax, var_NumeroGenerado
	mov ebx, 100d
	mov edx, 0
	div ebx
	mov var_NumeroCentena_G, eax
	mul ebx
	sub var_NumeroGenerado, eax

;;;;  Unidad de Decena  ;;;;
	mov eax, var_NumeroGenerado
	mov ebx, 10d
	mov edx, 0
	div ebx
	mov var_NumeroDecena_G, eax
	mul ebx
	sub var_NumeroGenerado, eax

;;;;  Unidad de Unidad  ;;;;
	mov eax, var_NumeroGenerado
	mov var_NumeroUnidad_G, eax

;;;;  SE LIMPIA PANTALLA PARA QUE EL JUGADOR NO VEA EL NUMERO A ADIVINAR  ;;;;
	call ClrScr

;;;;  CICLO QUE SERVIRA PARA QUE EL JUGADOR INTENTE ADIVIAR EL NUMERO "GENERADO" POR EL USUARIO  ;;;;
	mov ecx, 1
	mov eax, var_NumeroIntentos
	mov var_Iterador, eax

	ciclo:
		add var_Intentos, 1d

		mov edx, offset msj4_P2
		call writeString
		mov eax, ecx
		call writeDec
		mov edx, offset msj5_P2
		call writeString
		call readInt
		mov var_NumeroAdivinar, eax

;;;;  SE PROCEDE A SEPARAR EL NUMERO "A ADIVINAR POR EL JUGADOR"  EN EL SISTEMA DECIMAL: MILLAR, CENTENA, DECENA y UNIDAD  ;;;;
	;;;;  Unidad de Millar  ;;;;
		mov eax, var_NumeroAdivinar
		mov ebx, 1000d
		mov edx, 0
		div ebx
		mov var_NumeroMillar_A, eax
		mul ebx
		sub var_NumeroAdivinar, eax

	;;;;  Unidad de Centena  ;;;;
		mov eax, var_NumeroAdivinar
		mov ebx, 100d
		mov edx, 0
		div ebx
		mov var_NumeroCentena_A, eax
		mul ebx
		sub var_NumeroAdivinar, eax

	;;;;  Unidad de Decena  ;;;;
		mov eax, var_NumeroAdivinar
		mov ebx, 10d
		mov edx, 0
		div ebx
		mov var_NumeroDecena_A, eax
		mul ebx
		sub var_NumeroAdivinar, eax

	;;;;  Unidad de Unidad  ;;;;
		mov eax, var_NumeroAdivinar
		mov var_NumeroUnidad_A, eax

;;;;  SE PROCEDE A COMPARAR EL NUMERO "GENERADO" POR EL USUARIO Y EL NUMERO A ADIVINAR POR EL JUGADOR   ;;;;
		mov eax, var_NumeroMillar_G
		mov ebx, var_NumeroMillar_A
		cmp ebx, eax

		;;;;  EVALUACIÓN FIJAS MILLAR   ;;;;
		je NumeroMillar_G_IGUAL_NumeroMillar_A
		jmp continuar
		NumeroMillar_G_IGUAL_NumeroMillar_A:
			add var_NumeroFijas, 1d
		continuar:
		
		;;;; EVALUACIÓN PICAS MILLAR    ;;;;
			cmp eax, var_NumeroCentena_A 
			jne saltoM1
				add var_NumeroPicas, 1d
			saltoM1:
			cmp eax, var_NumeroDecena_A 
			jne saltoM2
				add var_NumeroPicas, 1d
			saltoM2:
			cmp eax, var_NumeroUnidad_A
			jne saltoM3
				add var_NumeroPicas, 1d
			saltoM3:

		mov eax, var_NumeroCentena_G
		mov ebx, var_NumeroCentena_A
		cmp ebx, eax

		;;;;  EVALUACIÓN FIJAS CENTENA   ;;;;
		je NumeroCentena_G_IGUAL_NumeroCentena_A
		jmp continuar2
		NumeroCentena_G_IGUAL_NumeroCentena_A:
			add var_NumeroFijas, 1d
		continuar2:

		;;;;  EVALUACIÓN PICAS CENTENA   ;;;;
		cmp eax, var_NumeroMillar_A
		jne saltoC1
			add var_NumeroPicas, 1d
		saltoC1:

		cmp eax, var_NumeroDecena_A
		jne saltoC2
			add var_NumeroPicas, 1d
		saltoC2:

		cmp eax, var_NumeroUnidad_A
		jne saltoC3	
			add var_NumeroPicas, 1d
		saltoC3:

		mov eax, var_NumeroDecena_G
		mov ebx, var_NumeroDecena_A
		cmp ebx, eax

		;;;;  EVALUACIÓN FIJAS DECENA   ;;;;
		je NumeroDecena_G_IGUAL_NumeroDecena_A
		jmp continuar3
		NumeroDecena_G_IGUAL_NumeroDecena_A:
			add var_NumeroFijas, 1d
		continuar3:

		;;;;  EVALUACIÓN PICAS CENTENA   ;;;;
		cmp eax, var_NumeroMillar_A
		jne saltoD1
			add var_NumeroPicas, 1d
		saltoD1:

		cmp eax, var_NumeroCentena_A
		jne saltoD2
			add var_NumeroPicas, 1d
		saltoD2:

		cmp eax, var_NumeroUnidad_A
		jne saltoD3
			add var_NumeroPicas, 1d
		saltoD3:	

		mov eax, var_NumeroUnidad_G
		mov ebx, var_NumeroUnidad_A
		cmp ebx, eax

		;;;;  EVALUACIÓN FIJAS CENTENA   ;;;;
		je NumeroUnidad_G_IGUAL_NumeroUnidad_A
		jmp continuar4
		NumeroUnidad_G_IGUAL_NumeroUnidad_A:
			add var_NumeroFijas, 1d
		continuar4:
		
		;;;;  EVALUACIÓN PICAS UNIDAD  ;;;; 
		cmp eax, var_NumeroMillar_A
		jne saltoU1
			add var_NumeroPicas, 1d
		saltoU1:
		cmp eax, var_NumeroCentena_A
		jne saltoU2
			add var_NumeroPicas, 1d
		saltoU2:
		cmp eax, var_NumeroDecena_A
		jne saltoU3
			add var_NumeroPicas, 1d
		saltoU3:


;;;; SE IMPRIME LA CANTIDAD DE PICAS y JIFAS POR INTENTO  ;;;;
		mov edx, offset msj6_P2
		call writeString
		mov eax, var_NumeroPicas
		call writeDec
		call CrLf
		mov edx, offset msj7_P2
		call writeString
		mov eax, var_NumeroFijas
		call writeDec
		call CrLf
		call CrLf

;;;;  SE COMPARA SÍ LA CANTIDAD DE FIJAS ES IGUAL 4 PARA TERMINAR EL JUEGO ;;;;
;;;;  Y NOTIFICAR AL JUGADOR QUE GANO LA PARTIDA  ;;;;
		mov eax, 4d
		mov ebx, var_NumeroFijas
		cmp eax, ebx

		je ganador
		jmp continuar5
		ganador:
			mov edx, offset msj8_P2
			call writeString
			call CrLf
			mov edx, offset msj9_P2
			call writeString
			mov eax, var_RespaldoNumeroGenerado
			call writeDec
			mov edx, offset msj10_P2
			call writeString
			mov eax, var_Intentos
			call writeDec
			mov edx, offset msj11_P2
			call writeString
			call CrLf
			mov edx, offset msj14_P2
			call writeString
			call CrLf
			call CrLf
			jmp continuar6

		continuar5:
		mov var_NumeroPicas, 0d
		mov var_NumeroFijas, 0d

		;;;;   ITERADOR  ;;;;
		mov eax, var_Iterador

	inc ecx
	cmp ecx, var_Iterador
	jle ciclo

;;;; SE IMPRIME UN MENSAJE NOTIFICANDO AL JUGADOR QUE PERDIO LA PARTIDA  ;;;;
	mov edx, offset msj12_P2
	call writeString
	call CrLf
	mov edx, offset msj13_P2
	call writeString
	mov eax, var_RespaldoNumeroGenerado
	call writeDec
	call CrLf
	mov edx, offset msj14_P2
	call writeString
	call CrLf
	call CrLf

	continuar6:

exit

main ENDP

END main