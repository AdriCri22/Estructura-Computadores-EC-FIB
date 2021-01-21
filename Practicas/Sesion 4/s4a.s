	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:
	move 	$t0, $a0	#cf
	move	$t1, $a1	#s
	
	move 	$t2, $zero
	bge 	$t0, $t2, pos
 neg:	li 	$t2, 1			
	sw 	$t2, 0($t1)	#*s = negatiu
	b end_signe
	
 pos:	sw 	$zero, 0($t1)	#*s = positiu
 
 end_signe:
 	sll 	$t0, $t0, 1		#cf = cf << 1
 	
 	bne 	$t0, $zero, else
 if:	move 	$t4, $zero		#exp = 0
 	b end_else_if
 
 else:	li $t4, 18			#exp = 18
 while:	blt $t0, $zero, end_while
 	sll $t0, $t0, 1			#cf = cf << 1
 	addiu $t4, $t4, -1		#exp--
 	b while
 end_while:	
 	srl $t0, $t0, 8		#cf = cf >> 8
 	li $t2, 0x7FFFFF	
 	and $t0, $t0, $t2		#cf = (cf >> 8) & 0x7FFFFF
 	
 	addiu $t4, $t4, 127	#exp = exp + 127
 	
 end_else_if:
 	sw $t4, 0($a2)	#*e = exp
 	
 	sw $t0, 0($a3)	#*m = cf
 	
 	jr $ra 	
 	
compon:
	sll $t0, $a0, 31	#signe << 31
	
	sll $t1, $a1, 23	#exponent << 23
	
	or $v0, $t0, $t1
	or $v0, $v0, $a2	#(signe << 31) | (exponent << 23) | mantissa 
	mtc1 $v0, $f0
	
	jr $ra