	.file	1 "lab2_4.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	Op
	.set	nomips16
	.set	nomicromips
	.ent	Op
	.type	Op, @function
Op:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16					# $sp=$sp+(-16) ; add immediate unsigned 
	sw	$fp,12($sp)					# Memory[$sp+12]=$fp ; store word
	move	$fp,$sp						# $fp=$sp ; move
	sw	$4,16($fp)					
	li	$2,1			# 0x1			# $2=1 ; load immediate
	sw	$2,4($fp)					
	lw	$2,16($fp)					# $2=Memory[$fp+16] ; load word
	slt	$2,$2,2						# if($2<2)$2=1; else $2=0
	beq	$2,$0,$L2					# if($2==$0) go to PC+4+$L2 ; branch on equal
	nop							# This instruction will take up all 5 stages of pipeline
				
	li	$2,-1			# 0xffffffffffffffff	
	sw	$2,4($fp)					
	b	$L3						# branch unconditionally to line 3
	nop							
	
$L2:		
	li	$2,2			# 0x2			
	sw	$2,0($fp)					
	b	$L4						
	nop							

$L6:
	lw	$3,16($fp)					
	lw	$2,0($fp)					
	teq	$2,$0,7						# trap 7 if $2=$0
	div	$0,$3,$2					# $hi=$0, $lo=$3/$2
	mfhi	$2						# $2=hi ; move from hi
	bne	$2,$0,$L5					# if($2!=$0) go to PC+4+$L5 ; branch on not equal
	nop							
	li	$2,-1			# 0xffffffffffffffff	
	sw	$2,4($fp)							
	b	$L3						
	nop							
		
$L5:		
	lw	$2,0($fp)					
	addiu	$2,$2,1						# $2=$2+1 ; add immediate unsigned
	sw	$2,0($fp)					
$L4:
	lw	$2,16($fp)					
	srl	$3,$2,31					# $3=$2>>31 ; shift right logical
	addu	$2,$3,$2					# $2=$3+$2 ; add unsigned
	sra	$2,$2,1						# $2=$2>>1 ; shift word right (arithmetic)
	move	$3,$2						
	lw	$2,0($fp)					
	slt	$2,$3,$2					
	beq	$2,$0,$L6					
	nop							

$L3:
	lw	$3,4($fp)					
	li	$2,1			# 0x1			
	bne	$3,$2,$L7					
	nop							
	
	lw	$2,4($fp)						
	b	$L8						
	nop							

$L7:
	lw	$2,16($fp)					
	andi	$2,$2,0x1					# $2=$2&1 ; Bitwise and immediate
	bne	$2,$0,$L9					
	nop							

	li	$2,2			# 0x2			
	b	$L8						
	nop							

$L9:
	li	$2,3			# 0x3			
$L8:	
	move	$sp,$fp						
	lw	$fp,12($sp)							
	addiu	$sp,$sp,16					# $sp=$sp+16 ; add immediate unsigned
	jr	$31						; go to address stored in $31 ; jump register
	nop							

	.set	macro
	.set	reorder
	.end	Op
	.size	Op, .-Op
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,48,$31		# vars= 16, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48			
	sw	$31,44($sp)			
	sw	$fp,40($sp)			
	move	$fp,$sp				
	li	$2,33			# 0x21	
	sw	$2,32($fp)			
	lw	$4,32($fp)			
	jal	Op				; $ra=PC+4; go to address Op ; jump and link
	nop					

	li	$3,2			# 0x2	
	beq	$2,$3,$L12			
	nop					

	li	$3,3			# 0x3	
	beq	$2,$3,$L13			
	nop					

	li	$3,1			# 0x1	
	bne	$2,$3,$L11			
	nop					

	lw	$3,32($fp)			
	li	$2,2			# 0x2	
	bne	$3,$2,$L15			
	nop					

	lw	$2,32($fp)			
	sw	$2,36($fp)			
	b	$L11				
	nop					

$L15:
	lw	$2,32($fp)			
	addiu	$2,$2,1				
	sw	$2,36($fp)			
	b	$L11				
	nop					

$L12:
	lw	$2,32($fp)			
	addiu	$2,$2,1				
	sw	$2,36($fp)			
	b	$L11				
	nop					

$L13:
	lw	$2,32($fp)			
	addiu	$2,$2,-1			
	sw	$2,24($fp)			
	lw	$2,32($fp)			
	addiu	$2,$2,-1			
	sw	$2,28($fp)			
	b	$L17				
	nop					

$L19:
	lw	$2,24($fp)			
	addiu	$2,$2,-1			
	sw	$2,24($fp)			
$L17:
	lw	$4,24($fp)			
	jal	Op				
	nop					

	move	$3,$2				
	li	$2,1			# 0x1	
	beq	$3,$2,$L20			
	nop					

	lw	$2,24($fp)			
	slt	$2,$2,2				
	beq	$2,$0,$L19			
	nop					

	b	$L20				
	nop					

$L21:
	lw	$2,28($fp)			
	addiu	$2,$2,1				
	sw	$2,28($fp)			
$L20:
	lw	$4,28($fp)			
	jal	Op				
	nop					

	move	$3,$2				
	li	$2,1			# 0x1	
	bne	$3,$2,$L21			
	nop					

	lw	$3,32($fp)			
	lw	$2,24($fp)			
	subu	$3,$3,$2			; $3=$3-$2 ; subtract unsigned
	lw	$4,28($fp)			
	lw	$2,32($fp)			
	subu	$2,$4,$2			
	slt	$2,$3,$2			
	beq	$2,$0,$L22			
	nop					

	lw	$2,24($fp)			
	sw	$2,36($fp)				
	b	$L25				
	nop					

$L22:
	lw	$2,28($fp)			
	sw	$2,36($fp)			
$L25:
	nop					
$L11:
	move	$2,$0				
	move	$sp,$fp				
	lw	$31,44($sp)			
	lw	$fp,40($sp)			
	addiu	$sp,$sp,48			
	jr	$31				 
	nop					

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.) 5.4.0 20160609"
