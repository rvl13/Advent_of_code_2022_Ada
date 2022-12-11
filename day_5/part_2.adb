with HAL; use HAL;
with helpers_1; use helpers_1;
with common_1; use common_1;

procedure part_2 is

    input_file : File_Type;
    --file_name : VString := +"./input_simplified.txt";
    file_name : VString := +"./input.txt";
    puzzle_number : Integer := 2;

    -- assumption : the stacks count is less than 10 (one digit number)
    Seperator_Line_Number : constant Integer := Get_Seperator_Line_Number(file_name);
    Stacks_Count : constant Integer := Get_Stacks_Count(file_name, Seperator_Line_Number);
    Crates_Count : constant Integer := Get_Crates_Count(file_name, Seperator_Line_Number);

    --type Crates_Range is Positive range 1 .. Crates_Count;    -- This is not possible
    --type Stacks_Range is Positive range 1 .. Stacks_Count;    -- This is not possible

    Matrix : Stacks;
    Char_Temp : Character;
    Integer_Temp : Integer;
    Stacks_Top : VString := +"";



begin

    Put_Line(Integer'Image(Seperator_Line_Number));
    Put_Line(Integer'Image(Stacks_Count));
    Put_Line(Integer'Image(Crates_Count));

    Init_Matrix(Matrix);
    Fill_Matrix(file_name, Matrix, Seperator_Line_Number, Stacks_Count, Crates_Count);
    Reverse_Crates (Matrix, Stacks_Count);

    Manipulate_Stacks(file_name, Matrix, Seperator_Line_Number, Stacks_Count, Crates_Count, puzzle_number);

    for I in 1 .. Stacks_Count loop
        Char_Temp := Copy(Matrix(I));
        Stacks_Top := Stacks_Top & Char_Temp;
    end loop;

    Put_Line(Stacks_Top);

end part_2;