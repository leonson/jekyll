require File.dirname(__FILE__) + '/helper'

class TestPost < Test::Unit::TestCase
  def setup
    
  end
  
  def test_valid
    assert Post.valid?("2008-10-19-foo-bar.textile")
    assert !Post.valid?("blah")
  end
  
  def test_process
    p = Post.allocate
    p.process("2008-10-19-foo-bar.textile")
    
    assert_equal Time.parse("2008-10-19"), p.date
    assert_equal "foo-bar", p.slug
    assert_equal "textile", p.ext
  end
  
  def test_url
    p = Post.allocate
    p.process("2008-10-19-foo-bar.textile")
    
    assert_equal "/2008/10/19/foo-bar", p.url
  end
  
  def test_read_yaml
    p = Post.allocate
    p.read_yaml(File.join(File.dirname(__FILE__), *%w[source posts]), "2008-10-18-foo-bar.textile")
    
    assert_equal({"title" => "Foo Bar"}, p.data)
    assert_equal "\nh1. {{ page.title }}\n\nBest post ever", p.contents
  end
end