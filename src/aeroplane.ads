pragma SPARK_Mode (On);

with SPARK.Text_IO, AS_Io_Wrapper;
use SPARK.Text_IO, AS_Io_Wrapper;

package aeroplane is

   --maximum altitude of commercial aircraft is typically 42,000 feet
   maximum_altitude : constant Integer := 42_000;

   --lowest altitude allowed before needing landing gear
   minimum_altitude_before_landing : constant Integer := 500;

   --maximum pitch of 20 degrees
   maximum_pitch : constant Integer := 20;

   --minumum pitch for landing
   pitch_for_landing : constant Integer := 3;

   type altitude_range is new Integer range 0 .. maximum_altitude;

   type mid_flight_altitude_range is
     new Integer range minimum_altitude_before_landing .. maximum_altitude;

   type pitch_range is new Integer range 0 .. maximum_pitch;

   type mid_flight_pitch_range is
     new Integer range pitch_for_landing .. maximum_pitch;

   type landing_gear_status_type is (Activated, Not_Activated);

   type flight_status_type is (Ascending, Descending, Landed, Invalid_Flight_Angle);

   type system_status_type is record
      altitude            : altitude_range;
      pitch               : pitch_range;
      landing_gear_status : landing_gear_status_type;
      flight_status       : flight_status_type;
   end record;

   system_status : system_status_type;

   procedure read_altitude with
      Global  => (In_Out => (Standard_Output, Standard_Input, system_status)),
      Depends => (Standard_Output => (Standard_Output, Standard_Input),
       Standard_Input => Standard_Input,
       system_status  => (system_status, Standard_Input)),
      Post =>
      (Integer (system_status.altitude) >= 0 and
       Integer (system_status.altitude) <= maximum_altitude);

   procedure read_pitch with
      Global  => (In_Out => (Standard_Output, Standard_Input, system_status)),
      Depends => (Standard_Output => (Standard_Output, Standard_Input),
       Standard_Input => Standard_Input,
       system_status  => (system_status, Standard_Input)),
      Post =>
      (Integer (system_status.pitch) >= 0 and
       Integer (system_status.pitch) <= maximum_pitch);

   function landing_gear_status_to_string
     (landing_gear_status : landing_gear_status_type) return String;

   function flight_status_to_string
     (flight_status : flight_status_type) return String;

   procedure print_status with
      Global  => (In_Out => Standard_Output, Input => system_status),
      Depends => (Standard_Output => (Standard_Output, system_status));

   function safe_flight_status
     (input_status : system_status_type) return Boolean is
     (if
        Integer (input_status.altitude) = 0 and
        Integer (input_status.pitch) = 0 and
        input_status.landing_gear_status = Activated
      then input_status.flight_status = Landed
      elsif
        (Integer (input_status.altitude) > 0 and
         Integer (input_status.pitch) > pitch_for_landing)
      then input_status.flight_status = Ascending
      elsif
        (Integer (input_status.altitude) > 0 and
         Integer (input_status.pitch) = pitch_for_landing)
      then input_status.flight_status = Descending
      elsif
        (Integer (input_status.altitude) > 0 and
         Integer (input_status.pitch) < pitch_for_landing)
      then input_status.flight_status = Invalid_Flight_Angle
      else input_status.flight_status = Invalid_Flight_Angle);

   function safe_landing_gear
     (input_status : system_status_type) return Boolean is
     (if
        Integer (input_status.altitude) < minimum_altitude_before_landing and
        (input_status.flight_status = Ascending or
         input_status.flight_status = Descending or
         input_status.flight_status = Invalid_Flight_Angle)
      then input_status.landing_gear_status = Activated
      elsif
        Integer (input_status.altitude) = 0 and
        input_status.flight_status = Landed
      then input_status.landing_gear_status = Activated
      else input_status.landing_gear_status = Not_Activated);

   procedure monitor_system with
      Global  => (In_Out => system_status),
      Depends => (system_status => system_status),
      Post    =>
      (safe_landing_gear (system_status) and
       safe_flight_status (system_status));

   procedure init with
      Global  => (Output => (Standard_Output, Standard_Input, system_status)),
      Depends => ((Standard_Output, Standard_Input, system_status) => null),
      Post    =>
      (safe_landing_gear (system_status) and
       safe_flight_status (system_status));

end aeroplane;
