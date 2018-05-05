library JSprite
//! textmacro JSpriteInit takes WIDTH, HEIGHT, AREA, AR, AG, AB, TR, TG, TB
    globals
		public integer width = $WIDTH$
		public integer height = $HEIGHT$
		public integer area = $AREA$
		private integer alphaR = $AR$
		private integer alphaG = $AG$
		private integer alphaB = $AB$
		private integer teamR  = $TR$
		private integer teamG  = $TG$
		private integer teamB  = $TB$
		private integer array R
		private integer array G
		private integer array B
	endglobals
//! endtextmacro

//! textmacro JSpriteSetPixel
private function setPixel takes integer index, integer nR, integer nG, integer nB returns nothing 
    set R[index] = nR
    set G[index] = nG
    set B[index] = nB
endfunction
//! endtextmacro

//! textmacro JSpriteDraw
    public function draw2 takes integer spriteId, integer x, integer y, integer flip, integer team returns nothing
        local integer nx
        local integer ny = 0
        local integer sx 
        local integer sy
        local integer sR
        local integer sG
        local integer sB
        local integer target = spriteId * area
        local integer spriteIndex
        local Pixel pixel
        loop
            exitwhen ny >= height
            set nx = 0
            loop 
                exitwhen nx >= width
                set sx = nx
                set sy = ny
                if (flip > 0) then
                    if (flip == 1 or flip == 3) then
                        set sx = (width - 1 - nx)
                    endif
                    if (flip == 2 or flip == 3) then
                        set sy = (height - 1 - ny)
                    endif
                endif
                set spriteIndex = sx + sy * width + target
                set sR = R[spriteIndex]
                set sG = G[spriteIndex]
                set sB = B[spriteIndex]
                set pixel = Bitmap_getPixel(x + nx, y + ny)
                if (team > -1 and sR == teamR and sG == teamG and sB == teamB) then
                    call Bitmap_setPixelColorRaw(x + nx, y + ny, RGB.team[team].r, RGB.team[team].g, RGB.team[team].b)
                    //call pixel.colorRaw(RGB.team[team].r, RGB.team[team].g, RGB.team[team].b)
                elseif (sR != alphaR or sG != alphaG or sB != alphaB) then
                    call Bitmap_setPixelColorRaw(x + nx, y + ny, sR, sG, sB)
                    //call pixel.colorRaw(sR, sG, sB)
                endif
                set nx = nx + 1
            endloop
            set ny = ny + 1
        endloop
    endfunction 
    
    public function draw1 takes integer spriteId, integer x, integer y, integer flip returns nothing
        call draw2(spriteId, x, y, flip, -1)
    endfunction 
    
    public function draw takes integer spriteId, integer x, integer y returns nothing
        call draw2(spriteId, x, y, 0, -1)
    endfunction
//! endtextmacro
endlibrary