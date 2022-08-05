module AArch64
  module Instructions
    # ORR (shifted register) -- A64
    # Bitwise OR (shifted register)
    # ORR  <Wd>, <Wn>, <Wm>{, <shift> #<amount>}
    # ORR  <Xd>, <Xn>, <Xm>{, <shift> #<amount>}
    class ORR_log_shift < Instruction
      def initialize rd, rn, rm, shift, imm6, sf
        @rd    = check_mask(rd, 0x1f)
        @rn    = check_mask(rn, 0x1f)
        @rm    = check_mask(rm, 0x1f)
        @shift = check_mask(shift, 0x03)
        @imm6  = check_mask(imm6, 0x3f)
        @sf    = check_mask(sf, 0x01)
      end

      def encode
        ORR_log_shift(@sf, @shift, @rm, @imm6, @rn, @rd)
      end

      private

      def ORR_log_shift sf, shift, rm, imm6, rn, rd
        insn = 0b0_01_01010_00_0_00000_000000_00000_00000
        insn |= ((apply_mask(sf, 0x1)) << 31)
        insn |= ((apply_mask(shift, 0x3)) << 22)
        insn |= ((apply_mask(rm, 0x1f)) << 16)
        insn |= ((apply_mask(imm6, 0x3f)) << 10)
        insn |= ((apply_mask(rn, 0x1f)) << 5)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
