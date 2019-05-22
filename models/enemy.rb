# frozen_string_literal: true

# Enemy model
class Enemy
  attr_reader :life

  def initialize(life:)
    @life = life
  end
end
