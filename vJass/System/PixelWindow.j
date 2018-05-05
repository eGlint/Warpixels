library PixelWindow uses Window
    function PixelWindow_load takes nothing returns nothing 
        call Window_load()
    endfunction
    
    function PixelWindow_draw takes integer x, integer y, integer width, integer height returns nothing 
        local integer nx 
        local integer ny = 1
        local integer op0
        local integer op1
        call Window_draw(0, x, y)
        loop
            exitwhen ny > height
            set nx = 1
            loop
                set op0 = x + Window_width * nx
                set op1 = y + Window_height * ny
                exitwhen nx > width
                call Window_draw(1, op0, y)
                call Window_draw(4, op0, op1)
                if (nx == width) then
                    call Window_draw(2, x + Window_width * (nx + 1), y)
                endif
                if (ny == height) then
                    call Window_draw(7, op0, y + Window_height * (ny + 1))
                endif
                set nx = nx + 1
            endloop
            call Window_draw(3, x, op1)
            call Window_draw(5, op0, op1)
            set ny = ny + 1
        endloop
        call Window_draw(6, x, y + Window_height * ny)
        call Window_draw(8, x + Window_width * nx, y + Window_height * ny)
    endfunction
endlibrary