module AArch64
  module Instructions
    # LDTRSW -- A64
    # Load Register Signed Word (unprivileged)
    # LDTRSW  <Xt>, [<Xn|SP>{, #<simm>}]
    class LDTRSW
      def encode
        raise NotImplementedError
      end

      private

      def LDTRSW imm9, rn, rt
        insn = 0b10_111_0_00_10_0_000000000_10_00000_00000
        insn |= ((imm9 & 0x1ff) << 12)
        insn |= ((rn & 0x1f) << 5)
        insn |= (rt & 0x1f)
        insn
      end
    end
  end
end
