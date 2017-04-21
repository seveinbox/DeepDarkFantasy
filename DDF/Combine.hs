{-# LANGUAGE NoImplicitPrelude, TypeFamilies, TypeApplications, ScopedTypeVariables, NoMonomorphismRestriction #-}

module DDF.Combine where

import DDF.Meta.Interpreter
import qualified DDF.Map as Map
import DDF.Lang

instance (DBI l, DBI r) => DBI (Combine l r) where
  z = Combine z z
  s (Combine l r) = Combine (s l) (s r)
  app (Combine fl fr) (Combine xl xr) = Combine (app fl xl) (app fr xr)
  abs (Combine l r) = Combine (abs l) (abs r)
  hoas f = Combine (hoas $ \x -> case f (Combine x z) of Combine l _ -> l) (hoas $ \x -> case f (Combine z x) of Combine _ r -> r)
  liftEnv (Combine l r) = Combine (liftEnv l) (liftEnv r)

instance (Bool l, Bool r) => Bool (Combine l r) where
  bool x = Combine (bool x) (bool x)
  ite = Combine ite ite

instance (Char l, Char r) => Char (Combine l r) where
  char x = Combine (char x) (char x)

instance (Prod l, Prod r) => Prod (Combine l r) where
  mkProd = Combine mkProd mkProd
  zro = Combine zro zro
  fst = Combine fst fst

instance (Double l, Double r) => Double (Combine l r) where
  double x = Combine (double x) (double x)
  doublePlus = Combine doublePlus doublePlus
  doubleMinus = Combine doubleMinus doubleMinus
  doubleMult = Combine doubleMult doubleMult
  doubleDivide = Combine doubleDivide doubleDivide
  doubleExp = Combine doubleExp doubleExp

instance (Float l, Float r) => Float (Combine l r) where
  float x = Combine (float x) (float x)
  floatPlus = Combine floatPlus floatPlus
  floatMinus = Combine floatMinus floatMinus
  floatMult = Combine floatMult floatMult
  floatDivide = Combine floatDivide floatDivide
  floatExp = Combine floatExp floatExp

instance (Option l, Option r) => Option (Combine l r) where
  nothing = Combine nothing nothing
  just = Combine just just
  optionMatch = Combine optionMatch optionMatch

instance (Map.Map l, Map.Map r) => Map.Map (Combine l r) where
  empty = Combine Map.empty Map.empty
  lookup = Combine Map.lookup Map.lookup
  singleton = Combine Map.singleton Map.singleton
  alter = Combine Map.alter Map.alter
  mapMap = Combine Map.mapMap Map.mapMap

instance (Bimap l, Bimap r) => Bimap (Combine l r) where

instance (Dual l, Dual r) => Dual (Combine l r) where
  dual = Combine dual dual
  runDual = Combine runDual runDual

instance (Unit l, Unit r) => Unit (Combine l r) where
  unit = Combine unit unit

instance (Sum l, Sum r) => Sum (Combine l r) where
  left = Combine left left
  right = Combine right right
  sumMatch = Combine sumMatch sumMatch

instance (Int l, Int r) => Int (Combine l r) where
  int x = Combine (int x) (int x)

instance (Fix l, Fix r) => Fix (Combine l r) where
  fix = Combine fix fix

instance (List l, List r) => List (Combine l r) where
  nil = Combine nil nil
  cons = Combine cons cons
  listMatch = Combine listMatch listMatch

instance (IO l, IO r) => IO (Combine l r) where
  ioRet = Combine ioRet ioRet
  ioBind = Combine ioBind ioBind
  ioMap = Combine ioMap ioMap
  putStrLn = Combine putStrLn putStrLn

instance (Lang l, Lang r) => Lang (Combine l r) where
  exfalso = Combine exfalso exfalso
  runWriter = Combine runWriter runWriter
  writer = Combine writer writer
  double2Float = Combine double2Float double2Float
  float2Double = Combine float2Double float2Double
  state = Combine state state
  runState = Combine runState runState
