% Base de conhecimento sobre a familia.
progenitor(maria, jose).
progenitor(joao, jose).
progenitor(joao, ana).
progenitor(jose, julia).
progenitor(jose, iris).
progenitor(iris, jorge).

masculino(joao).
masculino(jose).
masculino(jorge).

feminino(maria).
feminino(julia).
feminino(ana).
feminino(iris).

% Regras para identificar a pessoa da familia.
filho(X, Y) :- progenitor(Y, X).

mãe(X, Y) :- progenitor(X, Y), feminino(X).
pai(X, Y) :- progenitor(X, Y), masculino(X).

avô(X, Z) :- progenitor(X, Y), progenitor(Y, Z), masculino(X).
avó(X, Z) :- progenitor(X, Y), progenitor(Y, Z), feminino(X).

irmã(X, Y) :- progenitor(Z, X), progenitor(Z, Y), feminino(X), X \= Y.

% Consultas de teste.
consulta_filho :- filho(jose, maria).
consulta_mãe :- mãe(maria, jose).
consulta_avô :- avô(joao, julia).
consulta_irmã :- irmã(X, iris).