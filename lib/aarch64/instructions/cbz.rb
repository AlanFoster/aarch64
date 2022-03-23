module AArch64
  module Instructions
    # CBZ -- A64
    # Compare and Branch on Zero
    # CBZ  <Wt>, <label>
    # CBZ  <Xt>, <label>
    class CBZ
      def encode
        raise NotImplementedError
      end

      private

      def CBZ sf, imm19, rt
        insn = 0b0_011010_0_0000000000000000000_00000
        insn |= ((sf & 0x1) << 31)
        insn |= ((imm19 & 0x7ffff) << 5)
        insn |= (rt & 0x1f)
        insn
      end
    end
  end
end
