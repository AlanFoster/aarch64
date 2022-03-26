module AArch64
  module Instructions
    # MOV (wide immediate) -- A64
    # Move (wide immediate)
    # MOV  <Wd>, #<imm>
    # MOVZ <Wd>, #<imm16>, LSL #<shift>
    # MOV  <Xd>, #<imm>
    # MOVZ <Xd>, #<imm16>, LSL #<shift>
    class MOV_MOVZ
      def encode
        raise NotImplementedError
      end

      private

      def MOV_MOVZ sf, hw, imm16, rd
        insn = 0b0_10_100101_00_0000000000000000_00000
        insn |= ((sf & 0x1) << 31)
        insn |= ((hw & 0x3) << 21)
        insn |= ((imm16 & 0xffff) << 5)
        insn |= (rd & 0x1f)
        insn
      end
    end
  end
end