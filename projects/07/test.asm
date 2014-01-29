
@20
D=A
@SP
M=D


@7
D=A
@SP
AM=M+1
A=A-1
M=D

@7
D=A
@SP
AM=M+1
A=A-1
M=D

@SP
AM=M-1
D=M
A=A-1
D=M-D
M=0
@END_EQ
D;JNE
@SP
A=M-1
M=-1
(END_EQ)

@5
D=A
@SP
AM=M+1
A=A-1
M=D
