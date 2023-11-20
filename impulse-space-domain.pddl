(define
(domain space)
(:requirements :strips :typing :action-costs)
(:types location locatable - object
	ship supply - locatable
	plasmaconduit plasmainjector warpcoil dilithium medicalsupply - supply)

(:predicates
  (enable)
  (onship ?p - supply ?s - ship)
  (at ?l - locatable ?p - location)
  (adjacent ?a - location ?b - location))

(:functions
  (distance ?a - location ?b - location)
  (total-cost))

(:action travel-impulse-speed
  :parameters (?s - ship ?from - location ?to - location)
  :precondition (and
    (at ?s ?from)
    (not (enable))
    (adjacent ?from ?to))
  :effect (and
    (not (at ?s ?from))
    (at ?s ?to)
    (increase (total-cost) (distance ?from ?to))
    ))
(:action travel-warp-speed
  :parameters (?s - ship ?from - location ?to - location)
  :precondition (and
    (enable)
    (at ?s ?from)
    (adjacent ?from ?to))
  :effect (and
    (not (at ?s ?from))
    (at ?s ?to)
    (increase (total-cost) (warp-distance ?from ?to))
    ))

(:action beam-up-supplies
  :parameters (?s - ship ?l - location ?p - supply)
  :precondition (and
    (at ?s ?l)
    (at ?p ?l)
    (not (onship ?p ?s)))
  :effect (and
    (not (at ?p ?l))
    (onship ?p ?s)
    (increase (total-cost) 1)
    ))

(:action enable-warp-drive
  :parameters (?s - ship ?pc - plasmaconduit ?pi - plasmainjector ?wc - warpcoil ?di - dilithium)
  :precondition (and
    (onship ?pc ?s)
    (onship ?pi ?s)
    (onship ?wc ?s)
    (onship ?di ?s)
    (not (enable)))
  :effect (and
    (enable)
    (increase (total-cost) 3)
    ))
)
