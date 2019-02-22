	.file	1 "lab2_2.c"
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
	.frame	$fp,72,$31		# vars= 40, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-72				; $sp=$sp+(-72) ; add immediate unsigned //each distinct instruction will be described once
	sw	$31,68($sp)				; Memory[$sp+68]=$31 ; store word
	sw	$fp,64($sp)				
	move	$fp,$sp					; $fp=$sp ; move
	lui	$28,%hi(__gnu_local_gp)			; $28=100x2^%hi ; load upper immediate
	addiu	$28,$28,%lo(__gnu_local_gp)		; $28=$28+%lo ; add immediate unsigned
	.cprestore	16
	lw	$2,%got(__stack_chk_guard)($28)		; $2=Memory[$28+%got] ; load word
	lw	$2,0($2)				; $2=Memory[$2+0] ; load word
	sw	$2,60($fp)				
	li	$2,5			# 0x5		; $2=5 ; load immediate
	sw	$2,32($fp)				
	li	$2,2			# 0x2		
	sw	$2,36($fp)				
	li	$2,1			# 0x1		
	sw	$2,40($fp)				
	li	$2,2			# 0x2		
	sw	$2,44($fp)				
	li	$2,3			# 0x3		
	sw	$2,48($fp)				
	li	$2,4			# 0x4		
	sw	$2,52($fp)				
	li	$2,5			# 0x5		
	sw	$2,56($fp)				
	sw	$0,28($fp)				 
	b	$L2					; branch unconditionally to line 2
	nop						; This instruction will take up all 5 stages of pipeline

$L3:
	lw	$2,28($fp)				
	sll	$2,$2,2					; $2=$2<<2 ; shift left logical
	addiu	$3,$fp,64				; $3=$fp+64 ; add immediate unsigned
	addu	$2,$3,$2				; $2=$3+$2 ; add unsigned
	lw	$3,-24($2)				
	lw	$2,36($fp)				
	addu	$3,$3,$2				
	lw	$2,28($fp)				
	sll	$2,$2,2					
	addiu	$4,$fp,64				
	addu	$2,$4,$2				
	sw	$3,-24($2)				
	lw	$2,28($fp)				
	addiu	$2,$2,1					
	sw	$2,28($fp)				
$L2:
	lw	$2,28($fp)				
	slt	$2,$2,5					; if($2<5)$2=1; else $2=0 ; set on less than
	bne	$2,$0,$L3				; if($2!=$0) go to PC+4+$L3 ; branch on not equal
	nop						

	move	$2,$0					
	lw	$3,%got(__stack_chk_guard)($28)	
	lw	$4,60($fp)				
	lw	$3,0($3)				
	beq	$4,$3,$L5				 if($4==$3) go to PC+4+$L5 ; branch on equal
	nop						
		
	lw	$2,%call16(__stack_chk_fail)($28)
	move	$25,$2					
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail	
1:	jalr	$25					; jump and link register $25
	nop						

$L5:
	move	$sp,$fp					
	lw	$31,68($sp)				
	lw	$fp,64($sp)				
	addiu	$sp,$sp,72				
	j	$31					; go to address $31 ; jump
	nop						

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
