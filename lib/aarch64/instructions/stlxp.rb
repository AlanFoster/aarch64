module AArch64
  module Instructions
    # STLXP -- A64
    # Store-Release Exclusive Pair of registers
    # STLXP  <Ws>, <Wt1>, <Wt2>, [<Xn|SP>{,#0}]
    # STLXP  <Ws>, <Xt1>, <Xt2>, [<Xn|SP>{,#0}]
    class STLXP < Instruction
      def initialize rs, rt, rt2, rn, sz
        @rs  = check_mask(rs, 0x1f)
        @rt  = check_mask(rt, 0x1f)
        @rt2 = check_mask(rt2, 0x1f)
        @rn  = check_mask(rn, 0x1f)
        @sz  = check_mask(sz, 0x01)
      end

      def encode
        STLXP(@sz, @rs, @rt2, @rn, @rt)
      end

      private

      def STLXP sz, rs, rt2, rn, rt
        insn = 0b1_0_001000_0_0_1_00000_1_00000_00000_00000
        insn |= ((apply_mask(sz, 0x1)) << 30)
        insn |= ((apply_mask(rs, 0x1f)) << 16)
        insn |= ((apply_mask(rt2, 0x1f)) << 10)
        insn |= ((apply_mask(rn, 0x1f)) << 5)
        insn |= (apply_mask(rt, 0x1f))
        insn
      end
    end
  end
end
