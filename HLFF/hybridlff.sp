**
.include C:\Spice64\examples\soi\bsim4soi\nmos4p0.mod 
.include C:\Spice64\examples\soi\bsim4soi\pmos4p0.mod
.include "C:\Spice64\bin\subckts.sp"

Vpower vdd 0 1 
vgnd vss 0 0
Vgate D vss pulse(0 1 1.929n 50p 50p 1n 2n)
*Vgate D 0 0
*Vgate1 clk 0 1
Vgate1 clk vss pulse(0 1 1n 50p 50p 0.5n 1n) 

c1 Qb 0 5f
.PARAM WID=0.8u
MP9 Db D vdd vdd P1 W=10u L=0.18u  
MN11 Db D vss vss N1 W=8u L=0.18u 

****INVERTED CLK DELAY GENERATION*****
xa clk clkd1 vdd vss inverter
xb clkd1 clkd2 vdd vss inverter
xc clkd2 clkb vdd vss inverter

*********dicharge and charge transistoR*********
MP0 n1 clk vdd vdd P1 W='7.5*WID' L=0.18u 
MN1 n1 clk n2 vss N1 W='5.5*WID' L=0.18u  	
MN2 n2 Db n3 vss N1 W='4.5*WID' L=0.18u 
MN3 n3 clkb vss vss N1 W='5.5*WID' L=0.18u 

MP2 n1 Db vdd vdd P1 W='3*WID' L=0.18u

MP3 n1 clkb vdd vdd P1 W='2*WID' L=0.18u

MP1 Q n1 vdd vdd P1 W='5.5*WID' L=0.18u 
MN4 Q clk n5 vss N1 W='3.5*WID' L=0.18u 
MN5 n5 n1 n6 vss N1 W='3.5*WID' L=0.18u 
MN6 n6 clkb vss vss N1 W='3.5*WID' L=0.18u 

*******keeper circuit********
MP4 out1 Q vdd vdd P1 W=2u L=0.18u  
MN7 out1 Q vss vss N1 W=1u L=0.18u 

MP6 net3 clkb vdd vdd P1 W=2u L=0.18u
MP7 Q out1 net3 vdd P1 W=2u L=0.18u  
MN8 Q out1 net4 vss N1 W=1u L=0.18u   
MN9 net4 clk vss vss N1 W=1u L=0.18u

****inverter at output side****
MP8 Qb Q vdd vdd P1 W='1.5*WID' L=0.18u  
MN10 Qb Q vss vss N1 W='1.5*WID'L=0.18u 

****transient analysis****
.tran 10p 12n
.control
run
plot v(D) v(Qb) v(clk)
*plot v(clkb) v(clk)
meas tran totalpower AVG i(Vpower) from=1.5n to=11n
meas tran D_clk_set TRIG v(D) val=0.5 RISE=1 TARG v(clk) val=0.5 RISE=2
meas tran clk_q TRIG v(clk) val=0.5 RISE=2 TARG v(Qb) val=0.5 RISE=1
meas tran D_Q TRIG v(D) val=0.5 RISE=1 TARG v(Qb) val=0.5 RISE=1

meas tran D_clk_set TRIG v(D) val=0.5 FALL=1 TARG v(clk) val=0.5 RISE=3
meas tran clk_q TRIG v(clk) val=0.5 RISE=3 TARG v(Qb) val=0.5 FALL=1
meas tran D_Q TRIG v(D) val=0.5 FALL=1 TARG v(Qb) val=0.5 FALL=1

.endc
.end