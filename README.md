# COAL - Assembly Language Programs

**Name:** Aleezay Salman
**Roll No:** 25L-0558
**Section:** [YOUR SECTION]
**Course:** COAL (EE2003), FAST-NUCES Lahore, Fall 2026
**Repository:** https://github.com/l250558-byte/COAL

## Description
A collection of 16-bit 8088 assembly programs and worksheets written for COAL.

### Assignment 1: Flags, Memory Addressing and Basic Programs
- A worksheet of 14 small programs tracing CF, ZF, SF and OF after ADD, SUB, INC, DEC, CMP and OR.
- A program that loops over an array of 10 words, tests each with `and`/`jnp`, and counts results in AX.
- A program that finds the maximum absolute value in a signed byte array using `cmp`, `js` and two's complement negation.
- Physical address calculations from segment:offset pairs, address ranges of 64 KB segments, and finding IP and AX from a given CS:IP.
- Solution file: `25l-0558-A1.pdf`

### Assignment 2: Conditional Jumps, Endianness and Shifts/Rotates
- Predicting whether conditional jumps are taken by working out CF, SF and OF.
- Little-endian memory layout tracing, including the effect of `mov word [big+2], 0x9999`.
- Tracing `rcl`, `ror`, `shl`, `rol` and `shr` on AL with carry flag tracking.
- Files are in the `25l0558-COAL-A2` folder.

### Assignment 3: Text Viewport Manager
- `25L0558Q6.asm`: the Text Viewport Manager. It works directly in video memory (0xB800):
  - Clears the screen and draws a double-line bordered window with a centered title (attribute 0x1E).
  - Streams a multi-line paragraph into the window using LODSB/STOSW, inside the window margins.
  - `scroll_window_up` scrolls only the text inside the window using MOVSW with row-stride offsets and blanks the vacated line with STOSW. Borders and the rest of the screen stay untouched.
  - `fndhl` scans the window for a keyword and highlights each match by changing only the attribute bytes, leaving the ASCII characters unchanged.
  - All subroutines take parameters on the stack, use BP-relative addressing, preserve registers, and clean up with `ret n`.
- `25l0558q1.asm` to `25l0558q5.asm`: programs for the other Assignment 3 questions.
- `25l0558-coal-a3-q-1.pdf`: written solutions for Assignment 3, Question 1.

## Tools Used
- NASM (assembler)
- DOSBox 0.74-3 (emulator and debugger)
- Git and GitHub (version control)

## How to Assemble and Run
Assemble with NASM:
```
nasm 25L0558Q6.asm -f bin -o viewport.com
```
Run in DOSBox:
```
mount c <path-to-folder-containing-viewport.com>
c:
viewport.com
```
Press any key to advance when the program waits for input.

## Folder Structure
```
COAL/
├── README.md
├── 25l-0558-A1.pdf
├── 25l0558-COAL-A2/
├── 25l0558-coal-a3-q-1.pdf
├── 25l0558q1.asm
├── 25l0558q2.asm
├── 25l0558q3.asm
├── 25l0558q4.asm
├── 25l0558q5.asm
├── 25L0558Q6.asm
└── Screenshot *.png
```

## Output Screenshots

### Assignment 3

![Output 1](<Screenshot 2026-10-18 163517.png>)

![Output 2](<Screenshot 2026-10-18 205147.png>)

![Output 3](<Screenshot 2026-10-19 211258.png>)
