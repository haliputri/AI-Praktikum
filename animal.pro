%Knowledge Base
animal(herbivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_geraham(yes),
    memiliki_gigi_taring(no),
    pemakan_daging(no),
    pemakan_tumbuhan(yes),
    pemakan_biji(yes).
animal(karnivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_geraham(yes),
    memiliki_gigi_taring(yes),
    pemakan_daging(yes),
    pemakan_tumbuhan(no),
    pemakan_biji(no).
animal(omnivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_geraham(yes),
    memiliki_gigi_taring(yes),
    pemakan_daging(yes),
    pemakan_tumbuhan(yes),
    pemakan_biji(yes).

%Asking for The User
memiliki_gigi_seri(X) :-
    menuask(memiliki_gigi_seri, X, [yes,no]).
memiliki_gigi_geraham(X) :-
    menuask(memiliki_gigi_geraham, X, [yes,no]).
memiliki_gigi_taring(X) :-
    menuask(memiliki_gigi_taring, X, [yes,no]).
pemakan_daging(X) :-
    menuask(pemakan_daging, X, [yes,no]).
pemakan_tumbuhan(X) :-
    menuask(pemakan_tumbuhan, X, [yes,no]).
pemakan_biji(X) :-
    menuask(pemakan_biji, X, [yes,no]).

menuask(A,V,_) :-
    known(yes,A,V), !. %succeed if true, stop looking.
menuask(A,V,_) :-
    alreadyasked(yes,A), !, fail.
menuask(A,V,MenuList) :-
    write('Apakah '), write(A), write('?'), nl,
    write([MenuList]), nl,
    read(X),
    check_val(X,A,V,MenuList),
    asserta(known(yes,A,X)),
    asserta(alreadyasked(yes,A)),
    X==V.

%Cek User input
check_val(X,_A,_V,MenuList) :- 
    member(X,MenuList), !. 
check_val(X,A,V,MenuList) :-
    write(X), write(' sayang sekali, input yang diberikan salah. coba lagi :)'), nl, 
    menuask(A,V,MenuList).

%Rules Clause Member
member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

%Start Simple Shell
%Backward Chaining
top_goal(X) :- animal(X).

solve :-
    abolish(known,3),
    abolish(alreadyasked,2),
    top_goal(X),
    write('Nah, jadi hewan tersebut masuk klasifikasi '), write(X), nl.
solve :-
    write('Yha, jawabannya gaada :('), nl. 


%Loop
go :-
    greeting,
    repeat,
    write('> '),
    read(X),
    do(X),
    X==quit.

greeting :-
    write('Selamat Datang di Program Pengklasifikasian Hewan berdasarkan Jenis Makanan'), nl,
    write('masukkan start atau quit pada prompt!'), nl.

%Running Program
do(start) :- solve, !.

%Quit Program
do(quit).
do(X) :- write(X), write(', input yang diberikan salah.'), nl, fail.

/* Handle Undefined Procedure */
:- unknown(trace,fail).