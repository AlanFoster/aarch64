module AArch64
  module Instructions
    # RORV -- A64
    # Rotate Right Variable
    # RORV  <Wd>, <Wn>, <Wm>
    # RORV  <Xd>, <Xn>, <Xm>
    class RORV < Instruction
      def initialize rd, rn, rm, sf
        @rd = rd
        @rn = rn
        @rm = rm
        @sf = sf
      end

      def encode
        RORV(@sf, @rm, @rn, @rd)
      end

      private

      def RORV sf, rm, rn, rd
        insn = 0b0_0_0_11010110_00000_0010_11_00000_00000
        insn |= ((apply_mask(sf, 0x1)) << 31)
        insn |= ((apply_mask(rm, 0x1f)) << 16)
        insn |= ((apply_mask(rn, 0x1f)) << 5)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
