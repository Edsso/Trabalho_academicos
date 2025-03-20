% Verifica se a lista está ordenada de forma crescente
ordenado([]).
ordenado([_]).
ordenado([X,Y|Resto]) :- X =< Y, ordenado([Y|Resto]).

% Encontra o maior elemento em uma lista
max_lista([X], X).
max_lista([X|Resto], Max) :- max_lista(Resto, MaxResto), Max is max(X, MaxResto).

% Calcula o N-ésimo termo da sequência de Fibonacci
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, Resultado) :- N > 1, N1 is N - 1, N2 is N - 2, fibonacci(N1, F1), fibonacci(N2, F2), Resultado is F1 + F2.

% Verifica se um número é primo
is_primo(2).
is_primo(3).
is_primo(N) :- N > 3, N mod 2 =\= 0, \+ has_factor(N, 3).
