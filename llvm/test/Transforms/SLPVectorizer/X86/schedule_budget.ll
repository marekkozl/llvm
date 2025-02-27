; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -slp-vectorizer -S  -slp-schedule-budget=16 -mtriple=x86_64-apple-macosx10.8.0 -mcpu=corei7-avx | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9.0"

; Test if the budget for the scheduling region size works.
; We test with a reduced budget of 16 which should prevent vectorizing the loads.

declare void @unknown()

define void @test(float * %a, float * %b, float * %c, float * %d) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A1:%.*]] = getelementptr inbounds float, float* [[A:%.*]], i64 1
; CHECK-NEXT:    [[A2:%.*]] = getelementptr inbounds float, float* [[A]], i64 2
; CHECK-NEXT:    [[A3:%.*]] = getelementptr inbounds float, float* [[A]], i64 3
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast float* [[A]] to <4 x float>*
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x float>, <4 x float>* [[TMP0]], align 4
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    call void @unknown()
; CHECK-NEXT:    [[B1:%.*]] = getelementptr inbounds float, float* [[B:%.*]], i64 1
; CHECK-NEXT:    [[B2:%.*]] = getelementptr inbounds float, float* [[B]], i64 2
; CHECK-NEXT:    [[B3:%.*]] = getelementptr inbounds float, float* [[B]], i64 3
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float* [[B]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP1]], <4 x float>* [[TMP2]], align 4
; CHECK-NEXT:    [[C1:%.*]] = getelementptr inbounds float, float* [[C:%.*]], i64 1
; CHECK-NEXT:    [[C2:%.*]] = getelementptr inbounds float, float* [[C]], i64 2
; CHECK-NEXT:    [[C3:%.*]] = getelementptr inbounds float, float* [[C]], i64 3
; CHECK-NEXT:    [[D1:%.*]] = getelementptr inbounds float, float* [[D:%.*]], i64 1
; CHECK-NEXT:    [[D2:%.*]] = getelementptr inbounds float, float* [[D]], i64 2
; CHECK-NEXT:    [[D3:%.*]] = getelementptr inbounds float, float* [[D]], i64 3
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast float* [[C]] to <4 x float>*
; CHECK-NEXT:    [[TMP4:%.*]] = load <4 x float>, <4 x float>* [[TMP3]], align 4
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[D]] to <4 x float>*
; CHECK-NEXT:    store <4 x float> [[TMP4]], <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    ret void
;
entry:
  ; Don't vectorize these loads.
  %l0 = load float, float* %a
  %a1 = getelementptr inbounds float, float* %a, i64 1
  %l1 = load float, float* %a1
  %a2 = getelementptr inbounds float, float* %a, i64 2
  %l2 = load float, float* %a2
  %a3 = getelementptr inbounds float, float* %a, i64 3
  %l3 = load float, float* %a3

  ; some unrelated instructions inbetween to enlarge the scheduling region
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()
  call void @unknown()

  ; Don't vectorize these stores because their operands are too far away.
  store float %l0, float* %b
  %b1 = getelementptr inbounds float, float* %b, i64 1
  store float %l1, float* %b1
  %b2 = getelementptr inbounds float, float* %b, i64 2
  store float %l2, float* %b2
  %b3 = getelementptr inbounds float, float* %b, i64 3
  store float %l3, float* %b3

  ; But still vectorize the following instructions, because even if the budget
  ; is exceeded there is a minimum region size.
  %l4 = load float, float* %c
  %c1 = getelementptr inbounds float, float* %c, i64 1
  %l5 = load float, float* %c1
  %c2 = getelementptr inbounds float, float* %c, i64 2
  %l6 = load float, float* %c2
  %c3 = getelementptr inbounds float, float* %c, i64 3
  %l7 = load float, float* %c3

  store float %l4, float* %d
  %d1 = getelementptr inbounds float, float* %d, i64 1
  store float %l5, float* %d1
  %d2 = getelementptr inbounds float, float* %d, i64 2
  store float %l6, float* %d2
  %d3 = getelementptr inbounds float, float* %d, i64 3
  store float %l7, float* %d3

  ret void
}

