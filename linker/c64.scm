(define memories
  '((memory program
            (address (#x801 . #xbfff))
            (section (programStart #x801) (startup #x80e)
                     code switch data cdata data_init_table))
    (memory zeroPage
            (address (#x2 . #xff))
            (section registers))
    (memory stack
            (address (#x100 . #x1ff))
            (section stack))
    (memory data
            (address (#xc000 . #xcfff))
            (section cstack heap zdata))
    (block cstack (size #x600))               ; C stack size
    (block stack  (size #x100))               ; machine stack size
    (block heap   (size #x200))               ; heap size
    ))
