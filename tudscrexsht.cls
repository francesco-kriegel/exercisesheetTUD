% Author: Felix Distel (felix@tcs.inf.tu-dresden.de)
% Last Update: 2011/10/12
% Author: Francesco Kriegel (francesco@tcs.inf.tu-dresden.de)
% Last Update: 2016/10/11


% --- Identifikation ---
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudscrexsht}[2016/03/29 LaTeX Class for Exercise Sheets in TUD Corporate Design (based on KOMA-Script class tudscrartcl)]


% --- Setzt auf tudform-Klasse auf ---
\LoadClass[english,cdmath=off]{tudscrartcl} %ngerman


% --- Benoetigte Pakete ---
%\RequirePackage{selinput}\SelectInputMappings{adieresis={ä},germandbls={ß}}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage[english]{isodate}

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
\RequirePackage{mathpazo}
\RequirePackage{environ}
\RequirePackage{scalerel}
\RequirePackage{multicol}
\RequirePackage{xparse}

%\RequirePackage{amsfonts}
%\RequirePackage{parskip}
%\RequirePackage{lmodern}
%\RequirePackage{wasysym}
%\RequirePackage{geometry}
%\RequirePackage{fixltx2e}
%\RequirePackage{sfmath}
%\RequirePackage{pdflscape}
%\RequirePackage{tikz}
%\usetikzlibrary{arrows,automata,positioning}

\linespread{1.2}
\def\arraystretch{1.3}


% --- Option fuer deutsche Sprache deklarieren ---
\DeclareOption{german}{
  \faculty{Fakultät Informatik}
  \institute{Institut für Theoretische Informatik}
  \chair{Lehrstuhl für Automatentheorie}
  \renewcommand{\@exercisesheet}{Übungsblatt}
  \renewcommand{\@exercise}{Aufgabe}
  \renewcommand{\@solution}{Lösung}
  \renewcommand{\@hints}{Lösungshinweise}
  \renewcommand{\@hint}{Hinweis}
}


% --- Sprachspezifika ---
\faculty{Faculty of Computer Science}
\institute{Institute of Theoretical Computer Science}
\chair{Chair of Automata Theory}
\title{}
\newcommand{\@exercisesheet}{Exercise Sheet}
\newcommand{\@exercise}{Exercise}
\newcommand{\@solution}{Solution}
\newcommand{\@hints}{Hints}
\newcommand{\@hint}{Hint}

\ProcessOptions\relax

