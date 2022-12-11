with HAL; use HAL;
with common_1; use common_1;

package helpers_1 is

    function Get_Seperator_Line_Number(fname : VString) return Integer;

    function Get_Stacks_Count(fname : VString; seperator_line_no : Integer) return Integer;

    function Get_Crates_Count(fname : VString; seperator_line_no : Integer) return Integer;

    procedure Fill_Matrix(fname : in VString; Mat : in out Stacks; seperator_line_no : Integer; Stacks_Count : Integer; Crates_Count : Integer);

    procedure Reverse_Crates (Mat : in out Stacks; Stacks_Count : Integer);

    procedure Manipulate_Stacks(fname : VString; Mat : in out Stacks; seperator_line_no : Integer; Stacks_Count : Integer; Crates_Count : Integer; puzzle_no : Integer);

    -- moves crates one by one
    procedure Move_Crates (Mat : in out Stacks; Count : Integer; Src : Integer; Dst : Integer);

    -- moves all the crates at once, kind of !
    procedure Move_Crates_2 (Mat : in out Stacks; Count : Integer; Src : Integer; Dst : Integer);

end helpers_1;
