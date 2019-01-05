% CPU example ``Using Transformations and Verification in Circuit Design,'' 
% by James B. Saxe, Stephen J. Garland, John V. Guttag, and James J. Horning,
% DEC Systems Research Center Report 78, September 1991.  Modified for LP3.1.

set script cpu
set log cpu

clear
set box-checking on
set order left-to-right


% Natural numbers, for use as time steps

set name nat
declare sort Nat
declare variable t: Nat
declare operators
  0, 1, 2, 3, 4, 5, 6, 7:          -> Nat
  __+__:                  Nat, Nat -> Nat
  ..
assert ac +
assert
  2 = 1 + 1;
  3 = 2 + 1;
  4 = 3 + 1;
  5 = 4 + 1;
  6 = 5 + 1;
  7 = 6 + 1
  ..


% CPU abstractions

set name CPU
declare sorts
  RAddr,                      % Register addresses
  RFile,                      % Register files
  Data,                       % Data words
  IAddr,                      % Instruction addresses
  Instr,                      % Instructions
  ALU_op                      % Arithmetic Logic Unit operation
  ..

declare operators
  program: IAddr              -> Instr     % Instruction at instruction address
  getBT:   Instr              -> IAddr     % Branch target
  getWA:   Instr              -> RAddr     % Write address
  getRA:   Instr              -> RAddr     % Read address
  getOP:   Instr              -> ALU_op    % ALU operation
  ALU:     ALU_op, Data       -> Data      % Effect of ALU operation
  incr:    IAddr              -> IAddr     % Next instruction address
  zero:                       -> Data      % Data value that causes branch
  null:                       -> RAddr     % Writes to this address are ignored
  assign:  RFile, RAddr, Data -> RFile     % Register write
  select:  RFile, RAddr       -> Data      % Register read
  kill:    RAddr, Bool        -> RAddr     % Used for write suppression
  ..

declare variables
  xRFile:         RFile
  xRAddr, yRAddr: RAddr
  xData:          Data
  xBool:          Bool
  xIAddr:         IAddr
  ..

assert
  assign(xRFile, null, xData) = xRFile;
  select(assign(xRFile, xRAddr, xData), yRAddr) =
    (if xRAddr = yRAddr /\ yRAddr ~= null
       then xData
       else select(xRFile, yRAddr));
  kill(xRAddr, xBool) = (if xBool then null else xRAddr);
  getRA(program(xIAddr)) ~= null
  ..


% Computation histories

declare sorts
  RAddr_seq,                    % Sequences of register addresses
  RFile_seq,                    % Sequences of register files
  Data_seq,                     % Sequences of data words
  IAddr_seq,                    % Sequences of instruction addresses
  Instr_seq,                    % Sequences of instructions
  ALU_op_seq,                   % Sequences of ALU operations
  Bool_seq                      % Sequences of boolean values
  ..

declare operators
  __.__: RAddr_seq, Nat  -> RAddr
  __.__: RFile_seq, Nat  -> RFile
  __.__: IAddr_seq, Nat  -> IAddr
  __.__: Data_seq, Nat   -> Data
  __.__: Instr_seq, Nat  -> Instr
  __.__: ALU_op_seq, Nat -> ALU_op
  __.__: Bool_seq, Nat   -> Bool
  ..

declare operators               % The interface of the CPU
  WA_out: -> RAddr_seq          % Write address
  WD_out: -> Data_seq           % Write data
  ..


% Definition of the implementation in terms of a specific history

set name impl
declare operators
  INext, IPctr:                 -> IAddr_seq    % Program counter
  IInstr:                       -> Instr_seq    % Instruction
  IBT4, IBT3, IBT2, IBT1, IBT0: -> IAddr_seq    % Branch target pipe
  IBC4, IBC3, IBC2, IBC1, IBC0: -> Bool_seq     % Branch condition pipe
  IWA4, IWA3, IWA2, IWA1:       -> RAddr_seq    % Write address pipe
  IRA:                          -> RAddr_seq    % Read address
  IRD4, IRD3, IRD2, IRD1:       -> Data_seq     % Read data bypass chain
  IOP:                          -> ALU_op_seq   % ALU operation
  IWD4, IWD3, IWD2, IWD1:       -> Data_seq     % Write data pipe
  IRF:                          -> RFile_seq    % Register file
  ..

