/-
Copyright (c) 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Author(s): Shilpi Goel
-/
import Arm.BitVec

------------------------------------------------------------------------------

section Decode

open Std.BitVec

-- Data Processing (SIMD and FP) Instructions --

structure Crypto_aes_cls where
  _fixed1 : BitVec 7 := 0b01001110#7  -- [31:24]
  esize   : BitVec 2                  -- [23:22]
  _fixed2 : BitVec 5 := 0b10100#5     -- [21:17]
  opcode  : BitVec 5                  -- [16:12]
  _fixed3 : BitVec 2 := 0b10#2        -- [11:10]
  Rn      : BitVec 5                  -- [9:5]
  Rd      : BitVec 5                  -- [4:0]
deriving DecidableEq, Repr

instance : ToString Crypto_aes_cls where toString a := toString (repr a)

structure Crypto_three_reg_sha512_cls where
  _fixed1 : BitVec 11 := 0b11001110011#11 -- [31:21]
  Rm      : BitVec 5                      -- [20:16]
  _fixed2 : BitVec 1 := 0b1#1             -- [15:15]
  O       : BitVec 1                      -- [14:14]
  _fixed3 : BitVec 2 := 0b00#2            -- [13:12]
  opcode  : BitVec 2                      -- [11:10]
  Rn      : BitVec 5                      --   [9:5]
  Rd      : BitVec 5                      --   [4:0]
deriving DecidableEq, Repr

instance : ToString Crypto_three_reg_sha512_cls where toString a := toString (repr a)

def Crypto_three_reg_sha512_cls.toBitVec32 (x : Crypto_three_reg_sha512_cls) : BitVec 32 :=
  x._fixed1 ++ x.Rm ++ x._fixed2 ++ x.O ++ x._fixed3 ++ x.opcode ++ x.Rn ++ x.Rd

structure Crypto_two_reg_sha512_cls where
  _fixed : BitVec 20 := 0b11001110110000001000#20 -- [31:12]
  opcode: BitVec 2                                -- [11:10]
  Rn    : BitVec 5                                --   [9:5]
  Rd    : BitVec 5                                --   [4:0]
deriving DecidableEq, Repr

instance : ToString Crypto_two_reg_sha512_cls where toString a := toString (repr a)

def Crypto_two_reg_sha512_cls.toBitVec32 (x : Crypto_two_reg_sha512_cls) : BitVec 32 :=
  x._fixed ++ x.opcode ++ x.Rn ++ x.Rd

structure Advanced_simd_two_reg_misc_cls where
  _fixed1 : BitVec 1 := 0b0#1      -- [31:31]
  Q       : BitVec 1               -- [30:30]
  U       : BitVec 1               -- [29:29]
  _fixed2 : BitVec 5 := 0b01110#5  -- [28:24]
  size    : BitVec 2               -- [23:22]
  _fixed3 : BitVec 5 := 0b10000#5  -- [21:17]
  opcode  : BitVec 5               -- [16:12]
  _fixed4 : BitVec 2 := 0b10#2     -- [11:10]
  Rn      : BitVec 5               --   [9:5]
  Rd      : BitVec 5               --   [4:0]
deriving DecidableEq, Repr

instance : ToString Advanced_simd_two_reg_misc_cls where toString a := toString (repr a)

def Advanced_simd_two_reg_misc_cls.toBitVec32 (x : Advanced_simd_two_reg_misc_cls) : BitVec 32 :=
  x._fixed1 ++ x.Q ++ x.U ++ x._fixed2 ++ x.size ++ x._fixed3 ++ x.opcode ++ x._fixed4 ++ x.Rn ++ x.Rd

structure Advanced_simd_copy_cls where
  _fixed1 : BitVec 1 := 0b0#1      -- [31:31]
  Q       : BitVec 1               -- [30:30]
  op      : BitVec 1               -- [29:29]
  _fixed2 : BitVec 7 := 01110000#7 -- [28:21]
  imm5    : BitVec 5               -- [20:16]
  _fixed3 : BitVec 1 := 0b0#1      -- [15:15]
  imm4    : BitVec 4               -- [14:11]
  _fixed4 : BitVec 1 := 0b1#1      -- [10:10]
  Rn      : BitVec 5               --   [9:5]
  Rd      : BitVec 5               --   [4:0]
deriving DecidableEq, Repr

instance : ToString Advanced_simd_copy_cls where toString a := toString (repr a)

