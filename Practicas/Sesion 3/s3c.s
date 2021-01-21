	# Sessio 3

	.data 
mat:	.word 0,0,2,0,0,0
	.word 0,0,4,0,0,0
	.word 0,0,6,0,0,0
	.word 0,0,8,0,0,0

resultat: .word 0

	.text 
	.globl main
main:
addiu $sp, $sp, -4	
sw $ra, 0($sp)		#guarda $ra

la $a0, mat		#@mat

jal suma_col

la $t0 resultat
sw $v0, 0($t0)		#resultat = suma_col(mat)

lw $ra, 0($sp)
addiu $sp, $sp, 4
jr $ra

suma_col:
li $t0, 0	#i = 0
li $t1, 0	#suma = 0
li $t2, 4	#4

addiu $t3, $a0, 8

for:
lw $t4, 0($t3)		#mat[i][2]

addu $t1, $t1, $t4	#suma += mat[i][2]

addiu $t3, $t3, 24
addiu $t0, $t0, 1	#i++
blt $t0, $t2, for

move $v0, $t1
jr $ra