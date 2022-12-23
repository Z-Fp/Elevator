
;CodeVisionAVR C Compiler V1.25.8 Professional
;(C) Copyright 1998-2007 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 1.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "1111.vec"
	.INCLUDE "1111.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160
;       1 /*******************************************************
;       2 This program was created by the
;       3 CodeWizardAVR V3.12 Advanced
;       4 Automatic Program Generator
;       5 © Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 
;       8 Project :  az-8 micro
;       9 Version :
;      10 Date    : 29/04/2016
;      11 Author  :  Mohammad Gholami  911841116
;      12 Company :
;      13 Comments: MGH
;      14 
;      15 
;      16 Chip type               : ATmega16
;      17 Program type            : Application
;      18 AVR Core Clock frequency: 1/000000 MHz
;      19 Memory model            : Small
;      20 External RAM size       : 0
;      21 Data Stack size         : 256
;      22 *******************************************************/
;      23 
;      24 #include <mega16.h>
;      25 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      26 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      27 	.EQU __se_bit=0x40
	.EQU __se_bit=0x40
;      28 	.EQU __sm_mask=0xB0
	.EQU __sm_mask=0xB0
;      29 	.EQU __sm_powerdown=0x20
	.EQU __sm_powerdown=0x20
;      30 	.EQU __sm_powersave=0x30
	.EQU __sm_powersave=0x30
;      31 	.EQU __sm_standby=0xA0
	.EQU __sm_standby=0xA0
;      32 	.EQU __sm_ext_standby=0xB0
	.EQU __sm_ext_standby=0xB0
;      33 	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_adc_noise_red=0x10
;      34 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;      35 	#endif
	#endif
