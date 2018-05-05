library Pixel uses Color
    struct Pixel extends array
        implement Alloc32
        real x
        real y
        image pixel
        static method create takes real x, real y returns thistype
            local thistype this = allocate()
            set pixel = CreateImage("Pixel.blp", 24, 24, 24, x, y, 2000, 0, 0, 0, 2)
            call renderStateAlways(true)
            call position(x, y)
            return this
        endmethod
        
        method renderStateAlways takes boolean value returns nothing 
            call SetImageRenderAlways(pixel, value)
        endmethod
        
        private method ondestroy takes nothing returns nothing 
            call DestroyImage(pixel)
            set x = 0
            set y = 0
            set pixel = null
        endmethod
        
        method destroy takes nothing returns nothing 
            call ondestroy()
            call deallocate() 
        endmethod
        
        method position takes real x, real y returns thistype
            set this.x = x
            set this.y = y
            call SetImagePosition(pixel, x, y, 0)
            return this
        endmethod
        
        method colorRaw takes integer r, integer g, integer b returns thistype
            call SetImageColor(pixel, r, g, b, 255)
            return this
        endmethod
        
        method color takes RGB c returns thistype
            call SetImageColor(pixel,  c.r, c.g, c.b, 255)
            return this
        endmethod
        
    endstruct
endlibrary