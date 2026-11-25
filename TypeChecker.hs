module TypeChecker where 

import Lexer

type Ctx = [(Id, Ty)]

lookupType :: Id -> Ctx -> Either String Ty 
lookupType x ctx = case lookup x ctx of 
  Just t -> Right t 
  Nothing -> Left $ "Variável não declarada " ++ x 

inferType :: Ctx -> Expr -> Either String Ty 
inferType _ (Num _) = Right TInt 
inferType _ (Boolean _) = Right TBool 
inferType ctx (Var x) = lookupType x ctx 
inferType ctx (Lam x tArg body) = do
  let ctx' = (x, tArg) : ctx 
  tBody <- inferType ctx' body 
  return (TFun tArg tBody)
inferType ctx (App e1 e2) = do 
    tFun <- inferType ctx e1 
    tArg <- inferType ctx e2 
    case tFun of 
      (TFun tIn tOut) -> 
        if tIn == tArg 
          then Right tOut 
          else Left $ "Tipo de argumento incorreto. Esperado: " 
                      ++ show tIn ++ " Recebido: " ++ show tArg 
      _ -> Left "Erro: Tentativa de aplicar algo que não é função."  
inferType ctx (Sum e1 e2) = do 
    t1 <- inferType ctx e1 
    t2 <- inferType ctx e2 
    if t1 == TInt && t2 == TInt 
      then Right TInt 
      else Left "Erro: Soma exige dois inteiros"
-- Fazer para Mult
inferType ctx (Equal e1 e2) = do 
    t1 <- inferType ctx e1
    t2 <- inferType ctx e2 
    if t1 == TInt && t2 == TInt 
      then Right TBool 
      else Left "Erro: Comparação exige dois inteiros"
inferType ctx (If e1 e2 e3) = do 
    tCond <- inferType ctx e1 
    tThen <- inferType ctx e2 
    tElse <- inferType ctx e3 
    if tCond /= TBool 
      then Left "Erro: a condição do 'if' deve ser Booleana"
      else if tThen /= tElse 
             then Left "Erro: Ramos do 'if' devem ter o mesmo tipo"
             else Right tThen 

typecheck :: Expr -> Expr 
typecheck e = case inferType [] e of 
                Right _  -> e 
                Left err -> error ("Type error: " ++ err)
