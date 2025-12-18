#set text(
  size: 12pt,
)

#show link: it => underline(offset: 2pt, text(fill: blue, it))

#show heading: it => block(
  above: 1.8em,
  below: 1.2em,
  it,
)

#show figure: it => block(
  below: 2em,
  it,
)

#set page(numbering: "1")
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)")

= Projekat iz Teorije Električnih Kola

== Zadatak
Zadatak je analizirati, sastaviti i izmeriti odziv sledećeg kola.
#figure(
  image("circuit.svg"),
  caption: [Šema električnog kola],
)

Ovo kolo predstavlja *pojačavački invertujući filter niskih frekvencija*@TI. U daljem radu ćemo odrediti i demonstrirati na koji način
se podešavanjem njegovih parametara mogu dobiti željeni efekti.


== Proračun
Za potrebe proračuna podrazumevaćemo da je operacioni pojačavač idealan, kao na slici @fig-ideal-circuit.
// ovde bismo jos mogli da kazemo nesto za to kako cemo razlike videti kada izmerimo stvari itd

#figure(
  image("ideal-circuit.svg"),
  caption: [Šema idealnog električnog kola],
) <fig-ideal-circuit>

Dato kolo ćemo analizirati za prostoperiodični ulazni naponski signal $V_"in"=A sin(omega t + phi)$. Kako je kolo relativno niske kompleksnosti rešićemo ga ručno, u kompleksnom domenu.

Želimo da izrazimo izlazni napon $underline(V_"out")$ preko ulaznog napona $underline(V_"in")$ i parametara kola $R_1$, $R_2$ i $C$.

Zamenićemo paralelnu vezu otpornika $R_2$ i kondenzatora $C$ ekvivalentnom impendansom $Z$

$ underline(Z) = (R_2 dot 1 / (j omega C)) / (R_2 + 1 / (j omega C)) = R_2 / (1 + j omega R_2 C) $

kao na slici @fig-transformed-notated-circuit.

#figure(
  image("transformed-notated-circuit.svg"),
  caption: [Transformisano električno kolo],
) <fig-transformed-notated-circuit>

Sada je struja kroz $R_1$ i $Z$ jednaka. Označimo je sa $I$. Primetimo li još da je čvor kola koji odgovara invertujućem terminalu
idealnog operacionog pojačavača jednak nuli, možemo izračunati struju $I$ primenjujući KZN kao

$ underline(I) = underline(V_"in") / R_1 $

Sada lako pronalazimo izlazni napon $V_"out"$ kao

$ underline(V_"out") &= - underline(Z) underline(I) \
&= - R_2 / (1 + j omega R_2 C) dot underline(V_"in") / R_1 \
&= - R_2 / R_1 dot 1 / (1 + j omega R_2 C) dot underline(V_"in") $

Ovaj rezulat možemo predstaviti i u obliku prenosne funkcije $H(omega)$

$ underline(H)(omega) = underline(V_"out") / underline(V_"in") = - R_2 / R_1 dot 1 / (1 + j omega R_2 C) $

Odnosno za efektivne vrednosti dobijamo

$ H(omega) = R_2 / R_1 dot 1 / sqrt(1 + (omega R_2 C)^2) $

Grafik ove funkcije dat je na slici @fig-desmos, za vrednosti parametara $R_1 = 1$ k#sym.Omega, $R_2 = 20$ k#sym.Omega i $C = 3.9 "nF"$
(ovaj izbor parametara biće jasniji u daljem tekstu). Na grafiku se vidi nagli pad između $10^3$ i $10^4 "Hz"$.

#figure(
  image("desmos.png"),
  caption: [Grafik zavisnosti napona od frekvencije u logaritamskoj skali za $R_1 = 1$ k#sym.Omega, $R_2 = 20$
  k#sym.Omega i $C = 3.9 "nF"$],
) <fig-desmos>

Primetimo da u izrazu za $H(omega)$ figuriše odnos $R_2 / R_1$, odnosno što je veći ovaj odnos to je i pojačanje veće. Drugi član
u ovom izrazu 

$ 1 / sqrt(1 + (omega R_2 C)^2) $

možemo učiniti vrlo slabo zavisnim od $omega$ za male vrednost $omega$ uzimajući kondenzator $C$ vrednosti reda nF i otpornika
$R_2$ reda k#sym.Omega, jer je onda njihov proizvod reda $"~"10^(-6)$.

Ovime smo pokazali da se pogodnim izborom parametara u kolu, može diktirati pojačanje i istovremeno postići željeni efekat filtriranja 
niskih frekvencija.

Definišemo graničnu frekvenciju filtera $f_"cutoff"$ kao onu frekvenciju pri kojoj je pojačanje snage signala jednako polovini
maksimalnog pojačanja, a kako je snaga proporcionalna kvadratu napona, to je:

$ H(2 pi f_"cutoff") &= 1/sqrt(2)H(0) $
$ 1 / sqrt(1 + (2 pi f_"cutoff" R_2 C)^2) &= 1 / sqrt(2) $
$ => f_"cutoff" = 1 / (2 pi R_2 C) $

Za prethodno pomenute vrednosti $R_1 = 1$ k#sym.Omega, $R_2 = 20$ k#sym.Omega i $C = 3.9$ nF dobija se granična frekvencija

$ f_"cutoff" = 1 / (2 pi dot 20 "k"#sym.Omega dot 3.9 "nF") approx 2 "kHz" $

što odgovara očitavanju sa grafika @fig-desmos.

== Simulacija

Za simulaciju kola korišćen je program LTSpice@LTSpice. Uvezen je model TL072@TL072

#figure(
  image("lt-spice-circuit.png"),
  caption: [Šema električnog kola],
)

neki tekst

#figure(
  image("lt-spice-graph.png"),
  caption: [Pojačanje dobijeno simulacijom],
)

#figure(
  image("lt-spice-cutoff.png"),
  caption: [Pojačanje dobijeno simulacijom],
)

#pagebreak()


#bibliography("reference.bib", style: "ieee", title: "Reference")
