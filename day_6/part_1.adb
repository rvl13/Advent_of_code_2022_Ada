with HAL; use HAL;

procedure part_1 is

    input_file : File_Type;
    --file_name : VString := +"./input_simplified.txt";
    file_name : VString := +"./input.txt";
    
    Line_Temp : VString;
    --Slice_Temp : VString;
    Absolute_Position : Integer;
    Line_Length : Integer := 0;
    Temp_Marker : VString := +"";
    Char_Temp : Character := '0';
    Index_Temp : Integer := 0;
    Marker_End : Integer := 0;
    Unique_Marker_Length : constant Natural := 4;


begin

    Put_Line("Solving day 6 puzzle with HAC !");

    Open(input_file, file_name);

    Get_Line(input_file, Line_Temp);
    Line_Length := Length(Line_Temp);
    --Put_Line(Integer'Image(Line_Length));
    --Slice_Temp := Slice(Line_Temp, 1, Line_Length);

    for I in 1 .. Line_Length loop
        Char_Temp := Element(Line_Temp, I);

        Index_Temp := Index(Temp_Marker, Char_Temp);

        --Put_Line( "Element : " & Integer'Image(I) & " , Char " & Char_Temp & " , temp index " & Integer'Image(Index_Temp));

        if Index_Temp /= 0 then
            Temp_Marker := Slice(Temp_Marker, Index_Temp + 1, Length(Temp_Marker));
            Temp_Marker := Temp_Marker & Char_Temp;
        else
            Temp_Marker := Temp_Marker & Char_Temp;
        end if;

        --Put_Line(" Marker : " & Temp_Marker);

        if Length(Temp_Marker) = Unique_Marker_Length then
            Marker_End := I;
            exit;
        end if;

    end loop;

    Put_Line(Temp_Marker);
    Put_Line(Integer'Image(Marker_End));

    Close(input_file);

end part_1;