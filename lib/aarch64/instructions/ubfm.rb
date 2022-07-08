module AArch64
  module Instructions
    # UBFM -- A64
    # Unsigned Bitfield Move
    # UBFM  <Wd>, <Wn>, #<immr>, #<imms>
    # UBFM  <Xd>, <Xn>, #<immr>, #<imms>
    class UBFM < Instruction
      def initialize rd, rn, immr, imms, sf
        @rd   = rd
        @rn   = rn
        @immr = immr
        @imms = imms
        @sf   = sf
      end

      def encode
        UBFM(@sf, @sf, @immr, @imms, @rn.to_i, @rd.to_i)
      end

      private

      def UBFM sf, n, immr, imms, rn, rd
        insn = 0b0_10_100110_0_000000_000000_00000_00000
        insn |= ((apply_mask(sf, 0x1)) << 31)
        insn |= ((apply_mask(n, 0x1)) << 22)
        insn |= ((apply_mask(immr, 0x3f)) << 16)
        insn |= ((apply_mask(imms, 0x3f)) << 10)
        insn |= ((apply_mask(rn, 0x1f)) << 5)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
