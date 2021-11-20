pragma SPARK_Mode (On);

with AS_Io_Wrapper; use AS_Io_Wrapper;

package body aeroplane is

   procedure read_altitude is
      altitude : Integer;
   begin

      AS_Put_Line ("Please type in current altitude as read by sensors");

      loop
         AS_Get (altitude, "Please type in an integer");
         exit when (altitude >= 0) and (altitude <= maximum_altitude);
         AS_Put ("Please type in a value between 0 and ");
         AS_Put (maximum_altitude);
         AS_Put_Line ("");
      end loop;

      system_status.altitude := altitude_range (altitude);

   end read_altitude;

   procedure read_pitch is
      pitch : Integer;
   begin

      AS_Put_Line ("Please type in current pitch angle as read by sensors");

      loop
         AS_Get (pitch, "Please type in an integer");
         exit when (pitch >= 0) and (pitch <= maximum_pitch);
         AS_Put ("Please type in a value between 0 and ");
         AS_Put (maximum_pitch);
         AS_Put_Line ("");
      end loop;

      system_status.pitch := pitch_range (pitch);

   end read_pitch;

   function landing_gear_status_to_string
     (landing_gear_status : landing_gear_status_type) return String
   is
   begin

      if (landing_gear_status = Activated) then
         return "Activated";
      else
         return "Not_Activated";
      end if;
   end landing_gear_status_to_string;

   function flight_status_to_string
     (flight_status : flight_status_type) return String
   is
   begin

      if (flight_status = Ascending) then
         return "Ascending";
      elsif (flight_status = Descending) then
         return "Descending";
      else
         return "Landed";
      end if;

   end flight_status_to_string;

   procedure print_status is
   begin
      AS_Put("Altitude = ");
      AS_Put(Integer(system_status.altitude));
      AS_Put_Line("");
      AS_Put("Pitch = ");
      AS_Put(Integer(system_status.pitch));
   end print_status;

   function is_safe (status : system_status_type) return Boolean is
   begin
      return True;
   end is_safe;

   --procedure monitor_landing_gear is
   --begin
   --end monitor_landing_gear;

   --procedure monitor_flight_status is
   --begin
   --end monitor_flight_status;

   procedure init is
   begin
      AS_Init_Standard_Input;
      AS_Init_Standard_Output;

      system_status :=
        (altitude      => 0, pitch => 0, landing_gear_status => Activated,
         flight_status => Landed);

   end init;

end aeroplane;