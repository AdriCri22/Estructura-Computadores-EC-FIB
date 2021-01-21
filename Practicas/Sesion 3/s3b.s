	# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
	.align 2
mat1: 	.space 120
mat4: 	.word 2,3,1,2,4,3
col:	.word 2

	.text 
	.globl main
main:
addiu $sp, $sp, -4
sw $ra, 0($sp)		#guarda $ra

la $a0, mat4		#&mat4
lw $a1, 8($a0)		#*mat4[0][2]

la $a2, col
lw $a2, 0($a2)		#*col // 2

jal subr

la $t0, mat1		#&mat1
addiu $t0, $t0, 108	#&mat1 + (4 * 6 + 3) * 4
sw $v0, 0($t0)		#mat1[4][3] = $v0

la $a0, mat4		#&mat
li $a1, 1
li $a2, 1

jal subr

la $t1, mat1		#&mat1
sw $v0, 0($t1)		#mat1[0][0] = $v0

lw $ra, 0($sp)		#devolver $ra
addiu $sp, $sp, 4
jr $ra

subr:
la $s0, mat1
li $t0, 6
mult $a2, $t0		#j * NC
mflo $t0
addiu $t0, $t0, 5	#j * NC + 5
sll $t0, $t0, 2		#(j * NC + 5) * 4
addu $t0, $t0, $s0	#&mat1 + (j * NC + 5) * 4

li $t1, 3
mult $a1, $t1		#i * NC
mflo $t1		
addu $t1, $t1, $a2	#i * NC + j
sll $t1, $t1, 2		#(i * NC + j) * 4
addu $t1, $t1, $a0	#&x + (i * NC + j) * 4
lw $t1, 0($t1)

sw $t1, 0($t0)

move $v0, $a1

jr $ra


