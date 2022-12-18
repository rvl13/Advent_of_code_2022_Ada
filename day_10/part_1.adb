with HAL; use HAL;


procedure part_1 is

    Input_File : File_Type;
    --File_Name : VString := +"./input_simplified.txt";
    File_Name : VString := +"./input.txt";


    -- Note that we need to find signal strength during 20th, 60th, 100th ... cycles
    -- Not after execution of 20th, 60th, 100th ... cycles
    -- means at the beginning of 20th, 60th, 100th ... cycles or after end of 19th, 59th, 99th cycles 

    Clock_Cycles : Natural := 1;
    --Clock_Cycles : Natural := 0;
    Register_X : Integer := 1;

    Cycles_Offset : constant Natural := 20;
    Cycles_Interval : constant Natural := 40;

    Signal_Strength_Sum : Integer := 0;
    Line_Temp : VString;
    Line_Number : Natural := 0;
    Half_execution : Boolean := False;

    procedure execute_instruction_addx (Increment : in Integer);

    procedure execute_instruction_noop;

    procedure post_cycle_execution_task;

    procedure parse_and_execute_instruction(Instruction : in VString);


    procedure execute_instruction_addx (Increment : in Integer) is
    begin
        -- 1st cycle
        Clock_Cycles := Clock_Cycles + 1;
        Half_execution := True;
        post_cycle_execution_task;


        -- 2nd cycle
        Clock_Cycles := Clock_Cycles + 1;
        Register_X := Register_X + Increment;
        Half_execution := False;
        post_cycle_execution_task;


    end execute_instruction_addx;


    procedure execute_instruction_noop is
    begin
        -- 1st cycle
        Clock_Cycles := Clock_Cycles + 1;
        post_cycle_execution_task;

    end execute_instruction_noop;


    procedure post_cycle_execution_task is
    begin

        -- check if cycle is one of 20th, 60th, 100th, ...
        if ( (Clock_Cycles - Cycles_Offset) mod Cycles_Interval = 0 ) then
            Put_Line("--------------------------------");
            Put_Line("Executing Line : " & Integer'Image(Line_Number) );
            Put_Line(Boolean'Image(Half_execution));
            Put_Line("Cycle : " & Integer'Image(Clock_Cycles) & " , Register X : " & Integer'Image(Register_X));
            Put_Line("Increment : " & Integer'Image(Clock_Cycles * Register_X));
            
            Signal_Strength_Sum := Signal_Strength_Sum + ( Clock_Cycles * Register_X);
            
            Put_Line("Sum : " & Integer'Image(Signal_Strength_Sum));
            Put_Line("--------------------------------");

        else
            null;
        end if;

    end post_cycle_execution_task;


    procedure parse_and_execute_instruction(Instruction : in VString) is
        Index_Temp : Natural := 0;
        Number_Temp : Integer := 0;
        noop_mnemonic : VString := +"noop";
        addx_mnemonic : VString := +"addx"; 
    begin

        if Index(Instruction, noop_mnemonic) > 0 then
            execute_instruction_noop;
        elsif Index(Instruction, addx_mnemonic) > 0 then
            Index_Temp := Index(Instruction, " ");
            Number_Temp := Integer'Value( To_String( Slice( Instruction, Index_Temp, Length(Instruction) )));
            execute_instruction_addx(Number_Temp);
        else
            null;
        end if;

    end parse_and_execute_instruction;


begin

    Put_Line("Solving Day 10 puzzle with HAC !");

    Open(Input_File, File_Name);

    loop
        exit when end_of_file(Input_File);

        Get_Line(Input_File, Line_Temp);
        Line_Number := Line_Number + 1;
        parse_and_execute_instruction(Line_Temp);

    end loop;

    Close(Input_File);

    Put_Line("Sum of Signal Strength " & Integer'Image(Signal_Strength_Sum));

end part_1;