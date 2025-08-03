**
.subckt inverter vin vout vdd vss
.include C:\Spice64\examples\soi\bsim4soi\nmos4p0.mod 
.include C:\Spice64\examples\soi\bsim4soi\pmos4p0.mod  
MP0 vout vin vdd vdd P1 W=4.5u L=0.18u 
MN0 vout vin vss vss N1 W=2.5u L=0.18u 
.ends inverter