structure Advanced_simd_extract_cls where
  _fixed1 : BitVec 1 := 0b0#1      -- [31:31]
  Q       : BitVec 1               -- [30:30]
  _fixed2 : BitVec 6 := 0b101110#6 -- [29:24]
  op2     : BitVec 2               -- [23:22]
  _fixed3 : BitVec 1 := 0b0#1      -- [21:21]
  Rm      : BitVec 5               -- [20:16]
  _fixed4 : BitVec 1 := 0b0#1      -- [15:15]
  imm4    : BitVec 4               -- [14:11]
  _fixed5 : BitVec 1 := 0b0#1      -- [10:10]
  Rn      : BitVec 5               --   [9:5]
  Rd      : BitVec 5               --   [4:0]
deriving DecidableEq, Repr

instance : ToString Advanced_simd_extract_cls where toString a := toString (repr a)

def Advanced_simd_extract_cls.toBitVec32 (x : Advanced_simd_extract_cls) : BitVec 32 :=
  x._fixed1 ++ x.Q ++ x._fixed2 ++ x.op2 ++ x._fixed3 ++ x.Rm ++ x._fixed4 ++ x.imm4 ++ x._fixed5 ++ x.Rn ++ x.Rd

structure Advanced_simd_three_same_cls where
  _fixed1 : BitVec 1 := 0b0#1      -- [31:31]
  Q       : BitVec 1               -- [30:30]
  U       : BitVec 1               -- [29:29]
  _fixed2 : BitVec 5 := 0b01110#5  -- [28:24]
  size    : BitVec 2               -- [23:22]
  _fixed3 : BitVec 1 := 0b1#1      -- [21:21]
  Rm      : BitVec 5               -- [20:16]
  opcode  : BitVec 5               -- [15:11]
  _fixed4 : BitVec 1 := 0b1#1      -- [10:10]
  Rn      : BitVec 5               --   [9:5]
  Rd      : BitVec 5               --   [4:0]
deriving DecidableEq, Repr

instance : ToString Advanced_simd_three_same_cls where toString a := toString (repr a)

def Advanced_simd_three_same_cls.toBitVec32 (x : Advanced_simd_three_same_cls) : BitVec 32 :=
  x._fixed1 ++ x.Q ++ x.U ++ x._fixed2 ++ x.size ++ x._fixed3 ++ x.Rm ++ x.opcode ++ x._fixed4 ++ x.Rn ++ x.Rd

structure Advanced_simd_three_different_cls where
  _fixed1 : BitVec 1 := 0b0#1     -- [31:31]
  Q       : BitVec 1              -- [30:30]
  U       : BitVec 1              -- [29:29]
  _fixed2 : BitVec 5 := 0b01110#5 -- [28:24]
  size    : BitVec 2              -- [23:22]
  _fixed3 : BitVec 1 := 0b1#1     -- [21:21]
  Rm      : BitVec 5              -- [20:16]
  opcode  : BitVec 4              -- [15:12]
  _fixed4 : BitVec 2 := 0b00#2    -- [11:10]
  Rn      : BitVec 5              -- [9:5]
  Rd      : BitVec 5              -- [4:0]
deriving DecidableEq, Repr

instance : ToString Advanced_simd_three_different_cls where toString a := toString (repr a)

def Advanced_simd_three_different_cls.toBitVec32 (x : Advanced_simd_three_different_cls) : BitVec 32 :=
  x._fixed1 ++ x.Q ++ x.U ++ x._fixed2 ++ x.size ++ x._fixed3 ++ x.Rm ++ x.opcode ++ x._fixed4 ++ x.Rn ++ x.Rd

inductive DataProcSFPInst where
  | Crypto_aes :
    Crypto_aes_cls → DataProcSFPInst
  | Crypto_two_reg_sha512 :
    Crypto_two_reg_sha512_cls → DataProcSFPInst
  | Crypto_three_reg_sha512 :
    Crypto_three_reg_sha512_cls → DataProcSFPInst
  | Advanced_simd_two_reg_misc :
    Advanced_simd_two_reg_misc_cls → DataProcSFPInst
  | Advanced_simd_copy :
    Advanced_simd_copy_cls → DataProcSFPInst
  | Advanced_simd_extract :
    Advanced_simd_extract_cls → DataProcSFPInst
  | Advanced_simd_three_same :
    Advanced_simd_three_same_cls → DataProcSFPInst
  | Advanced_simd_three_different :
    Advanced_simd_three_different_cls → DataProcSFPInst
deriving DecidableEq, Repr

instance : ToString DataProcSFPInst where toString a := toString (repr a)

end Decode
