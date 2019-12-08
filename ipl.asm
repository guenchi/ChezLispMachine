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

        mov     ax, 0x0820
        mov     es, ax
        mov     ch, 0
        mov     dh, 0
        mov     cl, 2

        mov     si, 0
retry:
        mov     ah, 0x02
        mov     al, 1
        mov     bx, 0
        mov     dl, 0x00
        int     0x13

        jnc     end
        add     si, 1
        cmp     si, 5
        jae     error
        mov     ah, 0x00
        mov     dl, 0x00
        int     0x13
        jmp     retry

error:
        hlt
        jmp end

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

