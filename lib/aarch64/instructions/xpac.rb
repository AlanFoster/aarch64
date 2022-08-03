module AArch64
  module Instructions
    # XPACD, XPACI, XPACLRI -- A64
    # Strip Pointer Authentication Code
    # XPACD  <Xd>
    # XPACI  <Xd>
    # XPACLRI
    class XPAC < Instruction
      def initialize rd, d
        @rd = rd
        @d  = d
      end

      def encode
        XPAC(@d, @rd)
      end

      private

      def XPAC d, rd
        insn = 0b1_1_0_11010110_00001_0_1_000_0_11111_00000
        insn |= ((apply_mask(d, 0x1)) << 10)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
