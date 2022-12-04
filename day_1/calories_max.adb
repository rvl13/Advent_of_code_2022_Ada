with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure calories_max is

    input_file : File_Type;
    --file_name : String := "./input_simplified.txt";
    file_name : String := "./input.txt";
    file_exists : boolean := false;
    line_temp : Unbounded_String;
    
    Max_Calories : Integer := 0;
    Current_Calories : Integer := 0;
    Current_Sum : Integer := 0;
    Max_Calories_Index : Integer := 1;
    Current_Index : Integer := 1;

    procedure Set_Max(Calories : Integer; Index : Integer);

    procedure Set_Max(Calories : Integer; Index : Integer) is
    begin
        if Calories > Max_Calories then
            Max_Calories := Calories;
            Max_Calories_Index := Index;
        end if;
    end Set_Max;

begin

    --Put_Line(boolean'Image(file_exists));
    
    file_exists := exists(file_name);
    --Put_Line(boolean'Image(file_exists));

    Open (File => input_file,
        Mode => In_File,
        Name => file_name);

    loop
        if end_of_file(input_file) then
            Set_Max(Current_Sum, Current_Index);
        end if;
        
        exit when end_of_file(input_file);
        
        line_temp := To_Unbounded_String(get_line(input_file));
        --Put_Line(To_String(line_temp));
        
        if (To_String(line_temp) = "") then
            --Put_Line("This is the seperator");
            Set_Max(Current_Sum, Current_Index);
            Current_Sum := 0;
            Current_Calories := 0;
            Current_Index := Current_Index + 1;
        else
            --Put_Line(To_String(line_temp));
            --Put_Line(Integer'Image(Integer'Value(To_String(line_temp))));
            Current_Calories := Integer'Value(To_String(line_temp));
            Current_Sum := Current_Sum + Current_Calories;

        end if;

    end loop;

    Put_Line("Max Calories : " & Integer'Image(Max_Calories));
    Put_Line("At Index : " & Integer'Image(Max_Calories_Index));


end calories_max;