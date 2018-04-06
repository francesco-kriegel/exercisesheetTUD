% Author: Felix Distel (felix@tcs.inf.tu-dresden.de)
% Last Update: 2011/10/12
% Author: Francesco Kriegel (francesco@tcs.inf.tu-dresden.de)
% Last Update: 2018/03/28

% --- Identifikation --- %
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudscrexsht}[2018/03/28 LaTeX Class for Exercise Sheets in TUD Corporate Design (based on KOMA-Script class tudscrartcl)]

% --- Setzt auf tudform-Klasse auf --- %
\LoadClass[cdmath=off,cdfont=off]{tudscrartcl}
\RequirePackage[default]{opensans}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% \RequirePackage{selinput}\SelectInputMappings{adieresis={ä},germandbls={ß}}

% --- Option für sansmath Schriften --- %
\newif\if@sansmath
\@sansmathfalse
\DeclareOption{sansmath}{\@sansmathtrue}

% --- Option für mathpazo Schriften --- %
\newif\if@mathpazo
\@mathpazofalse
\DeclareOption{mathpazo}{\@mathpazotrue}
  
% --- Option für deutsche Sprache deklarieren --- %
\newif\if@german
\@germanfalse
\DeclareOption{german}{\@germantrue}

% --- Gewählte Optionen anwenden --- %
\ProcessOptions\relax

\if@sansmath
  \RequirePackage{sfmath}
\fi

\if@mathpazo
  \RequirePackage{mathpazo}
\fi

\if@german
  \PassOptionsToClass{ngerman}{tudscrartcl}
  \PassOptionsToPackage{ngerman}{babel}
  \PassOptionsToPackage{ngerman}{isodate}
  \faculty{Fakultät Informatik}
  \institute{Institut für Theoretische Informatik}
  \chair{Lehrstuhl für Automatentheorie}
  \newcommand{\@exercisesheet}{Übungsblatt}
  \newcommand{\@exercise}{Aufgabe}
  \newcommand{\@solution}{Lösung}
  \newcommand{\@hints}{Lösungshinweise}
  \newcommand{\@hint}{Hinweis}
\else
  \PassOptionsToClass{english}{tudscrartcl}
  \PassOptionsToPackage{english}{babel}
  \PassOptionsToPackage{english}{isodate}
  \faculty{Faculty of Computer Science}
  \institute{Institute of Theoretical Computer Science}
  \chair{Chair of Automata Theory}
  \newcommand{\@exercisesheet}{Exercise Sheet}
  \newcommand{\@exercise}{Exercise}
  \newcommand{\@solution}{Solution}
  \newcommand{\@hints}{Hints}
  \newcommand{\@hint}{Hint}
\fi

% --- Benötigte Pakete --- %
\RequirePackage{babel}
\RequirePackage{isodate}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{stmaryrd}
\RequirePackage{enumitem}\setlist{noitemsep,itemsep=1ex,topsep=1ex}%,leftmargin=*}
\RequirePackage{xspace}
\RequirePackage{ifthen}
\RequirePackage{verbatim}
\RequirePackage[all=normal,indent,floats,wordspacing,leading,charwidths,tracking]{savetrees} % INCOMPATIBLE OPTION (v2.05e): paragraphs
\RequirePackage{mathtools}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage{xparse}

\RequirePackage[
  pdfprintscaling=None,
  breaklinks=true,
  bookmarks=true,
  bookmarksnumbered=true,
  colorlinks=true,
  citecolor=black,
  filecolor=black,
  linkcolor=black,
  menucolor=black,
  urlcolor=black
]{hyperref}
\urlstyle{sf}

% --- Formatierungseinstellungen --- %
\linespread{1.2}
\def\arraystretch{1.3}
\renewcommand{\theenumi}{\alph{enumi}}
\renewcommand{\labelenumi}{(\theenumi)}
\renewcommand{\theenumii}{\roman{enumii}}
\renewcommand{\labelenumii}{(\theenumii)}

% --- Kommandos zum Definieren von Metadaten --- %
\title{}

