
Arduino Nano (ошибка при прошивке)

- I solved my problem by messing around with choosing different boards from the menu choices '(Tools > Board > ATmega328P  -- and Tools > Board > ATmega328P \(Old Bootloader\)', and a few other menu options, and opening and closing different sketches and magically it started working again with ATmega328 menu choice.

- I think my problem re-occurred because I used a different Nano that must not need the Old Bootloader where the previous Nano I had plugged in did need it. With Nano #2 the IDE finally started working with the ATmega328P choice... not the 'Old Bootloader' choice. But it took a bunch of poking around.
