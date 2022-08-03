module AArch64
  module Instructions
    # B.cond -- A64
    # Branch conditionally
    # B.<cond>  <label>
    class B_cond < Instruction
      def initialize cond, label
        @cond  = cond
        @label = label
      end

      def encode
        B_cond(unwrap_label(@label), Utils.cond2bin(@cond))
      end

      private

      def B_cond imm19, cond
        insn = 0b0101010_0_0000000000000000000_0_0000
        insn |= ((apply_mask(imm19, 0x7ffff)) << 5)
        insn |= (apply_mask(cond, 0xf))
        insn
      end
    end
  end
end
