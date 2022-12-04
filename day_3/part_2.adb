with Ada.Text_IO; use Ada.Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure part_2 is

    input_file : File_Type;
    --file_name : String := "./input_simplified.txt";
    file_name : String := "./input.txt";
    --file_exists : boolean := false;
    --Line_temp : Unbounded_String;
    --Length_temp : Integer;
    --Length_temp_half : Integer;
    --Compartment_1 : Unbounded_String;
    --Compartment_2 : Unbounded_String;
    Rucksack_1 : Unbounded_String;
    Rucksack_2 : Unbounded_String;
    Rucksack_3 : Unbounded_String;
    Item_temp : Character := '0';
    Priority_Temp : Integer := 0;
    Priority_Total : Integer := 0;

    function Get_Repeating_Item (R1 : Unbounded_String; R2 : Unbounded_String; R3 : Unbounded_String) return Character;

    function Get_Item_Priority (Item : Character) return Integer;

    function Get_Repeating_Item (R1 : Unbounded_String; R2 : Unbounded_String; R3 : Unbounded_String) return Character is
    begin
        for I in Positive range 1 .. Length(R1) loop
            for J in Positive range 1 .. Length(R2) loop
                for K in Positive range 1 .. Length(R3) loop
                    if Element(R1, I) = Element(R2, J) and Element(R1, I) = Element(R3, K) then
                        return Element(R1, I);
                    end if;
                end loop;
            end loop;
        end loop;
        return '0';
    end Get_Repeating_Item;

    function Get_Item_Priority (Item : Character) return Integer is
        ascii_position : Integer := 0;
        item_priority : Integer := 0;
    begin
        ascii_position := Character'Pos(Item);

        --item_priority := ascii_position;
        if ascii_position >= 65 and ascii_position <= 90 then
            item_priority := ascii_position - 38;
        elsif ascii_position >= 97 and ascii_position <= 122 then
            item_priority := ascii_position - 96;
        else
            item_priority := 0;
        end if;

        return item_priority;
    end Get_Item_Priority;



begin

    Open (File => input_file,
        Mode => In_File,
        Name => file_name);

    loop
        exit when end_of_file(input_file);

        --Line_temp := To_Unbounded_String(get_line(input_file));
        --Length_temp := Length(Line_temp);
        --Length_temp_half := Length_temp / 2;
        --Compartment_1 := Unbounded_Slice(Line_temp, 1, Length_temp_half);
        --Compartment_2 := Unbounded_Slice(Line_temp, Length_temp_half + 1, Length_temp);

        --Put_Line(To_String(Line_temp));
        --Put_Line(To_String(Compartment_1));
        --Put_Line(To_String(Compartment_2));
        --Put_Line(Integer'Image(Length(Line_temp)));

        Rucksack_1 := To_Unbounded_String(get_line(input_file));
        Rucksack_2 := To_Unbounded_String(get_line(input_file));
        Rucksack_3 := To_Unbounded_String(get_line(input_file));

        Item_temp := Get_Repeating_Item(Rucksack_1, Rucksack_2, Rucksack_3);
        --Put_Line(Character'Image(Item_temp));
        Priority_Temp := Get_Item_Priority(Item_temp);
        --Put_Line(Integer'Image(Get_Item_Priority(Item_temp)));

        Priority_Total := Priority_Total + Priority_Temp;

    end loop;

    Put_Line("Total Priority : " & Integer'Image(Priority_Total) );

end part_2;