% Program Prolog Pengklasifikasian Hewan Berdasarkan Makananan
% Kelompok 10:
    % Hali Putri Aisyah     - 140810200006
    % Zhillan Thafhan Ahda  - 140810200018
    % Fasya Nurina Izzati   - 140810200052

%Knowledge Base
animal(herbivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_taring(no).
animal(karnivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_taring(yes),
    memiliki_gigi_geraham(no).
animal(omnivora) :-
    memiliki_gigi_seri(yes),
    memiliki_gigi_taring(yes),
    memiliki_gigi_geraham(yes).

%Asking for The User
memiliki_gigi_seri(X) :-
    menuask(memiliki_gigi_seri, X, [yes,no]).
memiliki_gigi_taring(X) :-
    menuask(memiliki_gigi_taring, X, [yes,no]).
memiliki_gigi_geraham(X) :-
    menuask(memiliki_gigi_geraham, X, [yes,no]).

menuask(A,V,_) :-
    known(yes,A,V), !. %succeed if true, stop looking.
menuask(A,V,_) :-
    alreadyasked(yes,A), !, fail.
menuask(A,V,MenuList) :-
    write('\nApakah '), write(A), write('?'), nl,
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
    write(X), write('\n sayang sekali, input yang diberikan salah. coba lagi :)'), nl, 
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
    write('                 Nah, klasifikasi hewan: '), write(X), nl, nl.    
solve :-
    write('                         Yha, jawabannya gaada :(\n'), nl. 

%Loop
go :-
    greeting,
    repeat,
    write(' > '),
    read(X),
    ((X==quit)->do(quit) ; do(X), prompt, fail).

prompt :-
    write('======================================================================='), nl,
    write('          Enter [start.] untuk memulai - [quit.] untuk keluar          '), nl,
    write('======================================================================='), nl.

greeting :-
    write('======================================================================='), nl,
    write('       Program Pengklasifikasian Hewan berdasarkan Jenis Makanan       '), nl,
    prompt.

%Running Program
do(start) :- solve, !.

%Quit Program
do(quit) :-
    write('\n----------- Terima kasih, program ini telah berakhir :) ------------').

do(X) :- write(X), write(', input yang diberikan salah.'), nl, fail.

/* Handle Undefined Procedure */
:- unknown(trace,fail).