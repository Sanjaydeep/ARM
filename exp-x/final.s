     PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION	
		VMOV.F32 s0, #3.0    ; x value in e^x 
	 	VMOV.F32 s1, #10.0	 ; i,number of terms in taylor series to be considered
		VMOV.F32 s2, #1.0    ; n in the nth term of the taylor series
		VMOV.F32 s3, #1.0    ; RESULT of e^x
		VMOV.F32 s5, #1.0    ; for incrementing
		
		VDIV.F32 s4, s0, s2  ; variable to store the nth term of taylor serie (x^n/n!)
		
loop	VADD.F32 s3,s3,s4    ; result = result + nth term 
		VADD.F32 s2,s2,s5	 ; incrementing n
		VMUL.F32 s4,s4,s0
		VDIV.F32 s4,s4,s2    ; storing (n+1)th term
		VSUB.F32 s1,s1,s5	 ; decrementing counter
		VCMP.F32 s1,#0.0	 ; is 'i' terms considered?
		VMRS 	 APSR_nzcv, FPSCR 	; Copy FPSCR to APSR_nzcv
		BNE loop
		
		
stop B stop ; stop program
     ENDFUNC
     END