assert
  INext.t     = incr(IPctr.t);
  IInstr.t    = program(IPctr.t);
  IBT4.t      = getBT(IInstr.t);
  IBT3.(t+1)  = IBT4.t;
  IBT2.(t+1)  = IBT3.t;
  IBT1.(t+1)  = IBT2.t;
  IBT0.(t+1)  = IBT1.t;
  IRA.t       = getRA(IInstr.t);
  IRD1.t      = select(IRF.t, IRA.t);
  IRD2.t      = (if IWA1.t = IRA.t then IWD1.t else IRD1.t);
  IRD3.t      = (if IWA2.t = IRA.t then IWD2.t else IRD2.t);
  IRD4.t      = (if IWA3.t = IRA.t then IWD3.t else IRD3.t);
  IWA4.t      = getWA(IInstr.t);
  IWA3.(t+1)  = kill(IWA4.t, IBC0.t);
  IWA2.(t+1)  = kill(IWA3.t, IBC0.t);
  IWA1.(t+1)  = kill(IWA2.t, IBC0.t);
  IRF.(t+1)   = assign(IRF.t, kill(IWA1.t, IBC0.t), IWD1.t);
  IOP.t       = getOP(IInstr.t);
  IWD4.t      = ALU(IOP.t, IRD4.t);
  IWD3.(t+1)  = IWD4.t;
  IWD2.(t+1)  = IWD3.t;
  IWD1.(t+1)  = IWD2.t;
  IBC4.t      = (IWD4.t = zero);
  IBC3.(t+1)  = (IBC4.t /\ ~IBC0.t);
  IBC2.(t+1)  = (IBC3.t /\ ~IBC0.t);
  IBC1.(t+1)  = (IBC2.t /\ ~IBC0.t);
  IBC0.(t+1)  = (IBC1.t /\ ~IBC0.t);
  IPctr.(t+1) = (if IBC0.t then IBT0.t else INext.t);
  WA_out.t    = kill(IWA1.t, IBC0.t);
  WD_out.t    = IWD1.t
  ..


% Definition of level map (from implementation to specification)

set name spec
declare operators
  SNext, SPCtr: -> IAddr_seq        % Program counter
  SInstr:       -> Instr_seq        % Instruction
  SBT:          -> IAddr_seq        % Branch target
  SBC:          -> Bool_seq         % Branch condition
  SWA:          -> RAddr_seq        % Write address
  SRA:          -> RAddr_seq        % Read address
  SRD:          -> Data_seq         % Read data
  SOP:          -> ALU_op_seq       % ALU operation
  SWD:          -> Data_seq         % Write data
  SRF:          -> RFile_seq        % Register file
  Stalled:      -> Bool_seq
  ..

assert
  SRF.t         = IRF.t;
  SPCtr.(t+3)   = (if IBC0.t then IBT0.t
                      else if IBC1.t then IBT1.t
                      else if IBC2.t then IBT2.t
                      else if IBC3.t then IBT3.t
                      else IPctr.t);
  SNext.t       = incr(SPCtr.t);
  SInstr.t      = program(SPCtr.t);
  SBT.t         = getBT(SInstr.t);
  SWA.t         = getWA(SInstr.t);
  SRA.t         = getRA(SInstr.t);
  SOP.t         = getOP(SInstr.t);
  SRD.t         = select(SRF.t, SRA.t);
  SWD.t         = ALU(SOP.t, SRD.t);
  SBC.t         = (SWD.t = zero);
  Stalled.(t+3) = (IBC0.t \/ IBC1.t \/ IBC2.t \/ IBC3.t)
  ..


% Proof that specification is satisfied

set name theorem
prove SNext.(t+3) = incr(SPCtr.(t+3))
  [] conjecture
qed

prove SInstr.(t+3) = program(SPCtr.(t+3))
  [] conjecture
qed

prove SBT.(t+3) = getBT(SInstr.(t+3))
  [] conjecture
qed

prove SRA.(t+3) = getRA(SInstr.(t+3))
  [] conjecture
qed

prove SRD.(t+3) = select(SRF.(t+3), SRA.(t+3))
  [] conjecture
qed

prove ((SWA.(t+3)) = getWA(SInstr.(t+3)))
  [] conjecture
qed

prove SOP.(t+3) = getOP(SInstr.(t+3))
  [] conjecture
qed

prove SWD.(t+3) = ALU(SOP.(t+3), SRD.(t+3))
  [] conjecture
qed

prove SBC.(t+3) = (SWD.(t+3) = zero)
  [] conjecture
