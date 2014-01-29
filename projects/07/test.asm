
@20
D=A
@SP
M=D

@1000
D=A
@SP
AM=M+1
A=A-1
M=D

//pop temp 2
@2
D=A
@5
D=A+D
@R15
M=D
@SP
AM=M-1
D=M
@R15
A=M
M=D
