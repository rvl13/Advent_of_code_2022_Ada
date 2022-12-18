with HAL; use HAL;

procedure part_2 is

    Input_File : File_Type;
    --File_Name : VString := +"./input_simplified.txt";
    File_Name : VString := +"./input.txt";
    --Puzzle_Number : Integer := 1;

    Max_Height : constant := 9;
    Max_Rows : constant := 120;
    Max_Columns : constant := 120;

    type row_range is Integer range 1 .. Max_Rows;
    type column_range is Integer range 1 .. Max_Columns;
    type height_range is Integer range 0 .. Max_Height;

    type two_D_array is array (row_range, column_range) of height_range;

    function Get_Rows_Count (Fname : VString) return Integer;

    function Get_Columns_Count (Fname : VString) return Integer;

    procedure Initialize_Grid (Grid : out two_D_array);

    --procedure Fill_Grid(Fname : in VString; Grid : out two_D_array; Rows : in Positive; Columns : in Positive);
    procedure Fill_Grid(Fname : in VString; Grid : out two_D_array);

    function Get_Highest_Scenic_Score (Grid : two_D_array; Rows : Positive; Columns : Positive) return Natural;

    Rows_Count : Positive := Get_Rows_Count(File_Name);
    Columns_Count : Positive := Get_Columns_Count(File_Name);

    Tree_Grid : two_D_array;
    
    function Get_Rows_Count (Fname : VString) return Integer is
        Line_Count : Natural := 0;
        Input_File : File_Type;
        Line_Temp : VString;
    begin
        Open(Input_File, Fname);

        loop
            exit when end_of_file(Input_File);
            
            Get_Line(Input_File, Line_Temp);
            Line_Count := Line_Count + 1;

        end loop;

        Close(Input_File);

        return Line_Count;

    end Get_Rows_Count;


    function Get_Columns_Count (Fname : VString) return Integer is
        Character_Count : Natural := 0;
        Input_File : File_Type;
        Line_Temp : VString;
    begin
        Open(Input_File, Fname);
        
        exit when end_of_file(Input_File);
        
        Get_Line(Input_File, Line_Temp);
        Character_Count := Length(Line_Temp);

        Close(Input_File);

        return Character_Count;

    end Get_Columns_Count;

    procedure Initialize_Grid (Grid : out two_D_array) is
    begin
        for I in 1 .. Grid'Length(1) loop

            for J in 1 .. Grid'Length(2) loop
                Grid(I, J) := 0;
            end loop;

        end loop;
    end Initialize_Grid;


    procedure Fill_Grid(Fname : in VString; Grid : out two_D_array) is
        Input_File : File_Type;
        Line_Temp : VString;
        Char_Temp : Character := '0';
        Current_Row : Natural := 0;
        --Current_Column : Natural := 0; 
    begin
        Open(Input_File, Fname);

        loop
            exit when end_of_file(Input_File);
            
            Get_Line(Input_File, Line_Temp);
            Current_Row := Current_Row + 1;
            --Current_Column := Current_Column + 1;

            for J in 1 .. Length(Line_Temp) loop
                --Char_Temp := Element(Line_Temp, J);
                --Grid(Current_Row, J) := Integer'Value(Char_Temp);
                --Grid(Current_Row, J) := Integer'Value(To_VString(Char_Temp));

                Grid(Current_Row, J) := Integer'Value(To_String(Slice(Line_Temp, J, J)));
            end loop;

        end loop;

        Close(Input_File);

    end Fill_Grid;


    function Get_Highest_Scenic_Score (Grid : two_D_array; Rows : Positive; Columns : Positive) return Natural is
        View_Up : Natural;
        View_Down : Natural;
        View_Left : Natural;
        View_Right : Natural;
        Scenic_Score : Natural;
        Max_Scenic_Score : Natural := 0;
    begin

        sweep_rows :
        for I in 2 .. Rows - 1 loop

            sweep_columns :
            for J in 2 .. Columns - 1 loop

                View_Up := 1;
                View_Down := 1;
                View_Left := 1;
                View_Right := 1;

                look_up :
                for P in reverse 2 .. (I - 1) loop
                    if Grid(P, J) >= Grid(I, J) then
                        exit;
                    else
                        View_Up := View_Up + 1;
                    end if;
                end loop look_up;

                look_down :
                for Q in (I + 1) .. Rows - 1 loop
                    if Grid(Q, J) >= Grid(I, J) then
                        exit;
                    else
                        View_Down := View_Down + 1;
                    end if;
                end loop look_down;

                look_left :
                for R in reverse 2 .. (J - 1) loop
                    if Grid(I, R) >= Grid(I, J) then
                        exit;
                    else
                        View_Left := View_Left + 1;
                    end if;
                end loop look_left;

                look_right :
                for S in (J + 1) .. Columns - 1 loop
                    if Grid(I, S) >= Grid(I, J) then
                        exit;
                    else
                        View_Right := View_Right + 1;
                    end if;
                end loop look_right;

                --Visible_Overall := Visible_Up or Visible_Down or Visible_Left or Visible_Right;
                Scenic_Score := View_Up * View_Down * View_Left * View_Right;

                if Scenic_Score > Max_Scenic_Score then
                    Max_Scenic_Score := Scenic_Score;
                end if;

            end loop sweep_columns;

        end loop sweep_rows;

        return Max_Scenic_Score;

    end Get_Highest_Scenic_Score;


begin

    Put_Line("Solving day 8 puzzle with HAC !");

    --Put_Line(Integer'Image(Rows_Count));
    --Put_Line(Integer'Image(Columns_Count));

    Initialize_Grid(Tree_Grid);
    Fill_Grid(File_Name, Tree_Grid);

    --Put_Line(Integer'Image(Tree_Grid(2, 4)));
    --Put_Line(Integer'Image(Tree_Grid(7, 10)));

    Put_Line("Highest Scenic Score : " & Integer'Image(Get_Highest_Scenic_Score(Tree_Grid, Rows_Count, Columns_Count)));


end part_2;