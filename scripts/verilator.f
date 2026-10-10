--binary

--sv

-Wall
-Wno-fatal

// Multithreading
-j 0

// SVA
--assert

// Dump as FST
--trace-fst
// Dump structs in human-readable format
--trace-structs

// Unknown values are randomized
--x-assign unique
// Variables are randomly initialized 
--x-initial unique

// File extensions to search for
+libext+.sv+.svh
