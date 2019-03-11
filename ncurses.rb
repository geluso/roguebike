require 'ncursesw'

begin
  scr = Ncurses.initscr()
  Ncurses.cbreak()
  Ncurses.noecho()
  Ncurses.keypad(scr, true)
  Ncurses.start_color()

  bg = Ncurses::COLOR_BLACK
  Ncurses.init_pair(1, Ncurses::COLOR_BLUE, bg);
  Ncurses.init_pair(2, Ncurses::COLOR_CYAN, bg);

  if Ncurses.respond_to?(:color_set)
    scr.color_set(@color_pair, nil)
  else
    scr.attrset(Ncurses.COLOR_PAIR(1))
  end

  scr.addstr("9999")
  scr.refresh
  scr.getch
ensure
  # put the screen back in its normal state
  Ncurses.echo()
  Ncurses.nocbreak()
  Ncurses.nl()
  Ncurses.endwin()
end

puts "black: #{$black}"
puts "white: #{$white}"

puts "color pair: #{$cp}"
