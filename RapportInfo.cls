\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RapportInfo}[1.0]
\LoadClass[11pt,a4paper]{article}

%%%%%%%%%%%%% Extensions %%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\RequirePackage{tabto}
\RequirePackage[utf8]{inputenc}
\RequirePackage[left=2cm,right=2cm,top=2.5cm,bottom=2.5cm]{geometry}
\RequirePackage[backend=biber,sorting=none]{biblatex}
\RequirePackage{graphicx}
\RequirePackage{textcomp}
\RequirePackage{tcolorbox}
\RequirePackage{xcolor}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{bbm}
\RequirePackage{float}

%%%%%%%%%%%%% Paramètres %%%%%%%%%%%%%
\setlength{\headheight}{15pt}
\setlength\bibitemsep{2\itemsep}
\pagestyle{fancy}


%%%%%%%%%%%%% Couleurs blocs de code %%%%%%%%%%%%%
\definecolor{colorBack}{rgb}{0.95,0.95,0.92}
\definecolor{colorComment}{rgb}{0,0.6,0}
\definecolor{colorKeyword}{rgb}{0.5,0.5,0.5}
\definecolor{colorString}{rgb}{0.58,0,0.82}

%%%%%%%%%%%%% Variables personnelles %%%%%%%%%%%%%
\newcommand*{\matiere}[1]{\def\@matiere{#1}}
\newcommand*{\lieu}[1]{\def\@lieu{#1}}
\newcommand*{\WIP}[1]{\def\@WIP{#1}}
\newcommand*{\EOF}{\texttt{EOF}}
\newcommand*{\titreSommaire}[1]{\def\@titreSommaire{#1}}
\newcommand*{\langue}[1]{\def\@langue{#1}}

%%%%%%%%%%%%% Compteurs personnels %%%%%%%%%%%%%
%\newtotcounter{wipnb}
%\regtotcounter{wipnb}

%%%%%%%%%%%%% Gestion des graphiques %%%%%%%%%%%%%
\graphicspath{{img}}
\setkeys{Gin}{width=.5\paperwidth}
\def\fps@figure{!h}

%%%%%%%%%%%%% Valeurs par défaut %%%%%%%%%%%%%
\title{Mon titre}
\author{Auteurs}
\matiere{Matière}
\lieu{Lieu}
\date{\today}
\WIP{-NON FONCTIONNEL-}
\titreSommaire{Sommaire}
\langue{french}


%%%%%%%%%%%%% Package Parametrable %%%%%%%%%%%%%
\RequirePackage[\@langue]{babel}
\RequirePackage{csquotes}
\RequirePackage[T1]{fontenc}
\RequirePackage{listings}

%%%%%%%%%%%%% Style %%%%%%%%%%%%%
\lhead{\@lieu}
\rhead{\@date}
\rfoot{\@author}

%%%%%%%%%%%%% Commandes personnelles %%%%%%%%%%%%%
% \funcr - Affiche un bloc fonction
% \parx - Fait un alinéa
% \makeheader - Affiche l'entête


%\makeheader
% Affiche le bloc d'entête avec les informations suivantes : Titre, matière, auteurs
% Se place après le \begin{Document}
\newcommand{\makeheader}{
    \NumTabs{1}
    \TabPositions{4cm}
    \fbox{\parbox{15.7cm}{\centering\textbf{\Large{\@title}} \\ \vspace{0.17cm} \@matiere \\ \vspace{0.13cm} \@author }} \vspace{0.5cm}
    \medskip

}

%\funcr{#1}{#2}{#3}{#4}
% Réalise l'affichage d'un bloc de fonction avec
%   #1 : La signature de la fonction. Ex : int Myfunc(arg1,arg2)
%   #2 : La description de la fonction
%   #3 : Les paramètres de la fonction sous forme d'une liste à item. Ex : \item arg1 : Mon premier argument \item arg2 : Mon deuxième argument
%   #4 : La valeur de retour de la fonction.

\newcommand\funcr[4]{
    \begin{tcolorbox}
        \subsection*{\hspace{0.5cm} #1}
        #2
        
        \ifthenelse{\equal{\detokenize{#3}}{}}{}{
            \textit{Paramètres :}
            \begin{itemize}
                #3
            \end{itemize}
        }
        
        \ifthenelse{\equal{#4}{}}{}{
            \textit{Retour :}
            \begin{itemize}
                \item #4
            \end{itemize}
        }
    \end{tcolorbox}
}

%\parx
% Fait un alinéa forcé dans n'importe quel partie du document
\newcommand{\parx}{\hspace{\parindent}}

%\hrefx
% Ajoute une hyperréference en bleu
\newcommand{\hrefx}[2]{\href{#1}{\textcolor{blue}{#2}}}

%\ra
% Affiche une flèche vers la droite
\newcommand{\ra}{$\rightarrow$~}

%\la
% Affiche une flèche vers la droite
\newcommand{\la}{$\leftarrow$~}

%\nlx
% Crée un saut de ligne dans les espaces ou c'est impossible
\newcommand{\nlx}{\vspace{0.5cm}}

%\fullref{#1}
% Affiche une référence vers #1 avec le nom complet (nom, numéro et label de l'objet)
\newcommand*\fullref[1]{\hyperref[{#1}]{\autoref*{#1}, \nameref*{#1}}} % One single link

\let\oldappendix\appendix
\renewcommand\appendix{
    \pagebreak
    \section*{Annexes}
    \addcontentsline{toc}{section}{Annexes}
    \oldappendix
    \addtocontents{toc}{\setcounter{tocdepth}{0}}
    \renewcommand*{\thesection}{Annexe~\Alph{section}}
}

%\begin{code}[<language>]
% Créer un bloc de code qui colore automatiquement avec le language passé en paramètre
\lstnewenvironment{code}[1][python]
{\lstset{language=#1}}{}
%%%%%%%%%%%%% Block de code %%%%%%%%%%%%%
\lstdefinestyle{codeBlocs}{
    backgroundcolor=\color{colorBack},   
    commentstyle=\color{colorComment},
    keywordstyle=\color{colorKeyword},
    stringstyle=\color{colorString},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,
    frame=single,
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=none,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2
}

\lstset{style=codeBlocs}


%%%%%%%%%%%%% Fait au début du document %%%%%%%%%%%%%
\AtBeginDocument{

    %%%%%%%%%%%%% Corrige le titre du sommaire %%%%%%%%%%%%%
    \renewcommand{\contentsname}{\@titreSommaire}

    %%%%%%%%%%%%% Affiche l'encadré d'en tête %%%%%%%%%%%%%
    \makeheader

    %%%%%%%%%%%%% Crée la variable WIP %%%%%%%%%%%%%
    \makeatletter
    \renewcommand{\WIP}{
        \textbf{\textcolor{red}{\@WIP}}\\
    }
    \makeatother

    %%%%%%%%%%%%% Sommaire %%%%%%%%%%%%%    
    \tableofcontents

    %%%%%%%%%%%%% Paramètres de Babel %%%%%%%%%%%%%
    \frenchbsetup{
      ItemLabels=\textbullet,
      og=\string ",
      fg=\string "
    }

    %%%%%%%%%%%%% Document Imposant %%%%%%%%%%%%%
    \newpage
}
