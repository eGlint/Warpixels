library Bitmap uses Pixel
    globals 
        public constant integer Width = 128
        public constant integer Height = 72
        public constant integer Area = Width * Height
        public constant integer ModelOffset = 20
        public constant integer OffsetX = (Width * ModelOffset) / 2
        public constant integer OffsetY = (Height * ModelOffset) / 2
        public boolean loadDone
        private Pixel array pixels
        private boolean array freezedPixel
        private integer loadX
        private integer loadY
        private integer loadIndex
        private integer index
    endglobals
    
    private function loadPixels takes nothing returns nothing 
        if loadY < Height then  
            set loadX = 0
            loop
                exitwhen loadX >= Width
                set pixels[loadIndex] = Pixel.create(loadX * ModelOffset - OffsetX, -loadY * ModelOffset + OffsetY).color(RGB.cornFlowerBlue)
                set loadIndex = loadIndex + 1
                set loadX = loadX + 1
            endloop
            set loadY = loadY + 1
        else 
            call CinematicModeBJ(false, GetPlayersAll())
            call DestroyTimer(GetExpiredTimer())
            set loadDone = true
        endif
    endfunction
    
    public function init takes nothing returns nothing 
        set loadX = 0
        set loadY = 0
        set loadIndex = 0
        call CinematicModeBJ(true, GetPlayersAll())
        call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,3, "Warpixels")
        call TimerStart(CreateTimer(), 0.1, true, function loadPixels)
    endfunction
    
    //! textmacro Bitmap_forEach
        set index = 0
        loop 
            exitwhen index > Area
    //! endtextmacro
    
    //! textmacro Bitmap_endForEach
        set index = index + 1
        endloop
    //! endtextmacro
    
    private function pFreeze takes integer sx, integer sy, integer ex, integer ey, boolean enabled returns nothing
        local integer x
        local integer y = sy
        loop
            exitwhen y > ey
            set x = sx
            loop
                exitwhen x > ex
                set freezedPixel[x + y * Width] = enabled
                set x = x + 1
            endloop
            set y = y + 1
        endloop
    endfunction

    public function freeze takes integer sx, integer sy, integer ex, integer ey returns nothing
        call pFreeze(sx, sy, ex, ey, true)
    endfunction

    public function unfreeze takes integer sx, integer sy, integer ex, integer ey returns nothing
        call pFreeze(sx, sy, ex, ey, false)
    endfunction

    public function unfreezeAll takes nothing returns nothing 
        //! runtextmacro Bitmap_forEach()
        set freezedPixel[index] = false
        //! runtextmacro Bitmap_endForEach()
    endfunction

    public function setColor takes RGB color returns nothing 
        //! runtextmacro Bitmap_forEach()
        if (not freezedPixel[index]) then
            call pixels[index].color(color)
        endif
        //! runtextmacro Bitmap_endForEach()
    endfunction
    
    public function setColorRaw takes integer r, integer g, integer b returns nothing 
        //! runtextmacro Bitmap_forEach()
        if (not freezedPixel[index]) then
            call pixels[index].colorRaw(r, g, b)
        endif
        //! runtextmacro Bitmap_endForEach()
    endfunction
    
    public function setRenderState takes boolean enabled returns nothing 
        //! runtextmacro Bitmap_forEach()
        call pixels[index].renderStateAlways(enabled)
        //! runtextmacro Bitmap_endForEach()
    endfunction
    
    public function setPixelColorRaw takes integer x, integer y, integer r, integer g, integer b returns nothing
        local integer index = x + y * Width
        if (freezedPixel[index]) then
            return 
        endif
        call pixels[index].colorRaw(r, g, b)
    endfunction

    public function getPixel takes integer x, integer y returns Pixel 
        return pixels[x + y * Width]
    endfunction

    public function getPixelIndex takes integer index returns Pixel 
        return pixels[index]
    endfunction
endlibrary
