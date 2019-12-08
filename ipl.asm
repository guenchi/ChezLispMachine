        org     0x7c00

        jmp     entry

        db      0x90
        db      "LispMach"       
        dw      512              
        db      1                
        dw      1                
        db      2                
        dw      224
        dw      2880
        db      0xf0
        dw      9
        dw      18
        dw      2
        dd      0
        dd      2880
        db      0, 0, 0x29
        dd      0xffffffff
        db      "ChezLispMach"
        db      "FAT12   "
        times   18 db 0

entry:

        mov     ax, 0
        mov     ss, ax
        mov     sp, 0x7c00
        mov     ds, ax
        mov     es, ax
        mov     si, msg


print:

        mov     al, [si]
        add     si, 1
        cmp     al, 0
        je      end
        mov     AH, 0x0e
        mov     BX, 15
        int     0x10
        jmp     print

end:

        hlt
        jmp end

msg:

        db      0x0a, 0x0a, 0x0a
        db      "Chez Lisp Machine"
        db      0x0a, 0x0a, 0x0a
        db      "- guenchi"
        db      0 

        times 510 - ($ - $$) db 0
        db 0x55, 0xaa
