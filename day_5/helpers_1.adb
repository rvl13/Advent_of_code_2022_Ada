package body helpers_1 is

    function Get_Seperator_Line_Number(fname : VString) return Integer is
        input_file : File_Type;
        Pos_Temp : Integer := 0;
        Line : VString;
        Seperator_Line : Integer := 0;
    begin
        Open(input_file, fname);

        loop
            exit when end_of_file(input_file);
            
            Get_Line(input_file, Line);
            Pos_Temp := Pos_Temp + 1;
            
            if Line = "" then
                --return Pos_Temp;
                Seperator_Line := Pos_Temp;
                exit;
            end if;

        end loop;

        Close(input_file);

        return Seperator_Line;
    end Get_Seperator_Line_Number;



    function Get_Stacks_Count(fname : VString; seperator_line_no : Integer) return Integer is
        input_file : File_Type;
        Line : VString;
        Last_Stack_index : Integer := 0;
        Line_Length : Integer := 0;
        Line_number : Integer := 0;
    begin
        Open(input_file, fname);


        loop
            exit when end_of_file(input_file);

            Get_Line(input_file, Line);
            Line_number := Line_number + 1;

            if (Line_number = (seperator_line_no - 1)) then
                Line_Length := Length(Line);
                Last_Stack_index := Integer'Value(To_String(Slice(Line, Line_Length - 1, Line_Length)));    -- minus 1 assuming it is a one digit number
                exit;
            end if;

        end loop;

        Close(input_file);

        return Last_Stack_index;

    end Get_Stacks_Count;



    function Get_Crates_Count(fname : VString; seperator_line_no : Integer) return Integer is
        input_file : File_Type;
        Line_Temp : VString;
        Line_Number : Integer := 0;
        Line_Length : Integer := 0;
        Total_Crates : Integer := 0;
        Chr : Character := '0';
    begin
        Open(input_file, fname);


        loop
            exit when end_of_file(input_file);

            Get_Line(input_file, Line_Temp);
            Line_number := Line_number + 1;
            Line_Length := Length(Line_Temp);

            if (Line_number = (seperator_line_no - 1)) then
                exit;
            end if;

            for I in 1 .. Line_Length loop
                Chr := Element(Line_Temp, I);

                if (Chr = '[') then
                    Total_Crates := Total_Crates + 1;
                end if;

            end loop;

        end loop;

        Close(input_file);

        return Total_Crates;

    end Get_Crates_Count;


    procedure Fill_Matrix(fname : in VString; Mat : in out Stacks; seperator_line_no : Integer; Stacks_Count : Integer; Crates_Count : Integer) is
        Offset_Initial : constant Natural := 2;
        Offset_Stack_Width : constant Natural := 4;
        input_file : File_Type;
        Line_Temp : VString;
        Line_Number : Integer := 0;
        Line_Length : Integer := 0;
        Char_Temp : Character := '0';
        Char_Temp_2 : Character := '0';
        Offset_Temp : Natural := 0;
    begin
        Open(input_file, fname);

        for L in 1 .. seperator_line_no - 2 loop
            Get_Line(input_file, Line_Temp);

            for I in 1 .. Stacks_Count loop
                Offset_Temp := Offset_Initial + (I - 1) * Offset_Stack_Width;
                Char_Temp := Element(Line_Temp, Offset_Temp);

                if Char_Temp in 'A' .. 'Z' then
                    Push(Mat(I), Char_Temp);
                end if;

            end loop;

        end loop;

        Close(input_file);
    end Fill_Matrix;


    procedure Reverse_Crates (Mat : in out Stacks; Stacks_Count : Integer) is
        Current_Index : Integer;
        Mirror_Index : Integer;
        Middle_Index : Integer;
        Crates : Integer;
        Char_Temp : Character := '0';
    begin
        for I in 1 .. Stacks_Count loop
            Crates := Mat(I).Top_Index;

            if (Crates mod 2 = 0) then
                Middle_Index := Crates / 2;
            else
                Middle_Index := (Crates + 1) / 2;
            end if;

            for J in 1 .. Middle_Index loop
                Current_Index := J;
                Mirror_Index := (Crates + 1) - Current_Index;
                Char_Temp := Mat(I).Crate_Stack(Current_Index);
                Mat(I).Crate_Stack(Current_Index) := Mat(I).Crate_Stack(Mirror_Index);
                Mat(I).Crate_Stack(Mirror_Index) := Char_Temp;
            end loop;
            
        end loop;

    end Reverse_Crates;



    procedure Manipulate_Stacks(fname : VString; Mat : in out Stacks; seperator_line_no : Integer; Stacks_Count : Integer; Crates_Count : Integer; puzzle_no : Integer) is
        input_file : File_Type;
        Line_Temp : VString;
        Slice_Temp : VString;
        Slice_Temp_2 : VString;
        Line_Number : Integer := 0;
        Line_Length : Integer := 0;
        Start_Index : Integer := 0;
        Stop_Index : Integer := 0;
        Count_Temp : Integer := 0;
        Src_Temp : Integer := 0;
        Dst_Temp : Integer := 0;
    begin
        Open(input_file, fname);

        loop
            exit when end_of_file(input_file);            

            Get_Line(input_file, Line_Temp);
            Line_Number := Line_Number + 1;
            Line_Length := Length(Line_Temp);
            Start_Index := 0;
            Stop_Index := 0;

            if (Line_Number > seperator_line_no) then
                Slice_Temp := Slice(Line_Temp, 1, Length(Line_Temp));
                Start_Index := Index(Slice_Temp, +" ");
                Slice_Temp_2 := Slice(Slice_Temp, Start_Index + 1, Length(Slice_Temp));
                Stop_Index := Index(Slice_Temp_2, +" ") + Start_Index;

                --Put_Line("Count " & Integer'Image (Start_Index));
                --Put_Line("Count " & Integer'Image (Stop_Index));

                Count_Temp := Integer'Value(To_String(Slice(Slice_Temp, Start_Index + 1, Stop_Index - 1)));

                Slice_Temp := Slice(Slice_Temp, Stop_Index + 1, Length(Slice_Temp));
                Start_Index := Index(Slice_Temp, +" ");
                Slice_Temp_2 := Slice(Slice_Temp, Start_Index + 1, Length(Slice_Temp));
                Stop_Index := Index(Slice_Temp_2, +" ") + Start_Index;

                Src_Temp := Integer'Value(To_String(Slice(Slice_Temp, Start_Index + 1, Stop_Index - 1)));

                Slice_Temp := Slice(Slice_Temp, Stop_Index + 1, Length(Slice_Temp));
                Start_Index := Index(Slice_Temp, +" ");
                --Slice_Temp_2 := Slice(Slice_Temp, Start_Index + 1, Length(Slice_Temp));
                --Stop_Index := Index(Slice_Temp_2, +" ") + Start_Index;

                Dst_Temp := Integer'Value(To_String(Slice(Slice_Temp, Start_Index + 1, Length(Slice_Temp))));

                --Put_Line("Count " & Integer'Image (Count_Temp) & ", Src " & Integer'Image(Src_Temp) & ", Dst " & Integer'Image(Dst_Temp));

                if puzzle_no = 1 then
                    Move_Crates(Mat, Count_Temp, Src_Temp, Dst_Temp);
                else
                    Move_Crates_2(Mat, Count_Temp, Src_Temp, Dst_Temp);
                end if;

            end if;
            

        end loop;


        Close(input_file);

    end Manipulate_Stacks;



    procedure Move_Crates (Mat : in out Stacks; Count : Integer; Src : Integer; Dst : Integer) is
        Crate_Temp : Character;
    begin
        for I in 1 .. Count loop
            Pop(Mat(Src), Crate_Temp);
            Push(Mat(Dst), Crate_Temp);
        end loop;
    end Move_Crates;


    procedure Move_Crates_2 (Mat : in out Stacks; Count : Integer; Src : Integer; Dst : Integer) is
        -- Since it is elves, we can expect a bit magic !
        Invisible_Stack : Stack;
        Crate_Temp : Character;
    begin
        Invisible_Stack.Top_Index := 0;
        
        for K in Crates_Range loop
            Invisible_Stack.Crate_Stack(K) := '0';
        end loop;

        for I in 1 .. Count loop
            Pop(Mat(Src), Crate_Temp);
            Push(Invisible_Stack, Crate_Temp);
        end loop;

        for I in 1 .. Count loop
            Pop(Invisible_Stack, Crate_Temp);
            Push(Mat(Dst), Crate_Temp);
        end loop;
        
    end Move_Crates_2;


end helpers_1;
