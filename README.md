# Interpretador do Lambda Cálculo — Trabalho Final de LP

Trabalho final da disciplina de **Linguagens de Programação** (Ciência da Computação — UFFS, Campus Chapecó, turma 2026-2, Prof. Samuel da Silva Feitosa).

O objetivo é estender o interpretador do Lambda Cálculo desenvolvido em aula com uma **funcionalidade conhecida de outra linguagem de programação**, passando por todas as etapas: análise léxica, sintática e semântica.

## Requisitos do trabalho

Ao final, o interpretador deve conter:

1. Todas as funcionalidades desenvolvidas em sala:
   - operadores aritméticos, booleanos e relacionais;
   - expressões do cálculo lambda (abstração, aplicação, variáveis);
   - operador `let`;
   - uma funcionalidade vista em aula (Tuplas, Listas, Records, Operador Fix, etc.).
2. A **funcionalidade nova** escolhida pelo grupo, implementada no lexer, no parser (Happy), na AST, no TypeChecker e no Interpreter.

**Funcionalidade escolhida:** _a definir_

### Avaliação

| Item | Pontos |
|---|---|
| Adaptação do lexer e parser com Happy | 2,0 |
| Adaptação da AST com as novas funcionalidades | 1,0 |
| Adaptação dos módulos Interpreter e TypeChecker | 3,0 |
| Exemplos de programas executáveis na linguagem | 1,0 |
| Vídeo (máx. 5 min): funcionalidade, implementação e justificativa | 1,0 |
| Explicação das etapas léxica, sintática e semântica | 2,0 |

**Prazo de entrega (código + vídeo):** 09/12/2026, às 23:59.

## Estrutura do projeto

| Arquivo | Descrição |
|---|---|
| `Lexer.hs` | Definição dos tokens, da AST (`Expr`), dos tipos (`Ty`) e do analisador léxico |
| `Parser.y` | Gramática para o gerador de parsers **Happy** |
| `Parser.hs` | Parser gerado pelo Happy a partir de `Parser.y` (não editar à mão) |
| `TypeChecker.hs` | Verificação/inferência de tipos (`inferType`, `typecheck`) |
| `Interpreter.hs` | Substituição, avaliação big-step (`eval`) e small-step (`step`, `execute`) |
| `Main.hs` | Ponto de entrada: `lexer → parser → typecheck → eval` |

## Como compilar e executar

Requisitos: [GHC](https://www.haskell.org/ghcup/) e [Happy](https://hackage.haskell.org/package/happy).

```bash
# instalar o Happy (se necessário)
cabal update
cabal install happy

# gerar o parser a partir da gramática
happy Parser.y

# compilar
ghc Main.hs -o main

# executar (o programa é lido da entrada padrão)
echo "2 + 3" | ./main
```

Sempre que `Parser.y` for alterado, rode `happy Parser.y` novamente para regenerar `Parser.hs`.

## Estado atual

Ponto de partida vindo das aulas:

- **Lexer/Parser:** reconhecem apenas números inteiros, `+`, `*` e parênteses.
- **AST:** já possui `Num`, `Boolean`, `Sum`, `Mult`, `Equal`, `If`, `Var`, `Lam`, `App`.
- **TypeChecker:** falta o caso de `Mult` (por isso `2 * 3` ainda gera erro em tempo de execução).
- **Interpreter:** `eval` cobre apenas `Num`, `Sum` e `Mult`; `step` cobre `Sum`, `Mult` e aplicação de lambdas.

## Exemplos

_A definir conforme as funcionalidades forem implementadas._
