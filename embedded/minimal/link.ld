/*Ending Stack Pointer position (the end of the SRAM).*/
_estack = ORIGIN(RAM) + LENGTH(RAM);

/*Flash and SRAM origin and length.*/
MEMORY {
    FLASH ( rx )      : ORIGIN = 0x08000000, LENGTH = 96K
    RAM ( rxw )       : ORIGIN = 0x20000000, LENGTH = 512K
}