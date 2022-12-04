with HAL; use HAL;

procedure part_2 is

    input_file : File_Type;
    --file_name : VString := +"./input_simplified.txt";
    file_name : VString := +"./input.txt";
    --Input : constant String (1 .. 3) := "ABC";
    Line_temp : VString;
    Overlap_temp : Boolean := False;
    Overlapping_total : Integer := 0;

    function Check_Partially_Overlapping_Sections (This : VString) return Boolean;

    function Check_Partially_Overlapping_Sections (This : VString) return Boolean is
        Overlapping : Boolean := False;
        S1 : VString;
        S2 : VString;
        Temp_Index : Integer := 0;
        Temp_Length : Integer := 0;
        R1, R2, R3, R4 : Integer := 0;
    begin
        Temp_Index := Index(This, +",");
        Temp_Length := Length(This);
        --Put_Line(Integer'Image(Temp_Index) & Integer'Image(Temp_Length));

        S1 := Slice(This, 1, Temp_Index - 1);
        S2 := Slice(This, Temp_Index + 1, Temp_Length);

        Temp_Index := Index(S1, +"-");
        Temp_Length := Length(S1);

        R1 := Integer'Value(To_String(Slice(S1, 1, Temp_Index - 1)));
        R2 := Integer'Value(To_String(Slice(S1, Temp_Index + 1, Temp_Length)));

        Temp_Index := Index(S2, +"-");
        Temp_Length := Length(S2);

        R3 := Integer'Value(To_String(Slice(S2, 1, Temp_Index - 1)));
        R4 := Integer'Value(To_String(Slice(S2, Temp_Index + 1, Temp_Length)));

        --Put_Line(S1 & " <> " & S2);
        --Put_Line(Integer'Image(R1) & " to " & Integer'Image(R2));
        --Put_Line(Integer'Image(R3) & " to " & Integer'Image(R4));

        --if ( ( R1 <= R3 or R2 >= R4 ) or ( R3 <= R1 or R4 >= R2 ) ) then
        if ( ( R1 >= R3 and R1 <= R4 ) or ( R2 >= R3 and R2 <= R4 ) or ( R3 >= R1 and R3 <= R2 ) or ( R4 >= R1 and R4 <= R2 ) ) then
            Overlapping := True;
        end if;

        --Put_Line("-------------------");

        return Overlapping;
    end Check_Partially_Overlapping_Sections;

begin

    Put_Line("Solving day 4 with HAC !");

    Open(input_file, file_name);

    loop
        exit when end_of_file(input_file);

        Get_Line(input_file, Line_temp);
        --Put_Line(Line_temp);

        Overlap_temp := Check_Partially_Overlapping_Sections(Line_temp);
        --Put_Line(Boolean'Image(Overlap_temp));

        if Overlap_temp then
            Overlapping_total := Overlapping_total + 1;
        end if;

    end loop;

    Put_Line("Total Overlapping pairs : " & Integer'Image(Overlapping_total) );
    Close(input_file);

end part_2;