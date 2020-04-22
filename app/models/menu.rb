class Menu < ActiveRecord::Base
  has_many :menu_items
  validates :name, presence: true

  def isActive?
    active
  end

  def makeActive
    Menu.all.map { |menu|
      menu.active = false
      menu.save
    }
    menu = Menu.find(id)
    menu.active = true
    menu.save
    Menu.all.map { |menu| puts "#{menu.name} #{menu.active}" }
  end

  def self.getActiveMenu
    menu = Menu.find_by(active: true)
  end
end
