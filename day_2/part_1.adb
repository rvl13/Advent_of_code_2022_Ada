-- A for Rock, B for Paper, and C for Scissors
-- X for Rock, Y for Paper, and Z for Scissors

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure part_1 is

    type one_D_array is array (Character range <>) of Integer;
    type two_D_array is array (Character range <>, Character range <>) of Integer;

    Selection_Points : one_D_array(Character range 'X' .. 'Z') := (1, 2, 3);

    Round_Result_Points : two_D_array(Character range 'A' .. 'C', Character range 'X' .. 'Z') := 
    ((3, 6, 0),
     (0, 3, 6),
     (6, 0, 3)
    );
    
    input_file : File_Type;
    --file_name : String := "./input_simplified.txt";
    file_name : String := "./input.txt";
    --file_exists : boolean := false;
    line_temp : Unbounded_String;

    Final_Score : Integer := 0;
    Opponent_choice : Character := '0';
    Your_Choice : Character := '0';

    function Get_Current_Round_totals(Opponent_move : Character; Your_move : Character) return Integer;
    
    function Get_Current_Round_totals(Opponent_move : Character; Your_move : Character) return Integer is
        Total_Score : Integer := 0; 
    begin
        Total_Score := Selection_Points(Your_move) + Round_Result_Points(Opponent_move, Your_move);

        return Total_Score;
    end Get_Current_Round_totals;

begin

    Open (File => input_file,
        Mode => In_File,
        Name => file_name);

    loop
        exit when end_of_file(input_file);

        line_temp := To_Unbounded_String(get_line(input_file));
        --Put_Line(To_String(line_temp));

        --Put_Line(Character'Image(To_String(line_temp)(1)));
        --Put_Line(Character'Image(To_String(line_temp)(3)));

        Opponent_choice := To_String(line_temp)(1);
        Your_Choice := To_String(line_temp)(3);
        
        Final_Score := Final_Score + Get_Current_Round_totals(Opponent_choice, Your_Choice);

    end loop;

    Put_Line("Your final score (as per strategy) : " & Integer'Image(Final_Score));

end part_1;