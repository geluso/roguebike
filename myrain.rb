#!/usr/bin/env ruby

# $Id: rain.rb,v 1.6 2005-08-22 21:41:49 t-peters Exp $
require "ncursesw"

# A class responsible for raindrop drawing
class Raindrop
  def initialize (window, color_pair = nil)
    @window = window
    @color_pair = color_pair
    lines   = []
    columns = []
    window.getmaxyx(lines,columns)
    lines = (lines[0] <= 4) ? 1 : (lines[0] - 4)
    columns = (columns[0] <= 4) ? 1 : (columns[0] - 4)
    @current_phase = 0
    @x = rand(columns)+2
    @y = rand(lines)+2
  end

  # draw_next_phase draws the next phase of a raindrop. If this was the last
  # phase, returns 0, otherwise returns the raindrop.
  def draw_next_phase
    if (@color_pair)
      if Ncurses.respond_to?(:color_set)
        @window.color_set(@color_pair, nil)
      else
        @window.attrset(Ncurses.COLOR_PAIR(@color_pair))
      end
    end
    @window.mvaddstr(@y, @x, "O")
  end
end


# This class creates raindrops and tells them to draw on the screen
class Rain
  def initialize(window)
    @window = window
    @raindrops = []
    @has_colors = Ncurses.has_colors?
    if (@has_colors)
      @current_color = 1
    end
  end

  def fall_for_a_moment
    10.times{
      if (@has_colors)
        @raindrops.push(Raindrop.new(@window, @current_color))
        @current_color = 3 - @current_color  # alternate between 1 and 2
      else
        @raindrops.push(Raindrop.new(@window))
      end
    }

    @raindrops = @raindrops.collect{|raindrop|
      raindrop.draw_next_phase
    }.compact # erase raindrops that have expired from the list
  end
end

Ncurses.initscr
begin
  if (Ncurses.has_colors?)
    bg = Ncurses::COLOR_BLACK
    Ncurses.start_color
    if (Ncurses.respond_to?("use_default_colors"))
      if (Ncurses.use_default_colors == Ncurses::OK)
        bg = -1
      end
    end
    Ncurses.init_pair(1, Ncurses::COLOR_BLUE, bg);
    Ncurses.init_pair(2, Ncurses::COLOR_CYAN, bg);
  end
  Ncurses.nl()
  Ncurses.noecho()
  Ncurses.curs_set(0)
  Ncurses.stdscr.nodelay(true)

  rain = Rain.new(Ncurses.stdscr)

  rain.fall_for_a_moment
  Ncurses.refresh
  gets.chomp
ensure
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
