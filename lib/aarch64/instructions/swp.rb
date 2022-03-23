module AArch64
  module Instructions
    # SWP, SWPA, SWPAL, SWPL -- A64
    # Swap word or doubleword in memory
    # SWP  <Ws>, <Wt>, [<Xn|SP>]
    # SWPA  <Ws>, <Wt>, [<Xn|SP>]
    # SWPAL  <Ws>, <Wt>, [<Xn|SP>]
    # SWPL  <Ws>, <Wt>, [<Xn|SP>]
    # SWP  <Xs>, <Xt>, [<Xn|SP>]
    # SWPA  <Xs>, <Xt>, [<Xn|SP>]
    # SWPAL  <Xs>, <Xt>, [<Xn|SP>]
    # SWPL  <Xs>, <Xt>, [<Xn|SP>]
    class SWP
      def encode
        raise NotImplementedError
      end

      private

      def SWP a, r, rs, rn, rt
        insn = 0b1x_111_0_00_0_0_1_00000_1_000_00_00000_00000
        insn |= ((a & 0x1) << 23)
        insn |= ((r & 0x1) << 22)
        insn |= ((rs & 0x1f) << 16)
        insn |= ((rn & 0x1f) << 5)
        insn |= (rt & 0x1f)
        insn
      end
    end
  end
end
