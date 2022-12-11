package common_1 is

    -- assumed values
    type Stacks_Range is Positive range 1 .. 9;
    type Crates_Range is Positive range 1 .. 81;    -- max 9x9
    
    type Crates is array (Crates_Range) of Character; 
    
    type Stack is record
        Top_Index : Natural;
        Crate_Stack : Crates;
    end record;

    type Stacks is array (Stacks_Range) of Stack;

    procedure Init_Matrix (This : in out Stacks);

    procedure Push(This : in out Stack; That : in Character);

    procedure Pop(This : in out Stack; That : out Character);

    function Copy(This : Stack) return Character;


end common_1;