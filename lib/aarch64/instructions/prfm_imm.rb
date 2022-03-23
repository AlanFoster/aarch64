module AArch64
  module Instructions
    # PRFM (immediate) -- A64
    # Prefetch Memory (immediate)
    # PRFM  (<prfop>|#<imm5>), [<Xn|SP>{, #<pimm>}]
    class PRFM_imm
      def encode
        raise NotImplementedError
      end

      private

      def PRFM_imm imm12, rn, rt
        insn = 0b11_111_0_01_10_000000000000_00000_00000
        insn |= ((imm12 & 0xfff) << 10)
        insn |= ((rn & 0x1f) << 5)
        insn |= (rt & 0x1f)
        insn
      end
    end
  end
end
