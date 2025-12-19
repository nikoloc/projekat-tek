#set text(
  size: 12pt,
  lang: "sr",
)

#show link: it => underline(offset: 2pt, text(fill: blue, it))

#show heading: it => block(
  above: 1.8em,
  below: 1.2em,
  it,
)

#show figure: it => block(
  below: 1.8em,
  it,
)

#show figure.where(kind: table): it => {
  v(1.8em)
  it.caption
  it.body
}

#set page(numbering: "1")
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)")

#outline()

= Пројекат из Теорије Електричних Кола

== Задатак
Задатак је анализирати, саставити и измерити одзив следећег кола.
#figure(
  image("circuit.svg"),
  caption: [Шема електричног кола],
)

Ово коло представља појачавачки инвертујући филтер ниских фреквенција@TI. У даљем раду ћемо одредити на који начин се подешавањем
његових параметара може добити жељени ефекат.

== Прорачун
За потребе прорачуна подразумеваћемо да је операциони појачавач идеалан, као на слици @fig-ideal-circuit.
// овде бисмо још могли да кажемо нешто за то како ћемо разлике видети када измеримо ствари итд

#figure(
  image("ideal-circuit.svg"),
  caption: [Шема идеалног електричног кола],
) <fig-ideal-circuit>

Дато коло ћемо анализирати за простопериодични улазни напонски сигнал $V_"in"=A sin(omega t + phi)$. Како је коло релативно ниске комплексности решићемо га ручно, у комплексном домену.

Желимо да изразимо излазни напон $underline(V_"out")$ преко улазног напона $underline(V_"in")$ и параметара кола $R_1$, $R_2$ и $C$.

Заменићемо паралелну везу отпорника $R_2$ и кондензатора $C$ еквивалентном импедансом $Z$

$ underline(Z) = (R_2 dot 1 / (j omega C)) / (R_2 + 1 / (j omega C)) = R_2 / (1 + j omega R_2 C) $

као на слици @fig-transformed-notated-circuit.

#figure(
  image("transformed-notated-circuit.svg"),
  caption: [Трансформисано електрично коло],
) <fig-transformed-notated-circuit>

Сада је струја кроз $R_1$ и $Z$ једнака. Означимо је са $I$. Приметимо ли још да је чвор кола који одговара инвертујућем терминалу
идеалног операционог појачавача једнак нули, можемо израчунати струју $I$ примењујући КЗН као

$ underline(I) = underline(V_"in") / R_1 $

Сада лако проналазимо излазни напон $V_"out"$ као

$ underline(V_"out") &= - underline(Z) underline(I)
&= - R_2 / (1 + j omega R_2 C) dot underline(V_"in") / R_1
&= - R_2 / R_1 dot 1 / (1 + j omega R_2 C) dot underline(V_"in") $

Овај резултат можемо представити и у облику преносне функције $H(omega)$

$ underline(H)(omega) = underline(V_"out") / underline(V_"in") = - R_2 / R_1 dot 1 / (1 + j omega R_2 C) $

Односно за ефективне вредности добијамо

$ H(omega) = R_2 / R_1 dot 1 / sqrt(1 + (omega R_2 C)^2) $

График ове функције дат је на слици @fig-desmos, за вредности параметара $R_1 = 1$ k#sym.Omega, $R_2 = 20$ k#sym.Omega и $C = 3.9 "nF"$
(овај избор параметара биће јаснији у даљем тексту). На графику се види нагли пад између $10^3$ и $10^4 "Hz"$.

* TODO: овде прокоментарисати још инвертујућу карактеристику кола *

#figure(
  image("desmos.png"),
  caption: [График зависности напона од фреквенције у логаритамској скали за $R_1 = 1$ k#sym.Omega, $R_2 = 20$
  k#sym.Omega и $C = 3.9 "nF"$],
) <fig-desmos>

Приметимо да у изразу за $H(omega)$ фигурише однос $R_2 / R_1$, односно што је већи овај однос то је и појачање веће. Други члан
у овом изразу

$ 1 / sqrt(1 + (omega R_2 C)^2) $

можемо учинити врло слабо зависним од $omega$ за мале вредности $omega$ узимајући кондензатор $C$ вредности реда nF и отпорник
$R_2$ реда k#sym.Omega, јер је онда њихов производ реда $"~"10^(-6)$.

Овиме смо показали да се погодним избором параметара у колу може диктирати појачање и истовремено постићи жељени ефекат филтрирања
ниских фреквенција.

Дефинишемо граничну фреквенцију филтера $f_"cutoff"$ као ону фреквенцију при којој је појачање снаге сигнала једнако половини
максималног појачања, а како је снага пропорционална квадрату напона, то је:

$ H(2 pi f_"cutoff") &= 1/sqrt(2)H(0) $
$ 1 / sqrt(1 + (2 pi f_"cutoff" R_2 C)^2) &= 1 / sqrt(2) $
$ => f_"cutoff" = 1 / (2 pi R_2 C) $

За претходно поменуте вредности $R_1 = 1$ k#sym.Omega, $R_2 = 20$ k#sym.Omega и $C = 3.9$ nF добија се гранична фреквенција

$ f_"cutoff" = 1 / (2 pi dot 20 "k"#sym.Omega dot 3.9 "nF") approx 2 "kHz" $

што одговара очитавању са графика @fig-desmos.

== Симулација

За симулацију кола коришћен је програм LTSpice@LTSpice. Увезен је модел TL072 са странице произвођача@TL072.

#figure(
  image("lt-spice-circuit.png"),
  caption: [Шема електричног кола],
)

* TODO: прокоментарисати резултате *

#figure(
  image("lt-spice-graph.png"),
  caption: [Појачање добијено симулацијом],
)

#figure(
  image("lt-spice-cutoff.png"),
  caption: [TODO],
)

== Мерење

* TODO: у договору са професором направити одговарајуће табеле за резултате, приложити слике мерења и прокоментарисати резултате *

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [Volume], [Parameters],
    ),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height
      $D$: outer radius
      $d$: inner radius
    ],
    $ sqrt(2) / 12 a^3 $,
    [$a$: edge length]
  ),
  caption: "Пример табеле",
)
#pagebreak()

#bibliography("reference.bib", style: "ieee", title: "Референце")
