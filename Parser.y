{
module Parser where
import Lexer 
}

%name parser
%tokentype { Token }
%error { parseError }

%token 
    num     { TokNum $$ }
    '+'     { TokSum }
    '*'     { TokMult }
    '('     { TokOpenPar }
    ')'     { TokClosePar }

%left '+'
%left '*'

%% 

Exp : num               { Num $1 }
    | Exp '+' Exp       { Sum $1 $3 }
    | Exp '*' Exp       { Mult $1 $3 }
    | '(' Exp ')'       { $2 }

{ 
parseError :: [Token] -> a 
parseError _ = error "Erro sintatico!"
}

