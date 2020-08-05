; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; A test for checking PR 9623
; RUN: llc -mcpu=corei7 < %s | FileCheck %s

target triple = "x86_64-apple-darwin"

define <4 x i8> @foo(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: foo:
; CHECK:       ## %bb.0: ## %entry
; CHECK-NEXT:    pmovzxbw {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero,xmm1[4],zero,xmm1[5],zero,xmm1[6],zero,xmm1[7],zero
; CHECK-NEXT:    pmovzxbw {{.*#+}} xmm2 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; CHECK-NEXT:    pmullw %xmm1, %xmm2
; CHECK-NEXT:    pshufb {{.*#+}} xmm2 = xmm2[0,2,4,6,u,u,u,u,u,u,u,u,u,u,u,u]
; CHECK-NEXT:    paddb %xmm2, %xmm0
; CHECK-NEXT:    retq
entry:
 %binop = mul <4 x i8> %x, %y
 %binop6 = add <4 x i8> %binop, %x
 ret <4 x i8> %binop6
}


