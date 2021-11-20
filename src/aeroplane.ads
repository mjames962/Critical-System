pragma SPARK_Mode (On);

with AS_Io_Wrapper; use AS_Io_Wrapper;

package aeroplane is

   --maximum altitude of commercial aircraft is typically 42,000 feet
   maximum_altitude : constant Integer := 42_000;

   --lowest altitude allowed before needing landing gear
   minimum_altitude_before_landing : constant Integer := 500;

   --maximum pitch of 20 degrees
   maximum_pitch : constant Integer := 20;

   --minumum pitch for landing
   minimum_pitch_for_landing : constant Integer := 3;

   type altitude_range is new Integer range 0 .. maximum_altitude;

   type mid_flight_altitude_range is
     new Integer range minimum_altitude_before_landing .. maximum_altitude;

   type pitch_range is new Integer range 0 .. maximum_pitch;

   type mid_flight_pitch_range is
     new Integer range minimum_pitch_for_landing .. maximum_pitch;

   type landing_gear_status_type is (Activated, Not_Activated);

   type flight_status_type is (Ascending, Descending, Landed);

   type system_status_type is record
      altitude            : altitude_range;
      pitch               : pitch_range;
      landing_gear_status : landing_gear_status_type;
      flight_status       : flight_status_type;
   end record;

   system_status : system_status_type;

   procedure read_altitude;

   procedure read_pitch;

   function landing_gear_status_to_string
     (landing_gear_status : landing_gear_status_type) return String;

   function flight_status_to_string
     (flight_status : flight_status_type) return String;

   procedure print_status;

   function is_safe (status : system_status_type) return Boolean;

   --procedure monitor_landing_gear;

   --procedure monitor_flight_status;

   procedure init;

end aeroplane;
