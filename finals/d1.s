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
process:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -1152
move $t0, $a0
li $t1, 3
move $t2, $t1
li $t3, 11
li $t4, 3
mul $t5, $t3, $t4
li $t6, 2
sub $t7, $t5, $t6
li $s0, 5
add $s1, $t7, $s0
move $t2, $s1
move $s2, $t0
li $s3, 321
mul $s4, $s2, $s3
li $s5, 2
mul $s6, $s4, $s5
move $s7, $t0
move $t8, $t2
mul $t9, $s7, $t8
sw $t9, -8($fp)
add $t9, $s6, $t9
sw $t8, -12($fp)
move $t8, $t0
sw $t8, -16($fp)
sub $t8, $t9, $t8
sw $t9, -20($fp)
move $t9, $t2
sw $s7, -24($fp)
move $s7, $t0
sw $s7, -28($fp)
mul $s7, $t9, $s7
sw $s7, -32($fp)
add $s7, $t8, $s7
sw $t9, -36($fp)
move $t9, $t2
sw $t8, -40($fp)
move $t8, $t2
sw $t8, -44($fp)
mul $t8, $t9, $t8
sw $t8, -48($fp)
add $t8, $s7, $t8
sw $t9, -52($fp)
move $t9, $t0
sw $t9, -56($fp)
add $t9, $t8, $t9
sw $t8, -60($fp)
move $t8, $t0
sw $t8, -64($fp)
add $t8, $t9, $t8
sw $t9, -68($fp)
li $t9, 23
sw $t9, -72($fp)
sub $t9, $t8, $t9
sw $t8, -76($fp)
li $t8, 45
sw $t8, -80($fp)
add $t8, $t9, $t8
move $t2, $t8
sw $t8, -84($fp)
move $t8, $t2
sw $t9, -88($fp)
li $t9, 3
sw $t9, -92($fp)
div $t8, $t9
mflo $t9
sw $t8, -96($fp)
li $t8, 14
sw $s7, -100($fp)
li $s7, 24
sw $s7, -104($fp)
mul $s7, $t8, $s7
sw $s7, -108($fp)
add $s7, $t9, $s7
sw $t8, -112($fp)
move $t8, $t0
sw $t9, -116($fp)
li $t9, 12
sw $t9, -120($fp)
mul $t9, $t8, $t9
sw $t8, -124($fp)
li $t8, 4
sw $t8, -128($fp)
div $t9, $t8
mflo $t8
sw $t8, -132($fp)
sub $t8, $s7, $t8
sw $t9, -136($fp)
li $t9, 20
sw $s7, -140($fp)
li $s7, 3
sw $s7, -144($fp)
mul $s7, $t9, $s7
sw $s7, -148($fp)
sub $s7, $t8, $s7
sw $t9, -152($fp)
move $t9, $t2
sw $t8, -156($fp)
li $t8, 12
sw $t8, -160($fp)
div $t9, $t8
mflo $t8
sw $t9, -164($fp)
li $t9, 24
sw $t9, -168($fp)
mul $t9, $t8, $t9
sw $t9, -172($fp)
add $t9, $s7, $t9
sw $t8, -176($fp)
li $t8, 12
sw $s7, -180($fp)
li $s7, 3
sw $s7, -184($fp)
mul $s7, $t8, $s7
sw $s7, -188($fp)
add $s7, $t9, $s7
sw $t8, -192($fp)
li $t8, 3
sw $t9, -196($fp)
li $t9, 2
sw $t9, -200($fp)
div $t8, $t9
mflo $t9
sw $t9, -204($fp)
add $t9, $s7, $t9
move $t2, $t9
sw $t9, -208($fp)
move $t9, $t0
sw $t8, -212($fp)
li $t8, 4
sw $s7, -216($fp)
li $s7, 6
sw $s7, -220($fp)
mul $s7, $t8, $s7
sw $s7, -224($fp)
add $s7, $t9, $s7
sw $t8, -228($fp)
li $t8, 3
sw $t9, -232($fp)
li $t9, 2
sw $t9, -236($fp)
div $t8, $t9
mflo $t9
sw $t9, -240($fp)
add $t9, $s7, $t9
move $t2, $t9
sw $t9, -244($fp)
move $t9, $t2
move $v0, $t9
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -248($fp)
sw $t1, -252($fp)
sw $t2, -256($fp)
sw $t3, -260($fp)
sw $t4, -264($fp)
sw $t5, -268($fp)
sw $t6, -272($fp)
sw $t7, -276($fp)
sw $s0, -280($fp)
sw $s1, -284($fp)
sw $s2, -288($fp)
sw $s3, -292($fp)
sw $s4, -296($fp)
sw $s5, -300($fp)
sw $s6, -304($fp)
sw $s7, -308($fp)
sw $t8, -312($fp)
sw $t9, -316($fp)
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -1152
li $t0, 5
li $t1, 2
div $t0, $t1
mflo $t2
li $t3, 14
add $t4, $t2, $t3
li $t5, 3
sub $t6, $t4, $t5
move $t7, $t6
li $s0, 7
li $s1, 5
mul $s2, $s0, $s1
li $s3, 2
div $s2, $s3
mflo $s4
li $s5, 3
add $s6, $s4, $s5
move $s7, $s6
li $t8, 4
li $t9, 5
sw $t9, -8($fp)
add $t9, $t8, $t9
sw $t8, -12($fp)
li $t8, 6
sw $t8, -16($fp)
add $t8, $t9, $t8
sw $t9, -20($fp)
li $t9, 1
sw $s6, -24($fp)
li $s6, 2
sw $s6, -28($fp)
div $t9, $s6
mflo $s6
sw $s6, -32($fp)
sub $s6, $t8, $s6
sw $s6, -36($fp)
move $s6, $s6
sw $t9, -40($fp)
move $t9, $t7
sw $t8, -44($fp)
move $t8, $s7
sw $t8, -48($fp)
add $t8, $t9, $t8
sw $t9, -52($fp)
move $t9, $s6
sw $t9, -56($fp)
add $t9, $t8, $t9
sw $t9, -60($fp)
move $t9, $t9
sw $t9, -64($fp)
move $t9, $t7
sw $t8, -68($fp)
move $t8, $s7
sw $t8, -72($fp)
mul $t8, $t9, $t8
sw $t9, -76($fp)
move $t9, $s6
sw $s5, -80($fp)
li $s5, 2
sw $s5, -84($fp)
div $t9, $s5
mflo $s5
sw $s5, -88($fp)
add $s5, $t8, $s5
sw $s5, -92($fp)
move $s5, $s5
sw $s5, -96($fp)
move $s5, $t7
sw $t9, -100($fp)
move $t9, $s7
sw $t9, -104($fp)
sub $t9, $s5, $t9
sw $s5, -108($fp)
move $s5, $s6
sw $s5, -112($fp)
sub $s5, $t9, $s5
sw $s5, -116($fp)
move $s5, $s5
sw $t9, -120($fp)
li $t9, 42
sw $t9, -124($fp)
move $t9, $t9
sw $t9, -128($fp)
li $t9, 0
sw $t9, -132($fp)
move $t9, $t9
sw $t9, -136($fp)
move $t9, $t7
sw $t8, -140($fp)
move $t8, $s7
sw $t8, -144($fp)
add $t8, $t9, $t8
sw $t9, -148($fp)
move $t9, $s6
sw $t9, -152($fp)
add $t9, $t8, $t9
sw $t8, -156($fp)
li $t8, 1000
sw $s6, -160($fp)
li $s6, 2
sw $s6, -164($fp)
mul $s6, $t8, $s6
sw $s6, -168($fp)
add $s6, $t9, $s6
sw $t8, -172($fp)
move $t8, $s5
sw $t8, -176($fp)
sub $t8, $s6, $t8
move $s5, $t8
sw $t0, -180($fp)
sw $t1, -184($fp)
sw $t2, -188($fp)
sw $t3, -192($fp)
sw $t4, -196($fp)
sw $t5, -200($fp)
sw $t6, -204($fp)
sw $t7, -208($fp)
sw $s0, -212($fp)
sw $s1, -216($fp)
sw $s2, -220($fp)
sw $s3, -224($fp)
sw $s4, -228($fp)
sw $s7, -232($fp)
sw $s5, -236($fp)
sw $t9, -240($fp)
sw $s6, -244($fp)
sw $t8, -248($fp)
label1:
lw $t0, -208($fp)
move $t0, $t0
lw $t1, -232($fp)
move $t1, $t1
add $t2, $t0, $t1
lw $t3, -236($fp)
move $t3, $t3
sw $t0, -252($fp)
sw $t1, -256($fp)
sw $t2, -260($fp)
sw $t3, -264($fp)
lw $t0, -260($fp)
lw $t1, -264($fp)
blt $t0, $t1, label2
j label3
label2:
lw $t0, -128($fp)
move $t1, $t0
lw $t2, -136($fp)
move $t3, $t2
li $t4, 12
mul $t5, $t3, $t4
add $t6, $t1, $t5
li $t7, 4
add $s0, $t6, $t7
li $s1, 5
add $s2, $s0, $s1
li $s3, 7
li $s4, 3
div $s3, $s4
mflo $s5
add $s6, $s2, $s5
move $t0, $s6
lw $s7, -236($fp)
move $t8, $s7
move $a0, $t8
sw $t1, -268($fp)
sw $t0, -128($fp)
sw $t3, -272($fp)
sw $t2, -136($fp)
sw $t4, -276($fp)
sw $t5, -280($fp)
sw $t6, -284($fp)
sw $t7, -288($fp)
sw $s0, -292($fp)
sw $s1, -296($fp)
sw $s2, -300($fp)
sw $s3, -304($fp)
sw $s4, -308($fp)
sw $s5, -312($fp)
sw $s6, -316($fp)
sw $t8, -320($fp)
sw $s7, -236($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal process
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
li $t1, 2
lw $t2, -208($fp)
move $t3, $t2
mul $t4, $t1, $t3
add $t5, $t0, $t4
lw $t6, -236($fp)
move $t6, $t6
sub $t7, $t5, $t6
lw $s0, -160($fp)
move $s0, $s0
lw $s1, -64($fp)
move $s1, $s1
mul $s2, $s0, $s1
add $s3, $t7, $s2
move $s4, $s3
lw $s5, -136($fp)
move $s6, $s5
move $s7, $s5
add $t8, $s6, $s7
move $s5, $t8
move $t9, $s5
sw $t8, -324($fp)
move $t8, $s5
sw $t8, -328($fp)
add $t8, $t9, $t8
move $s5, $t8
sw $t8, -332($fp)
move $t8, $s5
sw $t9, -336($fp)
move $t9, $s5
sw $t9, -340($fp)
add $t9, $t8, $t9
move $s5, $t9
sw $t9, -344($fp)
move $t9, $s5
sw $t8, -348($fp)
move $t8, $s5
sw $t8, -352($fp)
add $t8, $t9, $t8
move $s5, $t8
sw $t8, -356($fp)
move $t8, $s5
sw $t9, -360($fp)
move $t9, $s5
sw $t9, -364($fp)
add $t9, $t8, $t9
move $s5, $t9
sw $t9, -368($fp)
move $t9, $s5
sw $t8, -372($fp)
li $t8, 3
sw $t8, -376($fp)
add $t8, $t9, $t8
sw $t8, -380($fp)
move $t8, $t8
sw $t9, -384($fp)
move $t9, $t8
sw $s7, -388($fp)
li $s7, 1
sw $s7, -392($fp)
sub $s7, $t9, $s7
move $t8, $s7
sw $s7, -396($fp)
move $s7, $t8
sw $t9, -400($fp)
li $t9, 3
sw $t9, -404($fp)
add $t9, $s7, $t9
move $t8, $t9
sw $t9, -408($fp)
move $t9, $t8
sw $s7, -412($fp)
li $s7, 3
sw $s6, -416($fp)
li $s6, 2
sw $s6, -420($fp)
mul $s6, $s7, $s6
sw $s6, -424($fp)
sub $s6, $t9, $s6
move $t8, $s6
sw $s6, -428($fp)
move $s6, $t2
move $a0, $s6
sw $s5, -136($fp)
sw $t0, -432($fp)
sw $t1, -436($fp)
sw $t3, -440($fp)
sw $t2, -208($fp)
sw $t4, -444($fp)
sw $t5, -448($fp)
sw $t6, -452($fp)
sw $t7, -456($fp)
sw $s0, -460($fp)
sw $s1, -464($fp)
sw $s2, -468($fp)
sw $s3, -472($fp)
sw $s4, -476($fp)
sw $t8, -480($fp)
sw $t9, -484($fp)
sw $s7, -488($fp)
sw $s6, -492($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal process
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
lw $t1, -208($fp)
move $t1, $t1
li $t2, 3
add $t3, $t1, $t2
li $t4, 2
sub $t5, $t3, $t4
li $t6, 1
sub $t7, $t5, $t6
move $a0, $t7
sw $t0, -496($fp)
sw $t1, -500($fp)
sw $t2, -504($fp)
sw $t3, -508($fp)
sw $t4, -512($fp)
sw $t5, -516($fp)
sw $t6, -520($fp)
sw $t7, -524($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
jal process
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
sw $t0, -528($fp)
lw $t0, -496($fp)
lw $t1, -528($fp)
beq $t0, $t1, label4
j label5
label4:
lw $t0, -236($fp)
move $t1, $t0
li $t2, 2
sub $t3, $t1, $t2
li $t4, 1
add $t5, $t3, $t4
move $t0, $t5
sw $t1, -532($fp)
sw $t0, -236($fp)
sw $t2, -536($fp)
sw $t3, -540($fp)
sw $t4, -544($fp)
sw $t5, -548($fp)
label5:
lw $t0, -208($fp)
move $t1, $t0
li $t2, 2
add $t3, $t1, $t2
li $t4, 1
add $t5, $t3, $t4
move $t0, $t5
sw $t1, -552($fp)
sw $t0, -208($fp)
sw $t2, -556($fp)
sw $t3, -560($fp)
sw $t4, -564($fp)
sw $t5, -568($fp)
j label1
label3:
lw $t0, -128($fp)
move $t0, $t0
li $t1, 3
li $t2, 4
mul $t3, $t1, $t2
sub $t4, $t0, $t3
move $t5, $t4
sw $t0, -572($fp)
sw $t1, -576($fp)
sw $t2, -580($fp)
sw $t3, -584($fp)
sw $t4, -588($fp)
sw $t5, -480($fp)
label6:
lw $t0, -480($fp)
move $t0, $t0
lw $t1, -128($fp)
move $t1, $t1
sw $t0, -592($fp)
sw $t1, -596($fp)
lw $t0, -592($fp)
lw $t1, -596($fp)
blt $t0, $t1, label7
j label8
label7:
li $t0, 15
li $t1, 4
mul $t2, $t0, $t1
li $t3, 2
sub $t4, $t2, $t3
lw $t5, -208($fp)
move $t6, $t5
add $t7, $t4, $t6
move $s0, $t7
lw $s1, -128($fp)
move $s2, $s1
li $s3, 12
sub $s4, $s2, $s3
move $s5, $s4
lw $s6, -480($fp)
move $s7, $s6
li $t8, 1
add $t9, $s7, $t8
move $s6, $t9
move $s1, $s1
move $s5, $s1
sw $s1, -600($fp)
move $s1, $t5
sw $t9, -604($fp)
lw $t9, -232($fp)
sw $t9, -232($fp)
move $t9, $t9
sw $t9, -608($fp)
add $t9, $s1, $t9
sw $t9, -612($fp)
move $t9, $t9
move $t5, $t5
sw $t9, -136($fp)
lw $t9, -232($fp)
move $t9, $t9
sw $t9, -616($fp)
add $t9, $t5, $t9
sw $t9, -620($fp)
move $t9, $t9
sw $t0, -624($fp)
sw $t1, -628($fp)
sw $t2, -632($fp)
sw $t3, -636($fp)
sw $t4, -640($fp)
sw $t6, -644($fp)
sw $t7, -648($fp)
sw $s0, -236($fp)
sw $s2, -652($fp)
sw $s3, -656($fp)
sw $s4, -660($fp)
sw $s5, -476($fp)
sw $s7, -664($fp)
sw $s6, -480($fp)
sw $t8, -668($fp)
sw $s1, -672($fp)
sw $t5, -676($fp)
sw $t9, -160($fp)
j label6
label8:
lw $t0, -236($fp)
move $t1, $t0
move $a0, $t1
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
lw $t2, -208($fp)
move $t3, $t2
lw $t4, -232($fp)
move $t5, $t4
add $t6, $t3, $t5
move $t2, $t6
move $t7, $t2
move $s0, $t4
add $s1, $t7, $s0
move $t4, $s1
move $s2, $t2
move $s3, $t4
add $s4, $s2, $s3
move $s5, $s4
move $s6, $t2
move $s7, $t4
add $t8, $s6, $s7
move $t0, $t8
move $t9, $t2
sw $t8, -680($fp)
move $t8, $t4
sw $t8, -684($fp)
add $t8, $t9, $t8
sw $t8, -688($fp)
move $t8, $t8
sw $t9, -692($fp)
move $t9, $s5
sw $s7, -696($fp)
move $s7, $t0
sw $s7, -700($fp)
add $s7, $t9, $s7
sw $t9, -704($fp)
move $t9, $t8
sw $t9, -708($fp)
add $t9, $s7, $t9
move $a0, $t9
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s7, -712($fp)
li $s7, 0
move $v0, $s7
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t1, -716($fp)
sw $t0, -236($fp)
sw $t3, -720($fp)
sw $t2, -208($fp)
sw $t5, -724($fp)
sw $t4, -232($fp)
sw $t6, -728($fp)
sw $t7, -732($fp)
sw $s0, -736($fp)
sw $s1, -740($fp)
sw $s2, -744($fp)
sw $s3, -748($fp)
sw $s4, -752($fp)
sw $s5, -160($fp)
sw $s6, -756($fp)
sw $t8, -476($fp)
sw $t9, -760($fp)
sw $s7, -764($fp)
