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
main:
addi $sp, $sp, -4
sw $fp, 0($sp)
move $fp, $sp
addi $sp, $sp, -772
addi $sp, $sp, -32
addi $sp, $sp, -32
addi $sp, $sp, -32
addi $sp, $sp, -32
li $t0, 0
move $t1, $t0
li $t2, 0
move $t3, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t4, $v0
move $t5, $t4
sw $t0, -136($fp)
sw $t1, -140($fp)
sw $t2, -144($fp)
sw $t3, -148($fp)
sw $t4, -152($fp)
sw $t5, -156($fp)
label1:
lw $t0, -148($fp)
move $t0, $t0
lw $t1, -156($fp)
move $t1, $t1
sw $t0, -160($fp)
sw $t1, -164($fp)
lw $t0, -160($fp)
lw $t1, -164($fp)
blt $t0, $t1, label2
j label3
label2:
li $t0, 1
li $t1, 0
sub $t1, $t1, $t0
lw $t2, -148($fp)
move $t3, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t4, -36($fp)
add $t4, $t4, $t3
move $t5, $t4
sw $t1, 0($t5)
move $t6, $t2
li $t7, 1
add $s0, $t6, $t7
move $t2, $s0
sw $t0, -168($fp)
sw $t1, -172($fp)
sw $t3, -176($fp)
sw $t2, -148($fp)
sw $t4, -180($fp)
sw $t5, -184($fp)
sw $t6, -188($fp)
sw $t7, -192($fp)
sw $s0, -196($fp)
j label1
label3:
li $t0, 0
move $t1, $t0
li $t2, 1
move $t3, $t2
sw $t0, -200($fp)
sw $t1, -148($fp)
sw $t2, -204($fp)
sw $t3, -208($fp)
label4:
lw $t0, -208($fp)
move $t0, $t0
li $t1, 1
sw $t0, -212($fp)
sw $t1, -216($fp)
lw $t0, -212($fp)
lw $t1, -216($fp)
beq $t0, $t1, label5
j label6
label5:
lw $t0, -148($fp)
move $t0, $t0
lw $t1, -156($fp)
move $t1, $t1
sw $t0, -220($fp)
sw $t1, -224($fp)
lw $t0, -220($fp)
lw $t1, -224($fp)
beq $t0, $t1, label7
j label8
label7:
li $t0, 1
move $t1, $t0
li $t2, 0
move $t3, $t2
sw $t0, -228($fp)
sw $t1, -232($fp)
sw $t2, -236($fp)
sw $t3, -240($fp)
label10:
lw $t0, -240($fp)
move $t0, $t0
lw $t1, -156($fp)
move $t1, $t1
sw $t0, -244($fp)
sw $t1, -248($fp)
lw $t0, -244($fp)
lw $t1, -248($fp)
blt $t0, $t1, label11
j label12
label11:
li $t0, 1
lw $t1, -240($fp)
move $t2, $t1
li $t3, 4
mul $t2, $t2, $t3
la $t4, -68($fp)
add $t4, $t4, $t2
move $t5, $t4
sw $t0, 0($t5)
li $t6, 1
move $t7, $t1
mul $t7, $t7, $t3
la $s0, -100($fp)
add $s0, $s0, $t7
move $s1, $s0
sw $t6, 0($s1)
li $s2, 1
move $s3, $t1
mul $s3, $s3, $t3
la $t3, -132($fp)
add $t3, $t3, $s3
move $s4, $t3
sw $s2, 0($s4)
move $s5, $t1
li $s6, 1
add $s7, $s5, $s6
move $t1, $s7
sw $t0, -252($fp)
sw $t2, -256($fp)
sw $t1, -240($fp)
sw $t4, -260($fp)
sw $t5, -264($fp)
sw $t6, -268($fp)
sw $t7, -272($fp)
sw $s0, -276($fp)
sw $s1, -280($fp)
sw $s2, -284($fp)
sw $s3, -288($fp)
sw $t3, -292($fp)
sw $s4, -296($fp)
sw $s5, -300($fp)
sw $s6, -304($fp)
sw $s7, -308($fp)
j label10
label12:
li $t0, 0
move $t1, $t0
sw $t0, -312($fp)
sw $t1, -240($fp)
label13:
lw $t0, -240($fp)
move $t0, $t0
lw $t1, -156($fp)
move $t1, $t1
sw $t0, -316($fp)
sw $t1, -320($fp)
lw $t0, -316($fp)
lw $t1, -320($fp)
blt $t0, $t1, label14
j label15
label14:
lw $t0, -240($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t2, -36($fp)
add $t2, $t2, $t0
lw $t3, 0($t2)
mul $t3, $t3, $t1
la $t1, -68($fp)
add $t1, $t1, $t3
lw $t4, 0($t1)
li $t5, 1
sw $t0, -324($fp)
sw $t2, -328($fp)
sw $t3, -332($fp)
sw $t1, -336($fp)
sw $t4, -340($fp)
sw $t5, -344($fp)
lw $t0, -340($fp)
lw $t1, -344($fp)
bne $t0, $t1, label16
j label20
label20:
lw $t0, -240($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t2, -36($fp)
add $t2, $t2, $t0
lw $t3, 0($t2)
mul $t3, $t3, $t1
la $t1, -100($fp)
add $t1, $t1, $t3
lw $t4, 0($t1)
li $t5, 1
sw $t0, -348($fp)
sw $t2, -352($fp)
sw $t3, -356($fp)
sw $t1, -360($fp)
sw $t4, -364($fp)
sw $t5, -368($fp)
lw $t0, -364($fp)
lw $t1, -368($fp)
bne $t0, $t1, label16
j label19
label19:
lw $t0, -240($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t2, -36($fp)
add $t2, $t2, $t0
lw $t3, 0($t2)
mul $t3, $t3, $t1
la $t1, -132($fp)
add $t1, $t1, $t3
lw $t4, 0($t1)
li $t5, 1
sw $t0, -372($fp)
sw $t2, -376($fp)
sw $t3, -380($fp)
sw $t1, -384($fp)
sw $t4, -388($fp)
sw $t5, -392($fp)
lw $t0, -388($fp)
lw $t1, -392($fp)
bne $t0, $t1, label16
j label17
label16:
li $t0, 0
move $t1, $t0
lw $t2, -156($fp)
move $t2, $t2
move $t3, $t2
sw $t0, -396($fp)
sw $t1, -232($fp)
sw $t2, -400($fp)
sw $t3, -240($fp)
j label18
label17:
li $t0, 0
lw $t1, -240($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t3, -36($fp)
add $t3, $t3, $t1
lw $t4, 0($t3)
mul $t4, $t4, $t2
la $t2, -68($fp)
add $t2, $t2, $t4
move $t5, $t2
sw $t0, 0($t5)
li $t6, 0
move $t7, $t6
sw $t0, -404($fp)
sw $t1, -408($fp)
sw $t3, -412($fp)
sw $t4, -416($fp)
sw $t2, -420($fp)
sw $t5, -424($fp)
sw $t6, -428($fp)
sw $t7, -432($fp)
label21:
lw $t0, -432($fp)
move $t0, $t0
lw $t1, -156($fp)
move $t1, $t1
li $t2, 1
sub $t3, $t1, $t2
sw $t0, -436($fp)
sw $t1, -440($fp)
sw $t2, -444($fp)
sw $t3, -448($fp)
lw $t0, -436($fp)
lw $t1, -448($fp)
blt $t0, $t1, label22
j label23
label22:
lw $t0, -432($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t5, -100($fp)
add $t6, $t5, $t3
lw $t7, 0($t6)
move $s0, $t0
mul $s0, $s0, $t4
add $t4, $t5, $s0
move $t5, $t4
sw $t7, 0($t5)
move $s1, $t0
li $s2, 1
add $s3, $s1, $s2
move $t0, $s3
sw $t1, -452($fp)
sw $t0, -432($fp)
sw $t2, -456($fp)
sw $t3, -460($fp)
sw $t6, -464($fp)
sw $t7, -468($fp)
sw $s0, -472($fp)
sw $t4, -476($fp)
sw $t5, -480($fp)
sw $s1, -484($fp)
sw $s2, -488($fp)
sw $s3, -492($fp)
j label21
label23:
li $t0, 1
lw $t1, -156($fp)
move $t1, $t1
li $t2, 1
sub $t3, $t1, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t5, -100($fp)
add $t5, $t5, $t3
move $t6, $t5
sw $t0, 0($t6)
lw $t7, -240($fp)
move $t7, $t7
mul $t7, $t7, $t4
la $t4, -36($fp)
add $t4, $t4, $t7
lw $s0, 0($t4)
li $s1, 0
sw $t0, -496($fp)
sw $t1, -500($fp)
sw $t2, -504($fp)
sw $t3, -508($fp)
sw $t5, -512($fp)
sw $t6, -516($fp)
sw $t7, -520($fp)
sw $t4, -524($fp)
sw $s0, -528($fp)
sw $s1, -532($fp)
lw $t0, -528($fp)
lw $t1, -532($fp)
bne $t0, $t1, label24
j label25
label24:
li $t0, 0
lw $t1, -240($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t3, -36($fp)
add $t3, $t3, $t1
lw $t4, 0($t3)
li $t5, 1
sub $t6, $t4, $t5
mul $t6, $t6, $t2
la $t2, -100($fp)
add $t2, $t2, $t6
move $t7, $t2
sw $t0, 0($t7)
sw $t0, -536($fp)
sw $t1, -540($fp)
sw $t3, -544($fp)
sw $t4, -548($fp)
sw $t5, -552($fp)
sw $t6, -556($fp)
sw $t2, -560($fp)
sw $t7, -564($fp)
label25:
lw $t0, -156($fp)
move $t0, $t0
li $t1, 1
sub $t2, $t0, $t1
move $t3, $t2
sw $t0, -568($fp)
sw $t1, -572($fp)
sw $t2, -576($fp)
sw $t3, -432($fp)
label26:
lw $t0, -432($fp)
move $t0, $t0
li $t1, 0
sw $t0, -580($fp)
sw $t1, -584($fp)
lw $t0, -580($fp)
lw $t1, -584($fp)
bgt $t0, $t1, label27
j label28
label27:
lw $t0, -432($fp)
move $t1, $t0
li $t2, 1
sub $t3, $t1, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t5, -132($fp)
add $t6, $t5, $t3
lw $t7, 0($t6)
move $s0, $t0
mul $s0, $s0, $t4
add $t4, $t5, $s0
move $t5, $t4
sw $t7, 0($t5)
move $s1, $t0
li $s2, 1
sub $s3, $s1, $s2
move $t0, $s3
sw $t1, -588($fp)
sw $t0, -432($fp)
sw $t2, -592($fp)
sw $t3, -596($fp)
sw $t6, -600($fp)
sw $t7, -604($fp)
sw $s0, -608($fp)
sw $t4, -612($fp)
sw $t5, -616($fp)
sw $s1, -620($fp)
sw $s2, -624($fp)
sw $s3, -628($fp)
j label26
label28:
li $t0, 1
li $t1, 0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -132($fp)
add $t3, $t3, $t1
move $t4, $t3
sw $t0, 0($t4)
lw $t5, -240($fp)
move $t5, $t5
mul $t5, $t5, $t2
la $t2, -36($fp)
add $t2, $t2, $t5
lw $t6, 0($t2)
lw $t7, -156($fp)
move $t7, $t7
li $s0, 1
sub $s1, $t7, $s0
sw $t0, -632($fp)
sw $t1, -636($fp)
sw $t3, -640($fp)
sw $t4, -644($fp)
sw $t5, -648($fp)
sw $t2, -652($fp)
sw $t6, -656($fp)
sw $t7, -660($fp)
sw $s0, -664($fp)
sw $s1, -668($fp)
lw $t0, -656($fp)
lw $t1, -668($fp)
bne $t0, $t1, label29
j label30
label29:
li $t0, 0
lw $t1, -240($fp)
move $t1, $t1
li $t2, 4
mul $t1, $t1, $t2
la $t3, -36($fp)
add $t3, $t3, $t1
lw $t4, 0($t3)
li $t5, 1
add $t6, $t4, $t5
mul $t6, $t6, $t2
la $t2, -132($fp)
add $t2, $t2, $t6
move $t7, $t2
sw $t0, 0($t7)
sw $t0, -672($fp)
sw $t1, -676($fp)
sw $t3, -680($fp)
sw $t4, -684($fp)
sw $t5, -688($fp)
sw $t6, -692($fp)
sw $t2, -696($fp)
sw $t7, -700($fp)
label30:
lw $t0, -240($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -704($fp)
sw $t0, -240($fp)
sw $t2, -708($fp)
sw $t3, -712($fp)
label18:
j label13
label15:
lw $t0, -232($fp)
move $t0, $t0
li $t1, 1
sw $t0, -716($fp)
sw $t1, -720($fp)
lw $t0, -716($fp)
lw $t1, -720($fp)
beq $t0, $t1, label31
j label32
label31:
lw $t0, -140($fp)
move $t1, $t0
li $t2, 1
add $t3, $t1, $t2
move $t0, $t3
sw $t1, -724($fp)
sw $t0, -140($fp)
sw $t2, -728($fp)
sw $t3, -732($fp)
label32:
lw $t0, -148($fp)
move $t1, $t0
li $t2, 1
sub $t3, $t1, $t2
move $t0, $t3
sw $t1, -736($fp)
sw $t0, -148($fp)
sw $t2, -740($fp)
sw $t3, -744($fp)
j label9
label8:
label33:
lw $t0, -148($fp)
move $t0, $t0
li $t1, 0
sw $t0, -748($fp)
sw $t1, -752($fp)
lw $t0, -748($fp)
lw $t1, -752($fp)
bge $t0, $t1, label36
j label35
label36:
lw $t0, -148($fp)
move $t0, $t0
li $t1, 4
mul $t0, $t0, $t1
la $t1, -36($fp)
add $t1, $t1, $t0
lw $t2, 0($t1)
lw $t3, -156($fp)
move $t3, $t3
li $t4, 1
sub $t5, $t3, $t4
sw $t0, -756($fp)
sw $t1, -760($fp)
sw $t2, -764($fp)
sw $t3, -768($fp)
sw $t4, -772($fp)
sw $t5, -776($fp)
lw $t0, -764($fp)
lw $t1, -776($fp)
bge $t0, $t1, label34
j label35
label34:
li $t0, 1
li $t1, 0
sub $t1, $t1, $t0
lw $t2, -148($fp)
move $t3, $t2
li $t4, 4
mul $t3, $t3, $t4
la $t4, -36($fp)
add $t4, $t4, $t3
move $t5, $t4
sw $t1, 0($t5)
move $t6, $t2
li $t7, 1
sub $s0, $t6, $t7
move $t2, $s0
sw $t0, -780($fp)
sw $t1, -784($fp)
sw $t3, -788($fp)
sw $t2, -148($fp)
sw $t4, -792($fp)
sw $t5, -796($fp)
sw $t6, -800($fp)
sw $t7, -804($fp)
sw $s0, -808($fp)
j label33
label35:
lw $t0, -148($fp)
move $t0, $t0
li $t1, 1
li $t2, 0
sub $t2, $t2, $t1
sw $t0, -812($fp)
sw $t1, -816($fp)
sw $t2, -820($fp)
lw $t0, -812($fp)
lw $t1, -820($fp)
beq $t0, $t1, label37
j label38
label37:
li $t0, 0
move $t1, $t0
sw $t0, -824($fp)
sw $t1, -208($fp)
j label39
label38:
lw $t0, -148($fp)
move $t1, $t0
li $t2, 4
mul $t1, $t1, $t2
la $t3, -36($fp)
add $t4, $t3, $t1
lw $t5, 0($t4)
li $t6, 1
add $t7, $t5, $t6
move $s0, $t0
mul $s0, $s0, $t2
add $t2, $t3, $s0
move $t3, $t2
sw $t7, 0($t3)
move $s1, $t0
li $s2, 1
add $s3, $s1, $s2
move $t0, $s3
sw $t1, -828($fp)
sw $t0, -148($fp)
sw $t4, -832($fp)
sw $t5, -836($fp)
sw $t6, -840($fp)
sw $t7, -844($fp)
sw $s0, -848($fp)
sw $t2, -852($fp)
sw $t3, -856($fp)
sw $s1, -860($fp)
sw $s2, -864($fp)
sw $s3, -868($fp)
label39:
label9:
j label4
label6:
lw $t0, -140($fp)
move $t0, $t0
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $t1, 0
move $v0, $t1
move $sp, $fp
lw $fp, 0($sp)
addi $sp, $sp, 4
jr $ra
sw $t0, -872($fp)
sw $t1, -876($fp)
