	.file	1 "lab2_3.c"
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
	.frame	$fp,256,$31		# vars= 224, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-256				; $sp=$sp+(-256) ; add immediate unsigned //each distinct instruction will be described once
	sw	$31,252($sp)				; Memory[$sp+252]=$31 ; store word
	sw	$fp,248($sp)				
	move	$fp,$sp					; $fp=$sp ; move
	lui	$28,%hi(__gnu_local_gp)			; $28=100x2^%hi ; load upper immediate
	addiu	$28,$28,%lo(__gnu_local_gp)		; $28=$28+%lo ; add immediate unsigned
	.cprestore	16
	lw	$2,%got(__stack_chk_guard)($28)		; $2=Memory[$28+%got] ; load word
	lw	$2,0($2)				; $2=Memory[$2+0] ; load word
	sw	$2,244($fp)				
	li	$2,1			# 0x1		; $2=1 ; load immediate
	sw	$2,32($fp)				
	sw	$0,40($fp)				
	b	$L2					; branch unconditionally to line 2
	nop						; This instruction will take up all 5 stages of pipeline

$L8:
	sw	$0,36($fp)				
	li	$2,2			# 0x2		
	sw	$2,28($fp)				
	b	$L3					
	nop						

$L6:
	lw	$3,32($fp)				
	lw	$2,28($fp)				
	teq	$2,$0,7					; trap 7 if $2=$0
	div	$0,$3,$2				; $hi=$0, $lo=$3/$2
	mfhi	$2					; $2=hi ; move from hi
	bne	$2,$0,$L4				; if($2!=$0) go to PC+4+$L4 ; branch on not equal
	nop						
	lw	$2,36($fp)				
	addiu	$2,$2,1					; $2=$2+1 ; add immediate unsigned
	sw	$2,36($fp)				
	b	$L5					
	nop						

$L4:
	lw	$2,28($fp)				
	addiu	$2,$2,1					
	sw	$2,28($fp)				
$L3:
	lw	$2,32($fp)				
	srl	$3,$2,31				; $3=$2>>31 ; shift right logical
	addu	$2,$3,$2				; $2=$3+$2 ; add unsigned
	sra	$2,$2,1					; $2=$2>>1 ; shift word right (arithmetic)
	move	$3,$2					
	lw	$2,28($fp)				
	slt	$2,$3,$2				; if($3<$2)$2=1; else $2=0 ; set on less than
	beq	$2,$0,$L6				; if($2==$0) go to PC+4+$L6 ; branch on equal
	nop						

$L5:
	lw	$2,36($fp)				
	bne	$2,$0,$L7				
	nop						

	lw	$3,32($fp)				
	li	$2,1			# 0x1		
	beq	$3,$2,$L7				
	nop						

	lw	$2,40($fp)				
	sll	$2,$2,2					; $2=$2<<2 ; shift left logical
	addiu	$3,$fp,248				
	addu	$2,$3,$2				
	lw	$3,32($fp)				
	sw	$3,-204($2)				
	lw	$2,40($fp)				
	addiu	$2,$2,1					
	sw	$2,40($fp)				
$L7:			
	lw	$2,32($fp)				
	addiu	$2,$2,1					
	sw	$2,32($fp)				
$L2:
	lw	$2,32($fp)				
	slt	$2,$2,101				
	bne	$2,$0,$L8				
	nop						

	move	$2,$0					
	lw	$3,%got(__stack_chk_guard)($28)		
	lw	$4,244($fp)				
	lw	$3,0($3)				
	beq	$4,$3,$L10				
	nop						

	lw	$2,%call16(__stack_chk_fail)($28)	
	move	$25,$2					
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail		
1:	jalr	$25					; jump and link register $25
	nop						

$L10:
	move	$sp,$fp					
	lw	$31,252($sp)				
	lw	$fp,248($sp)				
	addiu	$sp,$sp,256				
	j	$31					
	nop						

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
