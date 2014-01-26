
@20
D=A
@SP
M=D



// push 10
@10
D=A
@SP
AM=M+1
A=A-1
M=D
// push 15
@15
D=A
@SP
AM=M+1
A=A-1
M=D

//add

@SP
AM=M-1
D=M
M=0
A=A-1
M=D+M
