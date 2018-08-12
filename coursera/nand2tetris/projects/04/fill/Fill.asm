// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

	@color
	M=-1
	D=0
	@SETCOLOR
	0;JMP

(READKBD)
	@KBD
	D=M
	@SETCOLOR
	D;JEQ // if no key pressed, white (default)
	D=-1 // if key pressed, black

(SETCOLOR)
	@newcolor
	M=D
	@color
	D=D-M // D = newcolor - color
	@READKBD
	D;JEQ // do nothing if same color

	@newcolor
	D=M
	@color
	M=D // color = newcolor

	@SCREEN
	D=A
	@8192
	D=D+A // D = last screen address
	@i
	M=D // i = first screen address

(PRINT)
	@i
	D=M-1
	M=D
	@READKBD
	D;JLT // if i < 0 goto READKBD

	@color
	D=M
	@i
	A=M
	M=D // M[screen] = color
	@PRINT
	0;JMP
