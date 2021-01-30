main :-
    resetAnswers,
    findAuto(Auto),
    describe(Auto), nl.

  
findAuto(Auto) :-
    auto(Auto), !.
  
:- dynamic(progress/2).
  
resetAnswers :-
    retract(progress(_, _)),
    fail.
resetAnswers.

% Assigns an answer to questions from the knowledge base
typeAuto(Answer) :-
    progress(typeAuto, Answer).
typeAuto(Answer) :-
    \+ progress(typeAuto, _),
    ask(typeAuto, Answer, [sedan, stationWagon, hatchback, minivan, crossover]).

budget(Answer) :-
    progress(budget, Answer).
budget(Answer) :-
    \+ progress(budget, _),
    ask(budget, Answer, [one, two, three, four, five]).

country(Answer) :-
    progress(country, Answer).
country(Answer) :-
    \+ progress(country, _),
    ask(country, Answer, [germany, russia, usa, china, korea, japan]).

oil(Answer) :-
    progress(oil, Answer).
oil(Answer) :-
    \+ progress(oil, _),
    ask(oil, Answer, [benzin, deazil]).

kpp(Answer) :-
    progress(kpp, Answer).
kpp(Answer) :-
    \+ progress(kpp, _),
    ask(kpp, Answer, [mechanic, automate]).


answers([], _).
answers([First|Rest], Index):-
    write(Index), write(' '), answer(First), nl,
    NextIndex is Index + 1,
    answers(Rest, NextIndex).
  
parse(0, [First|_], First).
parse(Index, [_|Rest], Response) :-
    Index > 0,
    NextIndex is Index - 1,
    parse(NextIndex, Rest, Response).
  
  
ask(Question, Answer, Choices) :-
    question(Question),
    answers(Choices, 0),
    read(Index),
    parse(Index, Choices, Response),
    asserta(progress(Question, Response)),
    Response = Answer.


question(typeAuto):-
    write('Какой тип автомобиля вы ищете?'), nl.

question(budget):-
    write('В каком бюджете?'), nl.

question(country):-
    write('Какая страна-производитель?'), nl.

question(oil):-
    write('Дизель или бензин?'), nl.

question(kpp):-
    write('Автомат или механика?'), nl.


answer(sedan) :-
  write('Седан').

answer(stationWagon) :-
  write('Универсал').

answer(hatchback) :-
  write('Хэтчбэк').

answer(minivan) :-
  write('Минивен').

answer(crossover) :-
  write('Кроссовер').

answer(one) :-
  write('От трехсот  до шестисот тысяч').

answer(two) :-
  write('От шестясот тысяч до миллиона рублей').

answer(three) :-
  write('От миллиона до полутра миллиона рублей').

answer(four) :-
  write('От полутра миллиона до двух c половиной миллиона рублей').

answer(five) :-
  write('От двух c половиной миллиона до четырех миллионов рублей').

answer(germany) :-
  write('Германия').

answer(russia) :-
  write('Россия').

answer(usa) :-
  write('Америка').

answer(china) :-
  write('Китай').

answer(korea) :-
  write('Корея').

answer(japan) :-
  write('Япония').

answer(benzin) :-
  write('Бензин').

answer(deazil) :-
  write('Дизель').

answer(mechanic) :-
  write('Механика').

answer(automate) :-
  write('Автомат').

auto(fordFocus):-
    typeAuto(sedan),
    budget(three),
    country(usa),
    oil(benzin),
    kpp(automate).

auto(kiaSead):-
    typeAuto(hatchback),
    budget(three),
    country(korea),
    oil(benzin),
    kpp(automate).

auto(hondaCivic):-
    typeAuto(sedan),
    budget(three),
    country(japan),
    oil(benzin),
    kpp(automate).

auto(kiaSportage):-
    typeAuto(crossover),
    budget(four),
    country(korea),
    oil(benzin),
    kpp(automate).

auto(ladaVesta):-
    typeAuto(sedan),
    budget(two),
    country(russia),
    oil(benzin),
    kpp(mechanic).

auto(volkswagenMultivan):-
    typeAuto(minivan),
    budget(five),
    country(germany),
    oil(deazil),
    kpp(automate).

auto(volvoXC70):-
    typeAuto(stationWagon),
    budget(four),
    country(germany),
    oil(deazil),
    kpp(automate).

auto(volkswagenPolo):-
    typeAuto(sedan),
    budget(three),
    country(germany),
    oil(benzin),
    kpp(mechanic).

auto(vaz2107):-
    typeAuto(sedan),
    budget(three),
    country(germany),
    oil(benzin),
    kpp(mechanic).

auto(default):-
    typeAuto(_),
    budget(_),
    country(_),
    oil(_),
    kpp(_).

describe(fordFocus) :-
    write('Вам подойдет Форд Фокус.'), nl.

describe(kiaSead) :-
    write('Вам подойдет Киа Сид.'), nl.

describe(hondaCivic) :-
    write('Вам подойдет Хонда Цивик.'), nl.

describe(kiaSportage) :-
    write('Вам подойдет Киа Спортейдж.'), nl.

describe(ladaVesta) :-
    write('Вам подойдет Лада Веста.'), nl.

describe(volkswagenMultivan) :-
    write('Вам подойдет Фольксваген Мультивен.'), nl.


describe(volkswagenPolo) :-
    write('Вам подойдет Фольксваген Поло.'), nl.

describe(volvoXC70) :-
    write('Вам подойдет Вольво XC70.'), nl.


describe(vaz2107) :-
    write('Вам подойдет Семерка.'), nl.

describe(default):-
    write('Не смогли подобрать автомобиль по заданным данным(.'), nl.


