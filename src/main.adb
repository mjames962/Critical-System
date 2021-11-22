pragma SPARK_Mode (On);

with aeroplane; use aeroplane;

procedure Main is

begin
   init;

   loop
      pragma Loop_Invariant
        (safe_landing_gear (system_status) and
         safe_flight_status (system_status));

      read_altitude;
      read_pitch;
      monitor_landing_gear;
      monitor_flight_status;

      print_status;
   end loop;

end Main;
