#!/tcl

mol new [glob *psf]

for {set i 31} {$i <= 45 } {incr i} {
    mol addfile step.$i\_equilibration.dcd waitfor -1
}
