module AArch64
  module Instructions
    # SYSL -- A64
    # System instruction with result
    # SYSL  <Xt>, #<op1>, <Cn>, <Cm>, #<op2>
    class SYSL < Instruction
      def initialize xt, op1, cn, cm, op2
        @xt  = xt
        @op1 = op1
        @cn  = cn
        @cm  = cm
        @op2 = op2
      end

      def encode
        SYSL(@op1, @cn.to_i, @cm.to_i, @op2, @xt.to_i)
      end

      private

      def SYSL op1, crn, crm, op2, rt
        insn = 0b1101010100_1_01_000_0000_0000_000_00000
        insn |= ((apply_mask(op1, 0x7)) << 16)
        insn |= ((apply_mask(crn, 0xf)) << 12)
        insn |= ((apply_mask(crm, 0xf)) << 8)
        insn |= ((apply_mask(op2, 0x7)) << 5)
        insn |= (apply_mask(rt, 0x1f))
        insn
      end
    end
  end
end
