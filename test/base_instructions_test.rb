require "helper"

class BaseInstructionsTest < AArch64::Test
  include AArch64
  include AArch64::Registers

  attr_reader :asm

  def setup
    @asm = Assembler.new
  end

  def test_adc
    asm.adc X0, X1, X2
    assert_one_insn "adc x0, x1, x2"
  end

  def test_adc_w
    asm.adc W0, W1, W2
    assert_one_insn "adc w0, w1, w2"
  end

  def test_adcs
    asm.adcs X0, X1, X2
    assert_one_insn "adcs x0, x1, x2"
  end

  def test_adcs_w
    asm.adcs W0, W1, W2
    assert_one_insn "adcs w0, w1, w2"
  end

  def test_add_extended_register
    asm.add X0, X1, X2, extend: :sxtx
    assert_one_insn "add x0, x1, x2, sxtx"
  end

  def test_add_extended_register_amount
    asm.add X0, X1, X2, extend: :sxtx, amount: 4
    assert_one_insn "add x0, x1, x2, sxtx #4"
  end

  def test_add_extended_register_w
    asm.add X0, X1, W2, extend: :sxtw
    assert_one_insn "add x0, x1, w2, sxtw"
  end

  def test_add_extended_register_www
    asm.add W0, W1, W2, extend: :sxtw
    assert_one_insn "add w0, w1, w2, sxtw"
  end

  def test_add_immediate
    asm.add X0, X1, 0x2a
    assert_one_insn "add x0, x1, #0x2a"
  end

  def test_add_immediate_shift
    asm.add X0, X1, 0x2a, lsl: 12
    assert_one_insn "add x0, x1, #0x2a, lsl #12"
  end

  def test_add_immediate_shift_w
    asm.add W0, W1, 0x2a, lsl: 12
    assert_one_insn "add w0, w1, #0x2a, lsl #12"
  end

  def test_add_addsub_shift
    asm.add X0, X1, X2
    assert_one_insn "add x0, x1, x2"
  end

  def test_add_addsub_shift_amount
    asm.add X0, X1, X2, shift: :lsr, amount: 3
    assert_one_insn "add x0, x1, x2, lsr #3"
  end

  def test_addg
    skip "clang doesn't seem to support this one"
    asm.addg X0, X1, 16, 1
    assert_one_insn "addg x0, x1, #4, #2"
  end

  def test_ADDS_addsub_ext_32
    asm.adds W3, W5, W7, extend: :uxth
    assert_one_insn "adds w3, w5, w7, uxth"
  end

  def test_ADDS_addsub_ext
    asm.adds X3, X5, X9, extend: :sxtx, amount: 2
    assert_one_insn "adds x3, x5, x9, sxtx #2"
  end

  def test_ADDS_addsub_imm
    asm.adds X3, X5, 3
    assert_one_insn "adds x3, x5, #3"
  end

  def test_ADDS_addsub_imm_w
    asm.adds W3, W5, 3
    assert_one_insn "adds w3, w5, #3"
  end

  def test_ADDS_addsub_imm_shift
    asm.adds X3, X5, 3, lsl: 12
    assert_one_insn "adds x3, x5, #3, lsl #12"
  end

  def test_ADDS_addsub_shift
    asm.adds X3, X5, X1
    assert_one_insn "adds x3, x5, x1"
  end

  def test_ADDS_addsub_shift
    asm.adds X3, X5, X1, shift: :lsr
    assert_one_insn "adds x3, x5, x1, lsr #0"
  end

  def test_ADDS_addsub_shift_amount
    asm.adds X3, X5, X1, shift: :lsr, amount: 3
    assert_one_insn "adds x3, x5, x1, lsr #3"
  end

  def test_ADR
    label = asm.make_label :foo
    asm.adr X3, label
    asm.put_label label
    assert_one_insn "adr x3, #4"
  end

  def test_ADRP
    asm.adrp X3, 4000
    assert_one_insn "adrp x3, #0x4000"
  end

  def test_AND_log_imm
    assert_one_insn "and x3, x1, #2" do |asm|
      asm.and X3, X1, 2
    end

    assert_one_insn "and w3, w1, #1" do |asm|
      asm.and W3, W1, 1
    end
  end

  def test_b
    asm.b 0x8
    assert_one_insn "b #8"
  end

  def test_b_with_label
    label = asm.make_label :foo
    asm.b label
    asm.put_label label
    assert_one_insn "b #4"
  end

  def test_brk
    asm.brk 1
    assert_one_insn "brk #0x1"
  end

  def test_ret
    asm.ret
    assert_one_insn "ret"
  end

  def test_movz
    asm.movz X0, 0x2a
    assert_one_insn "movz x0, #0x2a"
  end

  def test_movz_shift
    asm.movz X0, 0x2a, lsl: 16
    assert_one_insn "movz x0, #0x2a, lsl #16"
  end

  def test_movz_with_w
    asm.movz W0, 0x2a
    assert_one_insn "movz w0, #0x2a"
  end

  def test_movk
    asm.movk X0, 0x2a
    assert_one_insn "movk x0, #0x2a"
  end

  def test_movk_shift
    asm.movk X0, 0x2a, lsl: 16
    assert_one_insn "movk x0, #0x2a, lsl #16"
  end

  def assert_one_insn asm_str
    asm = self.asm

    if block_given?
      asm = Assembler.new
      yield asm
    end

    jit_buffer = StringIO.new
    asm.write_to jit_buffer
    if $DEBUG
      puts jit_buffer.string.bytes.map { |x| sprintf("%02x", x ) }.join(" ")
      puts sprintf("%032b", jit_buffer.string.unpack1("L<"))
    end
    super(jit_buffer.string, asm: asm_str)
  end
end