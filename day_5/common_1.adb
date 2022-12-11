package body common_1 is

    procedure Init_Matrix (This : in out Stacks) is
    begin
        for I in Stacks_Range loop
            This(I).Top_Index := 0;
            
            for J in Crates_Range loop
                This(I).Crate_Stack(J) := '0';
            end loop;

        end loop;
    end Init_Matrix;

    procedure Push(This : in out Stack; That : in Character) is
    begin
        This.Top_Index := This.Top_Index + 1;
        This.Crate_Stack(This.Top_Index) := That;
    end Push;

    procedure Pop(This : in out Stack; That : out Character) is
    begin
        That := This.Crate_Stack(This.Top_Index);
        This.Crate_Stack(This.Top_Index) := '0';
        This.Top_Index := This.Top_Index - 1;
    end Pop;

    function Copy(This : Stack) return Character is
    begin
        return This.Crate_Stack(This.Top_Index);
    end Copy;

end common_1;