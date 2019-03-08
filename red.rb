require "ncursesw"

Ncurses.initscr
begin
  Ncurses.start_color

  Ncurses.nl()
  Ncurses.noecho()
  Ncurses.curs_set(0)
  Ncurses.stdscr.nodelay(true)


  bg = Ncurses::COLOR_BLACK
  Ncurses.init_pair(1, Ncurses::COLOR_BLUE, bg)
  Ncurses.init_pair(2, Ncurses::COLOR_CYAN, bg)

  screen = Ncurses.stdscr

  screen.attrset(Ncurses.COLOR_PAIR(1))
  screen.mvaddstr(0, 0, "yellow")

  while true
    Ncurses.refresh
    ch = Ncurses.getch()
    if ch == 'q'.ord
      exit
    end
  end
ensure
  Ncurses.curs_set(1)
  Ncurses.endwin()
end