qed

prove
  SPCtr.(t+4) = (if Stalled.(t+3) then SPCtr.(t+3)
                    else if SBC.(t+3) then SBT.(t+3)
                    else SNext.(t+3))
  ..
  make immune conjecture
  resume by case IBC0.t
    <> case IBC0.(tc)
    [] case IBC0.(tc)
    <> case ~IBC0.(tc)
    resume by case IBC1.tc
      <> case IBC1.(tc)
      [] case IBC1.(tc)
      <> case ~IBC1.(tc)
      resume by case IBC2.tc
        <> case IBC2.(tc)
        [] case IBC2.(tc)
        <> case ~IBC2.(tc)
        [] case ~IBC2.(tc)
      [] case ~IBC1.(tc)
    [] case ~IBC0.(tc)
  [] conjecture
qed

prove
   SRF.(t+4) = (if Stalled.(t+3) then SRF.(t+3)
                   else assign(SRF.(t+3), SWA.(t+3), SWD.(t+3)))
  ..
  make immune conjecture
  resume by case IBC0.(t)
    <> case IBC0.(tc)
    [] case IBC0.(tc)
    <> case ~IBC0.(tc)
    resume by case IBC1.tc
      <> case IBC1.(tc)
      [] case IBC1.(tc)
      <> case ~IBC1.(tc)
      resume by case IBC2.tc
        <> case IBC2.(tc)
        [] case IBC2.(tc)
        <> case ~IBC2.(tc)
        resume by case IBC3.tc
          <> case IBC3.(tc)
          [] case IBC3.(tc)
          <> case ~IBC3.(tc)
          [] case ~IBC3.(tc)
        [] case ~IBC2.(tc)
      [] case ~IBC1.(tc)
    [] case ~IBC0.(tc)
  [] conjecture
qed

prove WA_out.(t+3) = (if Stalled.(t+3) then null else SWA.(t+3))
  make immune conjecture
  resume by case IBC0.(t)
    <> case IBC0.(tc)
    [] case IBC0.(tc)
    <> case ~IBC0.(tc)
    resume by case IBC1.tc
      <> case IBC1.(tc)
      [] case IBC1.(tc)
      <> case ~IBC1.(tc)
      resume by case IBC2.tc
        <> case IBC2.(tc)
        [] case IBC2.(tc)
        <> case ~IBC2.(tc)
        [] case ~IBC2.(tc)
      [] case ~IBC1.(tc)
    [] case ~IBC0.(tc)
  [] conjecture
qed

prove Stalled.(t+3) \/ WD_out.(t+3) = SWD.(t+3)
  make immune conjecture
  resume by case IBC0.(t)
    <> case IBC0.(tc)
    [] case IBC0.(tc)
    <> case ~IBC0.(tc)
    resume by case IBC1.tc
      <> case IBC1.(tc)
      [] case IBC1.(tc)
      <> case ~IBC1.(tc)
      resume by case IBC2.tc
        <> case IBC2.(tc)
        [] case IBC2.(tc)
        <> case ~IBC2.(tc)
        resume by case IBC3.tc
          <> case IBC3.(tc)
          [] case IBC3.(tc)
          <> case ~IBC3.(tc)
          [] case ~IBC3.(tc)
        [] case ~IBC2.(tc)
      [] case ~IBC1.(tc)
    [] case ~IBC0.(tc)
  [] conjecture
qed

prove
   ~( Stalled.(t+3) /\ Stalled.(t+4) /\ Stalled.(t+5) /\
        Stalled.(t+6) /\ Stalled.(t+7)
    )
  ..
  make immune conjecture
  resume by case IBC0.(t)
    <> case IBC0.(tc)
    [] case IBC0.(tc)
    <> case ~IBC0.(tc)
    resume by case IBC1.tc
      <> case IBC1.(tc)
      [] case IBC1.(tc)
      <> case ~IBC1.(tc)
      resume by case IBC2.tc
        <> case IBC2.(tc)
        [] case IBC2.(tc)
        <> case ~IBC2.(tc)
        resume by case IBC3.tc
          <> case IBC3.(tc)
          [] case IBC3.(tc)
          <> case ~IBC3.(tc)
          [] case ~IBC3.(tc)
        [] case ~IBC2.(tc)
      [] case ~IBC1.(tc)
    [] case ~IBC0.(tc)
  [] conjecture
qed

statistics
