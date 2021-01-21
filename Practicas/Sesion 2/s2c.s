	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	ret_fin: la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
move $s0, $a0	#$si = w // vec
move $s1, $a1	#$s2 = 31 // num

addiu $sp, $sp, -40	#Allibera espai en la memoria per histo[10]
move $t0, $sp		#$t0 = $sp
li $t1, 0		#k = 0
li $t2, 10		#$t2 = 10
for:
sw $zero, 0($t0)	#histo[k] = 0
addiu $t0, $t0, 4	#$t0 =+ 4
addiu $t1, $t1, 1	#k++
blt $t1, $t2, for	# si k < 10 segueix bucle

li $v0, '0'		#max = '0'
li $s2, 0		#k = 0
for2:
move $a0, $sp		#&histo
addu $t0, $s0, $s2	#&vec[k]
lb $t0, 0($t0)		#*vec[k]
li $t3, '0'
subu $a1, $t0, $t3	#vec[k] - '0'
subu $a2, $v0, $t3	#max - '0'

b update

ret: addiu $v0, $v0, '0'	#max = '0' + upadte(histo, vec[k] - '0', max - '0')
addiu $s2, $s2, 1		#k++;
blt $s2, $s1, for2

addiu $sp, $sp, 40	#retorna espai

b ret_fin

update:
move $s3, $a0	#$s3 = &h
move $s4, $a1	#$s4 = i
move $s5, $a2	#$s5 = imax

jal nofares

sll $t0, $s4, 2		#i * 4
addu $t0, $s3, $t0	#&h[0] + i * 4
lw $t1, 0($t0)		#*h[i]
addiu $t1, $t1, 1	
sw $t1, 0($t0) 		#*h[i]++

sll $t2, $s5, 2		#imax * 4
addu $t2, $s3, $t2	#&h[0] + imax * 4
lw $t2, 0($t2)		#*h[imax]

if: ble $t1, $t2, else	#si *h[i] <= *h[imax]
move $v0, $s4		#$v0 = *h[i]
b ret
else:
move $v0, $s5		#$v0 = *h[imax]
b ret
