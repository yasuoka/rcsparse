require 'test/unit'
require 'time'
require 'rcsparse'

class BasicsTest < Test::Unit::TestCase
  def setup
    @f = RCSFile.new('test,v')
  end

  def test_file
    assert(@f.head == '1.472', 'Correct HEAD')
  end

  def test_symbols
    s = @f.symbols
    assert(s['RELENG_4'] == '1.141.0.2', 'Symbol lookup')
  end

  def test_resolve_sym
    assert(@f.resolve_sym('RELENG_4') == '1.141.2.70', 'Resolve sym')
  end

  def test_revs
    r = @f.revs
    assert(r.key?('1.1'), 'Rev lookup')
    assert(!r.key?('1.500'), 'Rev lookup 2')
    assert(r['1.1'] != nil, 'Rev lookup 3')
    assert(r['1.120'].date == Time.parse('Thu Dec 30 11:31:21 CET 1999'),
	'Positive rev time (2-digit year)')
    assert(r['1.121'].date == Time.parse('Tue Jan 04 15:12:12 CET 2000'),
	'Rev time (4-digit year)')
  end
end