\newcommand{\@term}{}
%\newcommand{\@course}{}
\newcommand{\@sheet}{}
\newcommand{\@topic}{}
\newcommand{\term}[1]{\renewcommand{\@term}{#1}}
%\newcommand{\course}[1]{\renewcommand{\@course}{#1}}
\newcommand{\sheet}[1]{\renewcommand{\@sheet}{#1}}
\newcommand{\topic}[1]{\renewcommand{\@topic}{#1}}
\newcommand{\firstexercise}[1]{\addtocounter{exercise}{#1}\addtocounter{exercise}{-1}}

\newcommand{\@printsolutions}{false}
\newcommand{\printsolutions}{\renewcommand{\@printsolutions}{true}}
\newcommand{\ifthenelseprintsolutions}[2]{\ifthenelse{\equal{\@printsolutions}{true}}{#1}{#2}}
\newcommand{\ifprintsolutions}[1]{\ifthenelseprintsolutions{#1}{}}
\newcommand{\ifnotprintsolutions}[1]{\ifthenelseprintsolutions{}{#1}}


% --- Neue Umgebungen ---
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

% \newenvironment{exercise}[1][]{
%   \noindent
%   \begin{minipage}{\linewidth}
%   \begin{ex}[#1]
% }{
%   \end{ex}
%   \end{minipage}
% }
% \newenvironment{exercise*}[1][]{
%   \noindent
%   \begin{minipage}{\linewidth}
%   \begin{ex*}[#1]
% }{
%   \end{ex*}
%   \end{minipage}
% }
\newenvironment{solution}{
  \ifthenelseprintsolutions
    {\begin{proof}[\@solution]}
    {\expandafter\comment}
}{
  \ifthenelseprintsolutions
    {\end{proof}\clearpage}
    {\expandafter\endcomment}
}

\theoremstyle{remark}
\newtheorem*{hint}{\@hint}
  
\NewDocumentCommand{\rotateandreflect}{ >{\SplitList{ }} m }{%
  \ProcessList{#1}{\rotateandreflectsingle}%
}
\NewDocumentCommand{\rotateandreflectsingle}{m}{%
  \rotatebox[origin=c]{180}{\noindent\reflectbox{\vphantom{Ag}#1}} % a space follows
}


% --- Kopf des Dokuments ---

\AtBeginDocument{
  \ifthenelse{\equal{\@title}{}}{
    \def\exsht@title{\@exercisesheet~\@sheet}
    \ifthenelse{\equal{\@topic}{}}{}{
      \edef\exsht@title{\exsht@title~--~\@topic}
    }
    \ifprintsolutions{
      \edef\exsht@title{\exsht@title~--~\@hints}
    }
    \title\exsht@title
%     \ifthenelse{\equal{\@topic}{}}{
%       \ifthenelseprintsolutions{
%         \title{\@exercisesheet~\@sheet~--~\@hints}
%       }{
%         \title{\@exercisesheet~\@sheet}
%       }
%     }{
%       \ifthenelseprintsolutions{
%         \title{\@exercisesheet~\@sheet~--~\@topic~--~\@hints}
%       }{
%         \title{\@exercisesheet~\@sheet~--~\@topic}
%       }
%     }
  }{}
  \maketitle
}

\renewcommand{\maketitle}[1][]{
  \thispagestyle{tudheadings}
  \vspace*{23mm}
  \noindent
  {\Large\bfseries\@course}~\hfill~\@term\\[1ex]
  {\large{\bfseries\@title}}~\hfill~\@date\\[1ex]
  {\@author}\\
%   \smallskip
}
\renewcommand{\theenumi}{\alph{enumi}}%
\renewcommand{\labelenumi}{(\theenumi)}%
\renewcommand{\theenumii}{\roman{enumii}}%
\renewcommand{\labelenumii}{(\theenumii)}%


% --- Mathematische Makros ---
\let\Bbb\undefined
\newcommand{\Cbf}{\ensuremath{\mathbf{C}}\xspace}

\def\alphabet{A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z}
\newcommand{\mydef}[2]{\expandafter#1\expandafter{\csname#2\endcsname}}
\newcommand{\myforcsvlist}[2]{\expandafter\forcsvlist\expandafter#1\expandafter{#2}}

\newcommand{\defmc}[1]{\mydef{\newcommand}{#1mc}{\ensuremath{\mathcal{#1}}\xspace}}
\newcommand{\defmf}[1]{\mydef{\newcommand}{#1mf}{\ensuremath{\mathfrak{#1}}\xspace}}
\newcommand{\defbb}[1]{\mydef{\newcommand}{#1bb}{\ensuremath{\mathbb{#1}}\xspace}}
\newcommand{\deful}[1]{\mydef{\newcommand}{#1ul}{\ensuremath{\underline{#1}}\xspace}}

\myforcsvlist{\defmc}{\alphabet}
\myforcsvlist{\defmf}{\alphabet}
\myforcsvlist{\defbb}{\alphabet}
\myforcsvlist{\deful}{\alphabet}

\DeclareMathOperator{\Powerset}{\scaleobj{1.3}{\wp}}
\newcommand{\Exists}{\exists\,}
\newcommand{\Forall}{\forall\,}
\newcommand{\colonLeftrightarrow}{\mathrel{\vcentcolon\mkern-2mu\Leftrightarrow}}

%\def\sflist{}
%\newcommand{\defsf}[1]{\mydef{\DeclareMathOperator}{#1}{\mathsf{#1}}}
%\myforcsvlist{\defsf}{\sflist}

\newcommand{\menge}[3][0]{
  \ifthenelse{\equal{#1}{0}}{\ensuremath{\left\{\,#2\:\middle|\:#3\,\right\}}
  }{\ifthenelse{\equal{#1}{1}}{\ensuremath{\{\,#2\:|\:#3\,\}}
    }{\ifthenelse{\equal{#1}{2}}{\ensuremath{\big\{\,#2\:\big|\:#3\,\big\}}
      }{\ifthenelse{\equal{#1}{3}}{\ensuremath{\Big\{\,#2\:\Big|\:#3\,\Big\}}
        }{\ifthenelse{\equal{#1}{4}}{\ensuremath{\bigg\{\,#2\:\bigg|\:#3\,\bigg\}}
          }{\ifthenelse{\equal{#1}{5}}{\ensuremath{\Bigg\{\,#2\:\Bigg|\:#3\,\Bigg\}}
            }{Error}}}}}}}

\newcommand{\card}[2][0]{
  \ifthenelse{\equal{#1}{0}}{\ensuremath{\left|#2\right|}
  }{\ifthenelse{\equal{#1}{1}}{\ensuremath{|#2|}
    }{\ifthenelse{\equal{#1}{2}}{\ensuremath{\big|#2\big|}
      }{\ifthenelse{\equal{#1}{3}}{\ensuremath{\Big|#2\Big|}
        }{\ifthenelse{\equal{#1}{4}}{\ensuremath{\bigg|#2\bigg|}
          }{\ifthenelse{\equal{#1}{5}}{\ensuremath{\Bigg|#2\Bigg|}
            }{Error}}}}}}}

\newcommand{\meng}[2][0]{
  \ifthenelse{\equal{#1}{0}}{\ensuremath{\left\{#2\right\}}
  }{\ifthenelse{\equal{#1}{1}}{\ensuremath{\{#2\}}
    }{\ifthenelse{\equal{#1}{2}}{\ensuremath{\big\{#2\big\}}
      }{\ifthenelse{\equal{#1}{3}}{\ensuremath{\Big\{#2\Big\}}
        }{\ifthenelse{\equal{#1}{4}}{\ensuremath{\bigg\{#2\bigg\}}
          }{\ifthenelse{\equal{#1}{5}}{\ensuremath{\Bigg\{#2\Bigg\}}
            }{Error}}}}}}}
