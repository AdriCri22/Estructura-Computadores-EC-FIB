.data
result: .word 0
num: .byte '7'
.text
.globl main
main:
la $t0, result
la $t1, num
lb $t1, 0($t1)

if_1:
li $t2, 'a'
blt $t1, $t2, if_2
li $t2, 'z'
bgt $t1, $t2, if_2
calc:
sw $t1, 0($t0)
b end
if_2:
li $t2, 'A'
blt $t1, $t2, else_if
li $t2, 'Z'
ble $t1, $t2, calc
else_if:
li $t2, '9'
bgt $t1, $t2, else
li $t2, '0'
blt $t1, $t2, else
subu $t2, $t1, $t2
sw $t2, 0($t0)
b end
else:
li $t2, -1
sw $t2, 0($t0)
end: 
jr $ra