pragma SPARK_Mode (On);

with aeroplane; use aeroplane;

procedure Main is

begin

   init;

   loop

      pragma Loop_Invariant
        (safe_flight_status (system_status) and
         safe_landing_gear (system_status));

      read_altitude;
      read_pitch;
      monitor_system;

      print_status;
   end loop;

end Main;
