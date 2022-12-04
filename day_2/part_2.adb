-- A for Rock, B for Paper, and C for Scissors
-- X for lose, Y for draw, and Z for win

-- So, we will make your choice as :
-- P for Rock, Q for Paper, and R for Scissors

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure part_2 is

    type one_D_array is array (Character range <>) of Integer;
    type two_D_array is array (Character range <>, Character range <>) of Integer;

    Selection_Points : one_D_array(Character range 'P' .. 'R') := (1, 2, 3);

    Round_Result_Points : two_D_array(Character range 'A' .. 'C', Character range 'P' .. 'R') := 
    ((3, 6, 0),
     (0, 3, 6),
     (6, 0, 3)
    );

    Result_point_mapping : one_D_array(Character range 'X' .. 'Z') := (0, 3, 6);
    
    input_file : File_Type;
    --file_name : String := "./input_simplified.txt";
    file_name : String := "./input.txt";
    --file_exists : boolean := false;
    line_temp : Unbounded_String;

    Final_Score : Integer := 0;
    Opponent_choice : Character := '0';
    --Your_Choice : Character := '0';
    Current_Round_Result : Character := '0';

    function Get_Your_Move (Opponent_move : Character; Result : Character) return Character;

    function Get_Your_Move (Opponent_move : Character; Result : Character) return Character is
        Your_move : Character := 'P';
    begin
        for move in Character range Round_Result_Points'First(2) .. Round_Result_Points'Last(2) loop
            if Result_point_mapping(Result) = Round_Result_Points(Opponent_move, move) then
                Your_move := move;
                exit;
            end if;
        end loop;
        --return Result_point_mapping'Pos(Result);
        --return one_D_array'Pos(Result);
        return Your_move;
    end Get_Your_Move;

    function Get_Current_Round_totals(Opponent_move : Character; Result : Character) return Integer;
    
    function Get_Current_Round_totals(Opponent_move : Character; Result : Character) return Integer is
        Total_Score : Integer := 0; 
        Your_move : Character := Get_Your_Move(Opponent_move, Result);
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
        --Your_Choice := To_String(line_temp)(3);
        Current_Round_Result := To_String(line_temp)(3);
        
        Final_Score := Final_Score + Get_Current_Round_totals(Opponent_choice, Current_Round_Result);

    end loop;

    Put_Line("Your final score (as per strategy) : " & Integer'Image(Final_Score));

end part_2;