	.file	1 "lab2_1.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=xx
	.module	nooddspreg
	.abicalls
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,24,$31		# vars= 16, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24			; $sp=$sp+(-24) ; add immediate unsigned //each distinct instruction will be described once
	sw	$fp,20($sp)			; Memory[$sp+20]=$fp ; store word
	move	$fp,$sp				; $fp=$sp ; move
	li	$2,10			# 0xa	; $2=10 ; load immediate
	sw	$2,4($fp)
	li	$2,20			# 0x14
	sw	$2,8($fp)
	lw	$3,4($fp)			; $3=Memory[$fp+4] ; load word
	lw	$2,8($fp)
	addu	$2,$3,$2			; $2=$3+$2 ; add unsigned
	sw	$2,12($fp)
	lw	$3,4($fp)
	lw	$2,8($fp)
	subu	$2,$3,$2			; $2=$3-$2 ; subtract unsigned
	sw	$2,12($fp)
	lw	$3,4($fp)
	lw	$2,8($fp)
	mul	$2,$3,$2			; $2=$3*$2 ; Multiply (without overflow)
	sw	$2,12($fp)			; store word
	lw	$3,4($fp)
	lw	$2,8($fp)
	teq	$2,$0,7				; trap 7 if $2=$0
	div	$0,$3,$2			; $hi=$0, $lo=$3/$2
	mfhi	$2				; $2=hi ; move from hi
	mflo	$2				; $2=lo ; move from lo
	sw	$2,12($fp)		
	lw	$3,4($fp)			
	lw	$2,8($fp)			
	and	$2,$3,$2			; $2=$3&$2 ; Bitwise and
	sw	$2,12($fp)			
	lw	$3,4($fp)			
	lw	$2,8($fp)			
	or	$2,$3,$2			; $1=$2|$3 ; Bitwise OR
	sw	$2,12($fp)
	lw	$2,4($fp)			
	nor	$2,$0,$2			; $2=~($0|$2) ; Bitwise NOR
	sw	$2,12($fp)
	move	$2,$0				
	move	$sp,$fp				
	lw	$fp,20($sp)			
	addiu	$sp,$sp,24			; $sp=$sp+24 ; add immediate unsigned
	j	$31				; go to address $31 ; jump
	nop					; This instruction will take up all 5 stages of pipeline

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
