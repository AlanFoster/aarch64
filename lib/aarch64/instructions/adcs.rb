module AArch64
  module Instructions
    # ADCS -- A64
    # Add with Carry, setting flags
    # ADCS  <Wd>, <Wn>, <Wm>
    class ADCS < Instruction
      def initialize rd, rn, rm, sf
        @rd = rd
        @rn = rn
        @rm = rm
        @sf = sf
      end

      def encode
        ADCS(@sf, @rm, @rn, @rd)
      end

      private

      def ADCS sf, rm, rn, rd
        insn = 0b0_0_1_11010000_00000_000000_00000_00000
        insn |= ((apply_mask(sf, 0x1)) << 31)
        insn |= ((apply_mask(rm, 0x1f)) << 16)
        insn |= ((apply_mask(rn, 0x1f)) << 5)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