;      36 #include <delay.h>
;      37 // Declare your global variables here
;      38 int a;
;      39 int b;
;      40 void main(void)
;      41 {

	.CSEG
_main:
;      42 // Declare your local variables here
;      43 
;      44 // Input/Output Ports initialization
;      45 // Port A initialization
;      46 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
;      47 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x1A,R30
;      48 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
;      49 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x1B,R30
;      50 
;      51 // Port B initialization
;      52 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
;      53 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x17,R30
;      54 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
;      55 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x18,R30
;      56 
;      57 // Port C initialization
;      58 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
;      59 DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x14,R30
;      60 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
;      61 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x15,R30
;      62 
;      63 // Port D initialization
;      64 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=Out Bit0=Out
;      65 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (1<<DDD1) | (1<<DDD0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x11,R30
;      66 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=0 Bit0=0
;      67 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x12,R30
;      68 
;      69 // Timer/Counter 0 initialization
;      70 // Clock source: System Clock
;      71 // Clock value: Timer 0 Stopped
;      72 // Mode: Normal top=0xFF
;      73 // OC0 output: Disconnected
;      74 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x33,R30
;      75 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;      76 OCR0=0x00;
	OUT  0x3C,R30
;      77 
;      78 // Timer/Counter 1 initialization
;      79 // Clock source: System Clock
;      80 // Clock value: Timer1 Stopped
;      81 // Mode: Normal top=0xFFFF
;      82 // OC1A output: Disconnected
;      83 // OC1B output: Disconnected
;      84 // Noise Canceler: Off
;      85 // Input Capture on Falling Edge
;      86 // Timer1 Overflow Interrupt: Off
;      87 // Input Capture Interrupt: Off
;      88 // Compare A Match Interrupt: Off
;      89 // Compare B Match Interrupt: Off
;      90 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x2F,R30
;      91 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x2E,R30
;      92 TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;      93 TCNT1L=0x00;
	OUT  0x2C,R30
;      94 ICR1H=0x00;
	OUT  0x27,R30
;      95 ICR1L=0x00;
	OUT  0x26,R30
;      96 OCR1AH=0x00;
	OUT  0x2B,R30
;      97 OCR1AL=0x00;
	OUT  0x2A,R30
;      98 OCR1BH=0x00;
	OUT  0x29,R30
;      99 OCR1BL=0x00;
	OUT  0x28,R30
;     100 
;     101 // Timer/Counter 2 initialization
;     102 // Clock source: System Clock
;     103 // Clock value: Timer2 Stopped
;     104 // Mode: Normal top=0xFF
;     105 // OC2 output: Disconnected
;     106 ASSR=0<<AS2;
	CALL __LSLB12
	OUT  0x22,R30
;     107 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x25,R30
;     108 TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;     109 OCR2=0x00;
	OUT  0x23,R30
;     110 
;     111 // Timer(s)/Counter(s) Interrupt(s) initialization
;     112 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x39,R30
;     113 
;     114 // External Interrupt(s) initialization
;     115 // INT0: Off
;     116 // INT1: Off
;     117 // INT2: Off
;     118 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x35,R30
;     119 MCUCSR=(0<<ISC2);
	CALL __LSLB12
	OUT  0x34,R30
;     120 
;     121 // USART initialization
;     122 // USART disabled
;     123 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0xA,R30
;     124 
;     125 // Analog Comparator initialization
;     126 // Analog Comparator: Off
;     127 // The Analog Comparator's positive input is
;     128 // connected to the AIN0 pin
;     129 // The Analog Comparator's negative input is
;     130 // connected to the AIN1 pin
;     131 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x8,R30
;     132 SFIOR=(0<<ACME);
	CALL __LSLB12
	OUT  0x30,R30
;     133 
;     134 // ADC initialization
;     135 // ADC disabled
;     136 ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x6,R30
;     137 
;     138 // SPI initialization
;     139 // SPI disabled
;     140 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0xD,R30
;     141 
;     142 // TWI initialization
;     143 // TWI disabled
;     144 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	CALL __LSLB12
	MOV  R1,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOV  R26,R1
	LDI  R27,0
	SBRC R26,7
	SER  R27
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	MOVW R26,R22
	OR   R30,R26
	OR   R31,R27
	MOVW R22,R30
	CALL __LSLB12
	LDI  R31,0
	SBRC R30,7
	SER  R31
	OR   R30,R22
	OR   R31,R23
	OUT  0x36,R30
;     145 PORTC=0x01;
	LDI  R30,LOW(1)
	OUT  0x15,R30
;     146 b=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R6,R30
;     147 while (1)
_0x3:
;     148       {
;     149       // Place your code here
;     150       while(1)
_0x6:
;     151       {
;     152       if(PINA.0==1)
	SBIS 0x19,0
	RJMP _0x9
;     153       {
;     154       a=4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R4,R30
;     155       break;
	RJMP _0x8
;     156       }
;     157       if(PINA.1==1)
_0x9:
	SBIS 0x19,1
	RJMP _0xA
;     158       {
;     159       a=3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	MOVW R4,R30
;     160       break;
	RJMP _0x8
;     161       }
;     162       if(PINA.2==1)
_0xA:
	SBIS 0x19,2
	RJMP _0xB
;     163       {
;     164       a=2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	MOVW R4,R30
;     165       break;
	RJMP _0x8
;     166       }
;     167       if(PINA.3==1)
_0xB:
	SBIS 0x19,3
	RJMP _0xC
;     168       {
;     169       a=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
;     170       break;
	RJMP _0x8
;     171       }
;     172       }
_0xC:
	RJMP _0x6
_0x8:
;     173 
;     174       if(a==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+3
	JMP _0xD
;     175 {
;     176 
;     177       if(b==1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0xE
;     178       {
;     179       while(PINB.2==0)
_0xF:
	SBIC 0x16,2
	RJMP _0x11
;     180       {
;     181       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x12
	CBI  0x12,0
	RJMP _0x13
_0x12:
	SBI  0x12,0
_0x13:
;     182       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     183       }
	RJMP _0xF
_0x11:
;     184       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     185       while(PINB.1==0)
_0x14:
	SBIC 0x16,1
	RJMP _0x16
;     186       {
;     187       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x17
	CBI  0x12,0
	RJMP _0x18
_0x17:
	SBI  0x12,0
_0x18:
;     188       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     189       }
	RJMP _0x14
_0x16:
;     190       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     191       while(PINB.0==0)
_0x19:
	SBIC 0x16,0
	RJMP _0x1B
;     192       {
;     193       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x1C
	CBI  0x12,0
	RJMP _0x1D
_0x1C:
	SBI  0x12,0
_0x1D:
;     194       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     195       }
	RJMP _0x19
_0x1B:
;     196       PORTC=4;
	LDI  R30,LOW(4)
	OUT  0x15,R30
;     197       PORTD.0=0;
	CBI  0x12,0
;     198       }
;     199 
;     200 
;     201       if(b==2)
_0xE:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x20
;     202       {
;     203       while(PINB.1==0)
_0x21:
	SBIC 0x16,1
	RJMP _0x23
;     204       {
;     205       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x24
	CBI  0x12,0
	RJMP _0x25
_0x24:
	SBI  0x12,0
_0x25:
;     206       }
	RJMP _0x21
_0x23:
;     207       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     208       while(PINB.0==0)
_0x26:
	SBIC 0x16,0
	RJMP _0x28
;     209       {
;     210       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x29
	CBI  0x12,0
	RJMP _0x2A
_0x29:
	SBI  0x12,0
_0x2A:
;     211       }
	RJMP _0x26
_0x28:
;     212       PORTC=4;
	LDI  R30,LOW(4)
	OUT  0x15,R30
;     213       PORTD.0=0;
	CBI  0x12,0
;     214       }
;     215 
;     216       if(b==3)
_0x20:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x2D
;     217       {
;     218       while(PINB.0==0)
_0x2E:
	SBIC 0x16,0
	RJMP _0x30
;     219       {
;     220       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x31
	CBI  0x12,0
	RJMP _0x32
_0x31:
	SBI  0x12,0
_0x32:
;     221       }
	RJMP _0x2E
_0x30:
;     222       PORTC=4;
	LDI  R30,LOW(4)
	OUT  0x15,R30
;     223       PORTD.0=0;
	CBI  0x12,0
;     224       }
;     225       b=4;
_0x2D:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R6,R30
;     226       //delay_ms(1000);
;     227 }
;     228       if(a==3)
_0xD:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+3
	JMP _0x35
;     229 {
;     230 
;     231       if(b==1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x36
;     232       {
;     233       while(PINB.2==0)
_0x37:
	SBIC 0x16,2
	RJMP _0x39
;     234       {
;     235       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x3A
	CBI  0x12,0
	RJMP _0x3B
_0x3A:
	SBI  0x12,0
_0x3B:
;     236       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     237       }
	RJMP _0x37
_0x39:
;     238       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     239       while(PINB.1==0)
_0x3C:
	SBIC 0x16,1
	RJMP _0x3E
;     240       {
;     241       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x3F
	CBI  0x12,0
	RJMP _0x40
_0x3F:
	SBI  0x12,0
_0x40:
;     242       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     243       }
	RJMP _0x3C
_0x3E:
;     244       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     245       PORTD.0=0;
	CBI  0x12,0
;     246       }
;     247 
;     248 
;     249       if(b==2)
_0x36:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x43
;     250       {
;     251       while(PINB.1==0)
_0x44:
	SBIC 0x16,1
	RJMP _0x46
;     252       {
;     253       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x47
	CBI  0x12,0
	RJMP _0x48
_0x47:
	SBI  0x12,0
_0x48:
;     254       }
	RJMP _0x44
_0x46:
;     255       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     256       PORTD.0=0;
	CBI  0x12,0
;     257       }
;     258 
;     259       if(b==4)
_0x43:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x4B
;     260       {
;     261       while(PINB.1==0)
_0x4C:
	SBIC 0x16,1
	RJMP _0x4E
;     262       {
;     263       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x4F
	CBI  0x12,1
	RJMP _0x50
_0x4F:
	SBI  0x12,1
_0x50:
;     264       }
	RJMP _0x4C
_0x4E:
;     265       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     266       PORTD.1=0;
	CBI  0x12,1
;     267       }
;     268       b=3;
_0x4B:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	MOVW R6,R30
;     269       //delay_ms(1000);
;     270 }
;     271       if(a==2)
_0x35:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+3
	JMP _0x53
;     272 {
;     273 
;     274       if(b==1)
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x54
;     275       {
;     276       while(PINB.2==0)
_0x55:
	SBIC 0x16,2
	RJMP _0x57
;     277       {
;     278       PORTD.0=~PORTD.0;
	SBIS 0x12,0
	RJMP _0x58
	CBI  0x12,0
	RJMP _0x59
_0x58:
	SBI  0x12,0
_0x59:
;     279       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     280       }
	RJMP _0x55
_0x57:
;     281       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     282       PORTD.0=0;
	CBI  0x12,0
;     283       }
;     284 
;     285 
;     286       if(b==3)
_0x54:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x5C
;     287       {
;     288       while(PINB.2==0)
_0x5D:
	SBIC 0x16,2
	RJMP _0x5F
;     289       {
;     290       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x60
	CBI  0x12,1
	RJMP _0x61
_0x60:
	SBI  0x12,1
_0x61:
;     291       }
	RJMP _0x5D
_0x5F:
;     292       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     293       PORTD.1=0;
	CBI  0x12,1
;     294       }
;     295 
;     296       if(b==4)
_0x5C:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x64
;     297       {
;     298       while(PINB.1==0)
_0x65:
	SBIC 0x16,1
	RJMP _0x67
;     299       {
;     300       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x68
	CBI  0x12,1
	RJMP _0x69
_0x68:
	SBI  0x12,1
_0x69:
;     301       }
	RJMP _0x65
_0x67:
;     302       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     303       while(PINB.2==0)
_0x6A:
	SBIC 0x16,2
	RJMP _0x6C
;     304       {
;     305       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x6D
	CBI  0x12,1
	RJMP _0x6E
_0x6D:
	SBI  0x12,1
_0x6E:
;     306       }
	RJMP _0x6A
_0x6C:
;     307       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     308       PORTD.1=0;
	CBI  0x12,1
;     309       }
;     310       b=2;
_0x64:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	MOVW R6,R30
;     311       //delay_ms(1000);
;     312 }
;     313       if(a==1)
_0x53:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	BREQ PC+3
	JMP _0x71
;     314 {
;     315 
;     316       if(b==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x72
;     317       {
;     318       while(PINB.1==0)
_0x73:
	SBIC 0x16,1
	RJMP _0x75
;     319       {
;     320       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x76
	CBI  0x12,1
	RJMP _0x77
_0x76:
	SBI  0x12,1
_0x77:
;     321       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     322       }
	RJMP _0x73
_0x75:
;     323       PORTC=3;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     324       while(PINB.2==0)
_0x78:
	SBIC 0x16,2
	RJMP _0x7A
;     325       {
;     326       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x7B
	CBI  0x12,1
	RJMP _0x7C
_0x7B:
	SBI  0x12,1
_0x7C:
;     327       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     328       }
	RJMP _0x78
_0x7A:
;     329       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     330       while(PINB.3==0)
_0x7D:
	SBIC 0x16,3
	RJMP _0x7F
;     331       {
;     332       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x80
	CBI  0x12,1
	RJMP _0x81
_0x80:
	SBI  0x12,1
_0x81:
;     333       delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;     334       }
	RJMP _0x7D
_0x7F:
;     335       PORTC=1;
	LDI  R30,LOW(1)
	OUT  0x15,R30
;     336       PORTD.1=0;
	CBI  0x12,1
;     337       }
;     338 
;     339 
;     340       if(b==3)
_0x72:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x84
;     341       {
;     342       while(PINB.2==0)
_0x85:
	SBIC 0x16,2
	RJMP _0x87
;     343       {
;     344       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x88
	CBI  0x12,1
	RJMP _0x89
_0x88:
	SBI  0x12,1
_0x89:
;     345       }
	RJMP _0x85
_0x87:
;     346       PORTC=2;
	LDI  R30,LOW(2)
	OUT  0x15,R30
;     347       while(PINB.3==0)
_0x8A:
	SBIC 0x16,3
	RJMP _0x8C
;     348       {
;     349       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x8D
	CBI  0x12,1
	RJMP _0x8E
_0x8D:
	SBI  0x12,1
_0x8E:
;     350       }
	RJMP _0x8A
_0x8C:
;     351       PORTC=1;
	LDI  R30,LOW(1)
	OUT  0x15,R30
;     352       PORTD.1=0;
	CBI  0x12,1
;     353       }
;     354 
;     355       if(b==2)
_0x84:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BREQ PC+3
	JMP _0x91
;     356       {
;     357       while(PINB.3==0)
_0x92:
	SBIC 0x16,3
	RJMP _0x94
;     358       {
;     359       PORTD.1=~PORTD.1;
	SBIS 0x12,1
	RJMP _0x95
	CBI  0x12,1
	RJMP _0x96
_0x95:
	SBI  0x12,1
_0x96:
;     360       }
	RJMP _0x92
_0x94:
;     361       PORTC=1;
	LDI  R30,LOW(1)
	OUT  0x15,R30
;     362       PORTD.1=0;
	CBI  0x12,1
;     363       }
;     364       b=1;
_0x91:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R6,R30
;     365       //delay_ms(1000);
;     366 }
;     367 
;     368 
;     369 
;     370 
;     371       }
_0x71:
	RJMP _0x3
_0x5:
;     372 }
_0x99:
	RJMP _0x99
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

;END OF CODE MARKER
__END_OF_CODE:
