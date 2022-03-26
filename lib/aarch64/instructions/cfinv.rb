module AArch64
  module Instructions
    # CFINV -- A64
    # Invert Carry Flag
    # CFINV
    class CFINV
      def encode
        raise NotImplementedError
      end

      private

      def CFINV 
        insn = 0b1101010100_0_0_0_000_0100_0000_000_11111
        insn
      end
    end
  end
end