\let\@date\undefined
\newcommand{\@date}{}
\let\date\undefined
\newcommand{\date}[2][]{%
  \if\relax\detokenize{#1}\relax%
    \renewcommand{\@date}{\printdate{#2}}%
  \else%
    \renewcommand{\@date}{\daterange{#1}{#2}}%
  \fi%
}

\newcommand{\@term}{}
\newcommand{\term}[1]{\renewcommand{\@term}{#1}}

\providecommand{\@course}{}
\providecommand{\course}[1]{\renewcommand{\@course}{#1}}

\newcommand{\@sheet}{}
\newcommand{\sheet}[1]{\renewcommand{\@sheet}{#1}}

\newcommand{\@topic}{}
\newcommand{\topic}[1]{\renewcommand{\@topic}{#1}}

\newcommand{\firstexercise}[1]{\addtocounter{exercise}{#1}\addtocounter{exercise}{-1}}

% --- Umgebung für Aufgaben --- %
\newtheoremstyle{bfnote}                                        % name
                {}                                              % space above
                {\baselineskip}                                 % space below
                {}                                              % body font
                {}                                              % indent amount
                {\bfseries}                                     % head font 
                {}                                              % punctuation after head
                {0.7em}                                         % space after head
                {\thmname{#1}\thmnumber{ \@sheet.#2}\thmnote{ (#3)}}
                                                                % head spec
\theoremstyle{bfnote}
\newtheorem{exercise}{\@exercise}

\newtheoremstyle{bfnote*}                                       % name
                {}                                              % space above
                {\baselineskip}                                 % space below
                {}                                              % body font
                {}                                              % indent amount
                {\bfseries}                                     % head font 
                {}                                              % punctuation after head
                {0.7em}                                         % space after head
                {\hspace{-0.7em}\clap{\raisebox{1pt}{$\ast$}}\hspace{0.7em}\thmname{#1}\thmnumber{ \@sheet.#2}\thmnote{ (#3)}}
                                                                % head spec
\theoremstyle{bfnote*}
\newtheorem{exercise*}[exercise]{\@exercise}

% --- Umgebung für Hinweise --- %
\NewDocumentCommand{\rotateandreflect}{ >{\SplitList{ }} m }{%
  \ProcessList{#1}{\rotateandreflectsingle}%
}
\NewDocumentCommand{\rotateandreflectsingle}{m}{%
  \rotatebox[origin=c]{180}{\noindent\reflectbox{\vphantom{Ag}#1}} % a space follows
}
\theoremstyle{remark}
\newtheorem*{hint}{\@hint}
\NewEnviron{hint*}{%
  \begin{hint}%
    \expandafter\expandafter\expandafter\rotateandreflect\expandafter{\BODY}%
  \end{hint}%
}

% --- Kommandos zum Aktivieren/Deaktivieren der Ausgabe von Lösungen --- %
\newcommand{\@printsolutions}{false}
\newcommand{\printsolutions}{\renewcommand{\@printsolutions}{true}}
\newcommand{\ifthenelseprintsolutions}[2]{\ifthenelse{\equal{\@printsolutions}{true}}{#1}{#2}}
\newcommand{\ifprintsolutions}[1]{\ifthenelseprintsolutions{#1}{}}
\newcommand{\ifnotprintsolutions}[1]{\ifthenelseprintsolutions{}{#1}}

% --- Umgebung für Lösungen --- %
\newenvironment{solution}{%
  \ifthenelseprintsolutions%
    {\begin{proof}[\@solution]}%
    {\expandafter\comment}%
}{%
  \ifthenelseprintsolutions%
    {\end{proof}\clearpage}%
    {\expandafter\endcomment}%
}

% --- Kopf des Dokuments --- %
\AtBeginDocument{%
  \ifthenelse{\equal{\@title}{}}{%
    \def\exsht@title{\@exercisesheet~\@sheet}%
    \ifthenelse{\equal{\@topic}{}}{}{%
      \edef\exsht@title{\exsht@title~--~\@topic}%
    }%
    \ifprintsolutions{%
      \edef\exsht@title{\exsht@title~--~\@hints}%
    }%
    \title\exsht@title%
  }{}%
  \maketitle%
}

\renewcommand{\maketitle}[1][]{%
  \thispagestyle{tudheadings}%
  \vspace*{23mm}%
  \noindent%
  {\Large\bfseries\@course}~\hfill~\@term\\[1ex]%
  {\large{\bfseries\@title}}~\hfill~\@date\\[1ex]%
  {\@author}\\%
  % \smallskip%
}

% --- PDF Metadaten --- %
\AtBeginDocument{
  \makeatletter
    \hypersetup{%
      pdftitle={\@course},%
      pdfauthor={\@author},%
      pdfkeywords={\@course}}%
  \makeatother
}
