------------------------------------------------------------------------
-- Sums (disjoint unions)
------------------------------------------------------------------------

{-# OPTIONS --universe-polymorphism #-}

module Data.Sum where

open import Data.Function
open import Data.Maybe.Core
open import Level

------------------------------------------------------------------------
-- Definition

infixr 1 _⊎_

data _⊎_ {a b} (A : Set a) (B : Set b) : Set (a ⊔ b) where
  inj₁ : (x : A) → A ⊎ B
  inj₂ : (y : B) → A ⊎ B

------------------------------------------------------------------------
-- Functions

[_,_] : ∀ {a b c} {A : Set a} {B : Set b} {C : A ⊎ B → Set c} →
        ((x : A) → C (inj₁ x)) → ((x : B) → C (inj₂ x)) →
        ((x : A ⊎ B) → C x)
[ f , g ] (inj₁ x) = f x
[ f , g ] (inj₂ y) = g y

[_,_]′ : ∀ {a b c} {A : Set a} {B : Set b} {C : Set c} →
         (A → C) → (B → C) → (A ⊎ B → C)
[_,_]′ = [_,_]

map : ∀ {a b c d} {A : Set a} {B : Set b} {C : Set c} {D : Set d} →
      (A → C) → (B → D) → (A ⊎ B → C ⊎ D)
map f g = [ inj₁ ∘ f , inj₂ ∘ g ]

infixr 1 _-⊎-_

_-⊎-_ : ∀ {a b c d} {A : Set a} {B : Set b} →
        (A → B → Set c) → (A → B → Set d) → (A → B → Set (c ⊔ d))
f -⊎- g = f -[ _⊎_ ]- g

isInj₁ : {A B : Set} → A ⊎ B → Maybe A
isInj₁ (inj₁ x) = just x
isInj₁ (inj₂ y) = nothing

isInj₂ : {A B : Set} → A ⊎ B → Maybe B
isInj₂ (inj₁ x) = nothing
isInj₂ (inj₂ y) = just y
