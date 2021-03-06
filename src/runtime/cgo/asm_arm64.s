// Copyright 2015 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "textflag.h"

// Called by C code generated by cmd/cgo.
// func crosscall2(fn, a unsafe.Pointer, n int32, ctxt uintptr)
// Saves C callee-saved registers and calls cgocallback with three arguments.
// fn is the PC of a func(a unsafe.Pointer) function.
TEXT crosscall2(SB),NOSPLIT|NOFRAME,$0
	/*
	 * We still need to save all callee save register as before, and then
	 *  push 3 args for fn (R0, R1, R3), skipping R2.
	 * Also note that at procedure entry in gc world, 8(RSP) will be the
	 *  first arg.
	 * TODO(minux): use LDP/STP here if it matters.
	 */
	SUB	$(8*24), RSP
	MOVD	R0, (8*1)(RSP)
	MOVD	R1, (8*2)(RSP)
	MOVD	R3, (8*3)(RSP)
	MOVD	R19, (8*4)(RSP)
	MOVD	R20, (8*5)(RSP)
	MOVD	R21, (8*6)(RSP)
	MOVD	R22, (8*7)(RSP)
	MOVD	R23, (8*8)(RSP)
	MOVD	R24, (8*9)(RSP)
	MOVD	R25, (8*10)(RSP)
	MOVD	R26, (8*11)(RSP)
	MOVD	R27, (8*12)(RSP)
	MOVD	g, (8*13)(RSP)
	MOVD	R29, (8*14)(RSP)
	MOVD	R30, (8*15)(RSP)
	FMOVD	F8, (8*16)(RSP)
	FMOVD	F9, (8*17)(RSP)
	FMOVD	F10, (8*18)(RSP)
	FMOVD	F11, (8*19)(RSP)
	FMOVD	F12, (8*20)(RSP)
	FMOVD	F13, (8*21)(RSP)
	FMOVD	F14, (8*22)(RSP)
	FMOVD	F15, (8*23)(RSP)

	// Initialize Go ABI environment
	BL	runtime·load_g(SB)

	BL	runtime·cgocallback(SB)

	MOVD	(8*4)(RSP), R19
	MOVD	(8*5)(RSP), R20
	MOVD	(8*6)(RSP), R21
	MOVD	(8*7)(RSP), R22
	MOVD	(8*8)(RSP), R23
	MOVD	(8*9)(RSP), R24
	MOVD	(8*10)(RSP), R25
	MOVD	(8*11)(RSP), R26
	MOVD	(8*12)(RSP), R27
	MOVD	(8*13)(RSP), g
	MOVD	(8*14)(RSP), R29
	MOVD	(8*15)(RSP), R30
	FMOVD	(8*16)(RSP), F8
	FMOVD	(8*17)(RSP), F9
	FMOVD	(8*18)(RSP), F10
	FMOVD	(8*19)(RSP), F11
	FMOVD	(8*20)(RSP), F12
	FMOVD	(8*21)(RSP), F13
	FMOVD	(8*22)(RSP), F14
	FMOVD	(8*23)(RSP), F15
	ADD	$(8*24), RSP
	RET
