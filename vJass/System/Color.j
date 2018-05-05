library Color
    struct RGB extends array
        implement Alloc32
        integer r
        integer g
        integer b
        readonly static thistype cornFlowerBlue
        readonly static thistype black 
        readonly static thistype white
        readonly static thistype red
        readonly static thistype green
        readonly static thistype blue
        readonly static thistype yellow
        readonly static thistype magenta
        readonly static thistype cyan
        readonly static thistype lightGray
        readonly static thistype darkGray
        readonly static thistype silver
        readonly static thistype gray
        readonly static thistype array team
        
        static method create takes integer r, integer g, integer b returns thistype 
            local thistype this = allocate()
            set this.r = r 
            set this.g = g
            set this.b = b
            return this
        endmethod
        
        static method load takes nothing returns nothing 
            set cornFlowerBlue = thistype.create(100, 149, 237)
            set black = thistype.create(0, 0, 0)
            set white = thistype.create(255, 255, 255)
            set red = thistype.create(255, 0, 0)
            set green = thistype.create(0, 255, 0)
            set blue = thistype.create(0, 0, 255)
            set yellow = thistype.create(255, 255, 0)
            set magenta = thistype.create(255, 0, 255)
            set cyan = thistype.create(0, 255, 255)
            set lightGray = thistype.create(211, 211, 211)
            set darkGray = thistype.create(169, 169, 169)
            set silver = thistype.create(192, 192, 192)
            set gray = thistype.create(128, 128, 128)
            set team[0] = thistype.create(255, 3, 3)
            set team[1] = thistype.create(0, 66, 255)
            set team[2] = thistype.create(28, 230, 185)
            set team[3] = thistype.create(84, 0, 129)
            set team[4] = thistype.create(255, 252, 0)
            set team[5] = thistype.create(254, 138, 14)
            set team[6] = thistype.create(32, 192, 0)
            set team[7] = thistype.create(229, 91, 176)
            set team[8] = thistype.create(149, 150, 151)
            set team[9] = thistype.create(126, 191, 241)
            set team[10] = thistype.create(16, 98, 70)
            set team[11] = thistype.create(78, 42, 4)
            set team[12] = thistype.create(155, 0, 0)
            set team[13] = thistype.create(0, 0, 195)
            set team[14] = thistype.create(0, 234, 255)
            set team[15] = thistype.create(190, 0, 254)
            set team[16] = thistype.create(235, 205, 135)
            set team[17] = thistype.create(248, 164, 139)
            set team[18] = thistype.create(191, 255, 128)
            set team[19] = thistype.create(220, 185, 235)
            set team[20] = thistype.create(40, 40, 40)
            set team[21] = thistype.create(235, 240, 255)
            set team[22] = thistype.create(0, 120, 30)
            set team[23] = thistype.create(164, 111, 51)
        endmethod
    endstruct
endlibrary 