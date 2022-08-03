module AArch64
  module Instructions
    # MOVK -- A64
    # Move wide with keep
    # MOVK  <Wd>, #<imm>{, LSL #<shift>}
    # MOVK  <Xd>, #<imm>{, LSL #<shift>}
    class MOVK < Instruction
      def initialize reg, imm, shift, sf
        @reg   = reg
        @imm   = imm
        @shift = shift
        @sf    = sf
      end

      def encode
        MOVK(@sf, @shift, @imm, @reg)
      end

      private

      def MOVK sf, hw, imm16, rd
        insn = 0b0_11_100101_00_0000000000000000_00000
        insn |= ((apply_mask(sf, 0x1)) << 31)
        insn |= ((apply_mask(hw, 0x3)) << 21)
        insn |= ((apply_mask(imm16, 0xffff)) << 5)
        insn |= (apply_mask(rd, 0x1f))
        insn
      end
    end
  end
end
