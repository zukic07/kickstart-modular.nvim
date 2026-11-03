" Vim syntax file
" Language:    IBM z/OS High Level Assembler (HLASM) & Listings
" Maintainer:  Custom HLASM Syntax

if exists("b:current_syntax")
  finish
endif

syntax case ignore

" Todos inside comments
syntax keyword ibmAsmTodo contained TODO FIXME XXX NOTE NOTE:

" Full-line comments (* at column 1, or after statement number in listings, or /* */)
syntax match ibmAsmComment "^\s*\*.*$" contains=ibmAsmTodo
syntax match ibmAsmComment "^\s*\d\+\s*\*.*$" contains=ibmAsmTodo
syntax match ibmAsmComment "^\s*\d\++\*.*$" contains=ibmAsmTodo
syntax match ibmAsmComment "\*\/.*" contains=ibmAsmTodo
syntax match ibmAsmComment "\/\*.*" contains=ibmAsmTodo

" Trailing remarks / comments after operand field
syntax match ibmAsmComment ".*$" contained contains=ibmAsmTodo

" Strings and Constants
syntax region ibmAsmString start=+'+ skip=+''+ end=+'+ contained
syntax match ibmAsmConstant "\<[CXZBFHDAPLYS]'\([^']\|''\)*'" contained
syntax match ibmAsmConstant "\<AL[1-4]([^)]*)" contained
syntax match ibmAsmConstant "\<A([^)]*)" contained
syntax match ibmAsmConstant "\<V([^)]*)" contained
syntax match ibmAsmNumber "\<[0-9]\+\>" contained
syntax match ibmAsmHex "\<X'[0-9A-Fa-f]\+'\>" contained

" Registers
syntax match ibmAsmRegister "\<R[0-9]\+\>" contained
syntax match ibmAsmRegister "\<R1[0-5]\>" contained
syntax match ibmAsmRegister "\<AR[0-9]\+\>" contained
syntax match ibmAsmRegister "\<AR1[0-5]\>" contained

" Operand field (handles non-whitespace tokens and quoted strings with spaces)
syntax match ibmAsmOperand "\(\('[^']*'\)\|[^ \t]\)\+" contained nextgroup=ibmAsmComment skipwhite contains=ibmAsmConstant,ibmAsmRegister,ibmAsmNumber,ibmAsmHex,ibmAsmString

" HLASM Assembler Directives
syntax keyword ibmAsmDirective CSECT DSECT RSECT START END EQU USING DROP nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmDirective DC DS ORG LTORG CNOP COPY AMODE RMODE nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmDirective WXTRN EXTRN ENTRY CCW PUSH POP PRINT TITLE EJECT SPACE nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmDirective MACRO MEND MEXIT MNOTE AGO AIF ANOP nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmDirective GBLA GBLB GBLC LCLA LCLB LCLC SETA SETB SETC nextgroup=ibmAsmOperand skipwhite

" Machine Instructions (Opcodes)
syntax keyword ibmAsmInstruction LARL LA LR L LH LGR LG LTR LT LM LMG nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction ST STH STC STM STMG nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction MVC MVI MVZ MVN MVCL MVCIN nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction A AR AH AHI AG AGR AGHI AL ALR ALG ALGR nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction S SR SH SHI SG SGR SGHI SL SLR SLG SLGR nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction M MR MH MHI MS MSR MSG MSGR nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction D DR DSG DSGR nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction C CR CH CHI CG CGR CL CLR CLG CLGR CLC CLI CLCL nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction N NR NI NG NGR NC O OR OI OG OGR OC X XR XI XG XGR XC nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction TM TMH TML nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction B BR BC BCR BAL BALR BAS BASR BCT BCTR BXH BXLE nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction BE BNE BH BNH BL BNL BM BNM BO BNO BZ BNZ BP BNP nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction J JAS JCT JE JNE JH JNH JL JNL JM JNM JO JNO JZ JNZ JP JNP nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction SLL SRL SLA SRA SLDL SRDL SLDA SRDA nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction CVD CVDG CVB CVBG PACK UNPK TR TRT ED EDMK nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction SVC SAM24 SAM31 SAM64 TAM IPK SPKA SSAR SAC EPSW LPSW LPSWE nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmInstruction CS CDS CSG CDSG TS nextgroup=ibmAsmOperand skipwhite

" Standard z/OS System & Service Macros
syntax keyword ibmAsmMacro WTO WTOR GETMAIN FREEMAIN STORAGE ATTACH ATTACHX DETACH nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmMacro LINK LINKX LOAD DELETE XCTL XCTLX CALL SAVE RETURN nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmMacro TIME STIMER TTIMER SNAP ABEND ESTAE ESTAEX SETLOCK ENQ DEQ nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmMacro OPEN CLOSE GET PUT READ WRITE CHECK DCB DCBD ACB RPL nextgroup=ibmAsmOperand skipwhite
syntax keyword ibmAsmMacro MODCB GENCB SHOWCB TESTCB CVT PSA TCB ASCB ASVT CSVDYNEX nextgroup=ibmAsmOperand skipwhite

" Fallback generic Opcode / Macro invocation for unknown macros
syntax match ibmAsmMacroInvocation "\<[A-Za-z$#@][A-Za-z0-9$#@]*\>" contained nextgroup=ibmAsmOperand skipwhite

" Listing specific structures (Headers, Addresses, Statement numbers)
syntax match ibmAsmHeader "^.*High Level Assembler Option Summary.*$"
syntax match ibmAsmHeader "^.*External Symbol Dictionary.*$"
syntax match ibmAsmHeader "^.*Ordinary Symbol and Literal Cross Reference.*$"
syntax match ibmAsmHeader "^.*Active Usings:.*$"
syntax match ibmAsmHeader "\<HLASM R[0-9.]\+\>"
syntax match ibmAsmHeader "\<Page\s\+[0-9]\+\>"
syntax match ibmAsmListingLoc "^\s*[0-9A-Fa-f]\{6\}\>"
syntax match ibmAsmListingStmt "^\s*[0-9A-Fa-f]\{6\}\(\s\+[0-9A-Fa-f]\+\)*\s\+\zs[0-9]\++\?"

" Highlight mappings
highlight default link ibmAsmTodo Todo
highlight default link ibmAsmComment Comment
highlight default link ibmAsmString String
highlight default link ibmAsmConstant Constant
highlight default link ibmAsmNumber Number
highlight default link ibmAsmHex Number
highlight default link ibmAsmRegister Type
highlight default link ibmAsmDirective PreProc
highlight default link ibmAsmInstruction Statement
highlight default link ibmAsmMacro Function
highlight default link ibmAsmMacroInvocation Function
highlight default link ibmAsmHeader Title
highlight default link ibmAsmListingLoc Special
highlight default link ibmAsmListingStmt LineNr

let b:current_syntax = "ibmAsm"
