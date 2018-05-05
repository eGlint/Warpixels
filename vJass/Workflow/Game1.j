library MyGame uses Game
    struct Game1 extends Game
        PixelPlayer p0
        
        method initialize takes nothing returns nothing
            call super.initialize()
            set p0 = players[0]
        endmethod
        
        method load takes nothing returns nothing
            call Font_color(240, 240, 240)
        endmethod
         
        method update takes nothing returns nothing
            call p0.update()
        endmethod

        method draw takes nothing returns nothing
            call Bitmap_setColor(RGB.cornFlowerBlue)
            call PixelText_reset()
            call PixelText_print("Hello World!")
        endmethod
    endstruct
endlibrary