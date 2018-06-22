.data
_prompt: .asciiz "Enter an integer:"
_ret: .asciiz "\n"
.globl main
.text
read:
li $v0, 4
	la $a0, _prompt
	syscall
	li $v0, 5
	syscall
	jr $ra
write:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, _ret
	syscall
	move $v0, $0
	jr $ra
trap:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -496
li $t0, 0
move $t1, $t0
li $t2, 0
move $t3, $t2
li $t4, 0
move $t5, $t4
li $t6, 0
move $t7, $t6
li $s0, 0
move $s1, $s0
li $s2, 12
move $s3, $s2
li $s4, 0
move $s5, $s4
addi $sp, $sp, -48
sw $t0, -56($fp)
sw $t1, -60($fp)
sw $t2, -64($fp)
sw $t3, -68($fp)
sw $t4, -72($fp)
sw $t5, -76($fp)
sw $t6, -80($fp)
sw $t7, -84($fp)
sw $s0, -88($fp)
sw $s1, -92($fp)
sw $s2, -96($fp)
sw $s3, -100($fp)
sw $s4, -104($fp)
sw $s5, -108($fp)
label1:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -100($fp)
move $t1, $t1
sw $t0, -112($fp)
sw $t1, -116($fp)
lw $t0, -112($fp)
lw $t1, -116($fp)
blt $t0, $t1, label2
j label3
label2:
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
lw $t1, -76($fp)
move $t2, $t1
li $t3, 4
mul $t2, $t2, $t3
la $t3, -52($fp)
add $t3, $t3, $t2
move $t4, $t3
sw $t0, 0($t4)
move $t5, $t1
li $t6, 1
add $t7, $t5, $t6
move $t1, $t7
sw $t0, -120($fp)
sw $t2, -124($fp)
sw $t1, -76($fp)
sw $t3, -128($fp)
sw $t4, -132($fp)
sw $t5, -136($fp)
sw $t6, -140($fp)
sw $t7, -144($fp)
j label1
label3:
li $t0, 0
move $t1, $t0
sw $t0, -148($fp)
sw $t1, -76($fp)
label4:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -100($fp)
move $t1, $t1
sw $t0, -152($fp)
sw $t1, -156($fp)
lw $t0, -152($fp)
lw $t1, -156($fp)
blt $t0, $t1, label7
j label6
label7:
lw $t0, -76($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t1, -52($fp)
add $t1, $t1, $t0
lw $t2, 0($t1)
li $t3, 0
sw $t0, -160($fp)
sw $t1, -164($fp)
sw $t2, -168($fp)
sw $t3, -172($fp)
lw $t0, -168($fp)
lw $t1, -172($fp)
beq $t0, $t1, label5
j label6
label5:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -176($fp)
sw $t0, -76($fp)
sw $t2, -180($fp)
sw $t3, -184($fp)
j label4
label6:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -100($fp)
move $t1, $t1
sw $t0, -188($fp)
sw $t1, -192($fp)
lw $t0, -188($fp)
lw $t1, -192($fp)
bge $t0, $t1, label8
j label9
label8:
li $t0, 0
move $v0, $t0
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -196($fp)
label9:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t2, -52($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
move $t4, $t3
move $t5, $t0
move $t6, $t5
li $t7, 0
move $s0, $t7
move $s1, $t0
li $s2, 1
add $s3, $s1, $s2
move $t0, $s3
sw $t1, -200($fp)
sw $t0, -76($fp)
sw $t2, -204($fp)
sw $t3, -208($fp)
sw $t4, -60($fp)
sw $t5, -212($fp)
sw $t6, -68($fp)
sw $t7, -216($fp)
sw $s0, -92($fp)
sw $s1, -220($fp)
sw $s2, -224($fp)
sw $s3, -228($fp)
label10:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -100($fp)
move $t1, $t1
sw $t0, -232($fp)
sw $t1, -236($fp)
lw $t0, -232($fp)
lw $t1, -236($fp)
blt $t0, $t1, label11
j label12
label11:
lw $t0, -76($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t1, -52($fp)
add $t1, $t1, $t0
lw $t2, 0($t1)
lw $t3, -60($fp)
move $t3, $t3
sw $t0, -240($fp)
sw $t1, -244($fp)
sw $t2, -248($fp)
sw $t3, -252($fp)
lw $t0, -248($fp)
lw $t1, -252($fp)
blt $t0, $t1, label13
j label14
label13:
lw $t0, -92($fp)
move $t1, $t0
lw $t2, -60($fp)
move $t2, $t2
lw $t3, -76($fp)
move $t3, $t3
li $t4, 4
mul $t3, $t3, $t4
la $t4, -52($fp)
add $t4, $t4, $t3
lw $t5, 0($t4)
sub $t6, $t2, $t5
add $t7, $t1, $t6
move $t0, $t7
sw $t1, -256($fp)
sw $t0, -92($fp)
sw $t2, -260($fp)
sw $t3, -264($fp)
sw $t4, -268($fp)
sw $t5, -272($fp)
sw $t6, -276($fp)
sw $t7, -280($fp)
j label15
label14:
lw $t0, -84($fp)
move $t1, $t0
lw $t2, -92($fp)
move $t3, $t2
add $t4, $t1, $t3
move $t0, $t4
lw $t5, -76($fp)
move $t6, $t5
li $t7, 4
mul $t6, $t6, $t7
la $t7, -52($fp)
add $t7, $t7, $t6
lw $s0, 0($t7)
move $s1, $s0
move $t5, $t5
move $s2, $t5
li $s3, 0
move $t2, $s3
sw $t1, -284($fp)
sw $t0, -84($fp)
sw $t3, -288($fp)
sw $t2, -92($fp)
sw $t4, -292($fp)
sw $t6, -296($fp)
sw $t7, -300($fp)
sw $s0, -304($fp)
sw $s1, -60($fp)
sw $t5, -308($fp)
sw $s2, -68($fp)
sw $s3, -312($fp)
label15:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -316($fp)
sw $t0, -76($fp)
sw $t2, -320($fp)
sw $t3, -324($fp)
j label10
label12:
li $t0, 0
move $t1, $t0
li $t2, 0
move $t3, $t2
lw $t4, -100($fp)
move $t4, $t4
li $t5, 1
sub $t6, $t4, $t5
move $t7, $t6
sw $t0, -328($fp)
sw $t1, -92($fp)
sw $t2, -332($fp)
sw $t3, -108($fp)
sw $t4, -336($fp)
sw $t5, -340($fp)
sw $t6, -344($fp)
sw $t7, -76($fp)
label16:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -68($fp)
move $t1, $t1
sw $t0, -348($fp)
sw $t1, -352($fp)
lw $t0, -348($fp)
lw $t1, -352($fp)
bgt $t0, $t1, label19
j label18
label19:
lw $t0, -76($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t1, -52($fp)
add $t1, $t1, $t0
lw $t2, 0($t1)
li $t3, 0
sw $t0, -356($fp)
sw $t1, -360($fp)
sw $t2, -364($fp)
sw $t3, -368($fp)
lw $t0, -364($fp)
lw $t1, -368($fp)
beq $t0, $t1, label17
j label18
label17:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 1
sub $t3, $t1, $t2
move $t0, $t3
sw $t1, -372($fp)
sw $t0, -76($fp)
sw $t2, -376($fp)
sw $t3, -380($fp)
j label16
label18:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t2, -52($fp)
add $t2, $t2, $t1
lw $t3, 0($t2)
move $t4, $t3
move $t5, $t0
li $t6, 1
sub $t7, $t5, $t6
move $t0, $t7
sw $t1, -384($fp)
sw $t0, -76($fp)
sw $t2, -388($fp)
sw $t3, -392($fp)
sw $t4, -108($fp)
sw $t5, -396($fp)
sw $t6, -400($fp)
sw $t7, -404($fp)
label20:
lw $t0, -76($fp)
move $t0, $t0
lw $t1, -68($fp)
move $t1, $t1
sw $t0, -408($fp)
sw $t1, -412($fp)
lw $t0, -408($fp)
lw $t1, -412($fp)
bgt $t0, $t1, label21
j label22
label21:
lw $t0, -76($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t1, -52($fp)
add $t1, $t1, $t0
lw $t2, 0($t1)
lw $t3, -108($fp)
move $t3, $t3
sw $t0, -416($fp)
sw $t1, -420($fp)
sw $t2, -424($fp)
sw $t3, -428($fp)
lw $t0, -424($fp)
lw $t1, -428($fp)
blt $t0, $t1, label23
j label24
label23:
lw $t0, -92($fp)
move $t1, $t0
lw $t2, -108($fp)
move $t2, $t2
lw $t3, -76($fp)
move $t3, $t3
li $t4, 4
mul $t3, $t3, $t4
la $t4, -52($fp)
add $t4, $t4, $t3
lw $t5, 0($t4)
sub $t6, $t2, $t5
add $t7, $t1, $t6
move $t0, $t7
sw $t1, -432($fp)
sw $t0, -92($fp)
sw $t2, -436($fp)
sw $t3, -440($fp)
sw $t4, -444($fp)
sw $t5, -448($fp)
sw $t6, -452($fp)
sw $t7, -456($fp)
j label25
label24:
lw $t0, -84($fp)
move $t1, $t0
lw $t2, -92($fp)
move $t3, $t2
add $t4, $t1, $t3
move $t0, $t4
lw $t5, -76($fp)
move $t5, $t5
li $t6, 4
mul $t5, $t5, $t6
la $t6, -52($fp)
add $t6, $t6, $t5
lw $t7, 0($t6)
move $s0, $t7
li $s1, 0
move $t2, $s1
sw $t1, -460($fp)
sw $t0, -84($fp)
sw $t3, -464($fp)
sw $t2, -92($fp)
sw $t4, -468($fp)
sw $t5, -472($fp)
sw $t6, -476($fp)
sw $t7, -480($fp)
sw $s0, -108($fp)
sw $s1, -484($fp)
label25:
lw $t0, -76($fp)
move $t1, $t0
li $t2, 1
sub $t3, $t1, $t2
move $t0, $t3
sw $t1, -488($fp)
sw $t0, -76($fp)
sw $t2, -492($fp)
sw $t3, -496($fp)
j label20
label22:
lw $t0, -84($fp)
move $t0, $t0
lw $t1, -92($fp)
move $t1, $t1
add $t2, $t0, $t1
move $v0, $t2
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -500($fp)
sw $t1, -504($fp)
sw $t2, -508($fp)
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -496
addi $sp, $sp, -4
sw $ra, 0($sp)
jal trap
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
move $t2, $t1
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t3, 0
move $v0, $t3
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -8($fp)
sw $t1, -12($fp)
sw $t2, -16($fp)
sw $t3, -20($fp)
