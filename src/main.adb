pragma SPARK_Mode (On);

with aeroplane; use aeroplane;

procedure Main is

begin
   init;

   read_altitude;
   read_pitch;
   print_status;

end Main;
