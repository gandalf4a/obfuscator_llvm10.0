; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64-unknown-unknown %s -o - | FileCheck %s

define dso_local fastcc void @trunc_srl_load(i32 zeroext %AttrArgNo) {
; CHECK-LABEL: trunc_srl_load:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lhz 4, 2(0)
; CHECK-NEXT:    cmplw 0, 4, 3
; CHECK-NEXT:    ble 0, .LBB0_2
; CHECK-NEXT:  # %bb.1: # %exit
; CHECK-NEXT:  .LBB0_2: # %cond.false
entry:
  %bf.load.i = load i64, i64* null, align 8
  %bf.lshr.i = lshr i64 %bf.load.i, 32
  %0 = trunc i64 %bf.lshr.i to i32
  %bf.cast.i = and i32 %0, 65535
  %cmp.i = icmp ugt i32 %bf.cast.i, %AttrArgNo
  br i1 %cmp.i, label %exit, label %cond.false
exit:       ; preds = %entry
  unreachable
cond.false:                                       ; preds = %entry
  unreachable
}

define i32 @sh_trunc_sh(i64 %x) {
; CHECK-LABEL: sh_trunc_sh:
; CHECK:       # %bb.0:
; CHECK-NEXT:    rldicl 3, 3, 47, 36
; CHECK-NEXT:    blr
  %s = lshr i64 %x, 13
  %t = trunc i64 %s to i32
  %r = lshr i32 %t, 4
  ret i32 %r
}
