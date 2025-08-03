*
.include C:\Spice64\examples\soi\bsim4soi\nmos4p0.mod 
.include C:\Spice64\examples\soi\bsim4soi\pmos4p0.mod
.include "C:\Spice64\bin\subckts.sp"

Vpower vdd 0 1 
vgnd vss 0 0
Vgate D vss pulse(0 1 1.5n 50p 50p 1n 2n)
*Vgate D 0 1
*Vgate1 clk 0 0
Vgate1 clk vss pulse(0 1 1n 50p 50p 0.5n 1n) 
.param wid=0.29u
C1 Q 0 5f
*********Db input************
MP9 Db D vdd vdd P1 W='7*wid' L=0.18u 
MN11 Db D vss vss N1 W='4*wid' L=0.18u 

MP0 n1 clk vdd vdd P1 W='5*wid' L=0.18u

MP1 n1 n2 vdd vdd P1 W=2u L=0.18u 
MN1 n1 n2 n3 vss N1 W=2u L=0.18u 
MP2 n2 n1 vdd vdd P1 W=2u L=0.18u 
MN2 n2 n1 n4 vss N1 W=2u L=0.18u 

MP3 n2 clk vdd vdd P1 W='5*wid' L=0.18u 

MN3 n3 D n5 vss N1 W='3*wid' L=0.18u 
MN4 n4 Db n5 vss N1 W='3*wid' L=0.18u 
MN5 n5 clk vss vss N1 W='7*wid' L=0.18u 


*********Diffrential Q output************
MP4 Q n1 vdd vdd P1 W='3.5*wid' L=0.18u 
MP5 Q Qb vdd vdd P1 W='3.5*wid' L=0.18u
MN6 net_n n1 vss vss N1 W='2.5*wid' L=0.18u 
MN7 Q Qb net_n vss N1 W='2.5*wid' L=0.18u 
***inverter
MP8 DE Q vdd vdd P1 W='1.5*wid' L=0.18u 
MN10 DE Q vss vss N1 W='1*wid' L=0.18u 

*********single ended Qb output************
MP6 Qb n2 vdd vdd P1 W='3*wid' L=0.18u 
MP7 Qb Q vdd vdd P1 W='3*wid' L=0.18u
MN8 net_1n Q vss vss N1 W='1.5*wid' L=0.18u 
MN9 Qb n2 net_1n vss N1 W='1.5*wid' L=0.18u 


.tran 10p 13n
.control
run
plot v(D) v(Q) v(clk)
meas tran totalpower AVG i(Vpower) from=1.5n to=12n
meas tran D_clk_set TRIG v(D) val=0.5 RISE=1 TARG v(clk) val=0.5 RISE=2
meas tran clk_q TRIG v(clk) val=0.5 RISE=2 TARG v(Q) val=0.5 RISE=1
meas tran D_Q TRIG v(D) val=0.5 RISE=1 TARG v(Q) val=0.5 RISE=1

meas tran D_clk_set TRIG v(D) val=0.5 FALL=1 TARG v(clk) val=0.5 RISE=3
meas tran clk_q TRIG v(clk) val=0.5 RISE=3 TARG v(Q) val=0.5 FALL=2
meas tran D_Q TRIG v(D) val=0.5 FALL=1 TARG v(Q) val=0.5 FALL=2
.endc
.end