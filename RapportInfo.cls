\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{RapportInfo}[1.0]
\LoadClass[11pt,a4paper]{article}

%%%%%%%%%%%%% TODO %%%%%%%%%%%%%

% Rendre les paramètres de matière et autre optionnels (A voir comment faire)

%%%%%%%%%%%%% Extensions %%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\RequirePackage{tabto}
\RequirePackage[utf8]{inputenc}
\RequirePackage[left=2cm,right=2cm,top=2.5cm,bottom=2.5cm]{geometry}
\RequirePackage[backend=biber,sorting=none]{biblatex}
\RequirePackage{graphicx}
\RequirePackage{textcomp}
\RequirePackage{xcolor}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{bbm}
\RequirePackage{float}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{ifthen}
\RequirePackage{caption}


%%%%%%%%%%%%% Paramètres %%%%%%%%%%%%%
\setlength{\headheight}{15pt}
\setlength\bibitemsep{2\itemsep}
\pagestyle{fancy}

%%%%%%%%%%%%% Macro de définition des commandes d'environnement %%%%%%%%%%%%%

\ExplSyntaxOn
\NewDocumentCommand{\newenvcommand}{ m m }
  {
   \cs_if_exist:cF { g_envc_#1_list_tl } { \tl_new:c { g_envc_#1_list_tl } }
   \tl_gput_right:cn { g_envc_#1_list_tl } { #2 }
   \exp_after:wN \newcommand \cs:w envc_#1_\cs_to_str:N #2 \cs_end:
  }
\NewDocumentCommand{\checkenvcommands}{ }
  {
   \cs_if_exist:cT { g_envc_\use:c {@currenvir} _list_tl }
     {
      \tl_map_inline:cn { g_envc_\use:c {@currenvir} _list_tl }
        { \cs_set_eq:Nc ##1 { envc_\use:c {@currenvir} _\cs_to_str:N ##1 } }
     }
  }
\ExplSyntaxOff

%%%%%%%%%%%%% Couleurs blocs de code %%%%%%%%%%%%%
\definecolor{colorBack}{rgb}{0.95,0.95,0.92}
\definecolor{colorComment}{rgb}{0,0.6,0}
\definecolor{colorKeyword}{rgb}{0.5,0.5,0.5}
\definecolor{colorString}{rgb}{0.58,0,0.82}

%%%%%%%%%%%%% Variables personnelles %%%%%%%%%%%%%
\newcommand*{\matiere}[1]{\def\@matiere{#1}}
\newcommand*{\lieu}[1]{\def\@lieu{#1}}
\newcommand*{\auteur}[1]{\author{#1}}
\newcommand*{\titre}[1]{\title{#1}}
\newcommand*{\WIP}[1]{\def\@WIP{#1}}
\newcommand*{\NOTSOLVED}[1]{\def\@notsolv{#1}}
\newcommand*{\EOF}{\texttt{EOF}}
\newcommand*{\titreSommaire}[1]{\def\@titreSommaire{#1}}
\newcommand*{\langue}[1]{\def\@langue{#1}}
\newif\ifisbigdocument
\newif\iftoc

%%%%%%%%%%%%% Compteurs personnels %%%%%%%%%%%%%
% Création du compteur pour les bugs
\newcounter{bugcounter}


%%%%%%%%%%%%% Gestion des graphiques %%%%%%%%%%%%%
\graphicspath{{img}}
\setkeys{Gin}{width=.5\paperwidth}
\def\fps@figure{!h}

%%%%%%%%%%%%% Valeurs par défaut %%%%%%%%%%%%%
\title{Titre}
\author{Auteurs}
\matiere{Matière}
\lieu{Lieu}
\date{\today}
\WIP{-NON FONCTIONNEL-}
\NOTSOLVED{-- NON RÉSOLU --}
\titreSommaire{Sommaire}
\langue{french}


%%%%%%%%%%%%% Package Parametrable %%%%%%%%%%%%%
\RequirePackage[\@langue]{babel}
\RequirePackage{csquotes}
\RequirePackage[T1]{fontenc}
\RequirePackage[most]{tcolorbox}
\RequirePackage{listings}

%%%%%%%%%%%%% Style %%%%%%%%%%%%%
\lhead{\@lieu}
\rhead{\@date}
\rfoot{\@author}

%%%%%%%%%%%%% Commandes personnelles %%%%%%%%%%%%%

%\makeheader
% Affiche le bloc d'entête avec les informations suivantes : Titre, matière, auteurs
% Se place après le \begin{Document}
\newcommand{\makeheader}{
    \NumTabs{1}
    \TabPositions{4cm}
    \fbox{\parbox{15.7cm}{\centering\textbf{\Large{\@title}} \\ \vspace{0.17cm} \@matiere \\ \vspace{0.13cm} \@author }} \vspace{0.5cm}
    \medskip

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

%\appendix
% Créer un paragraphe annexe pour le document
\let\oldappendix\appendix
\renewcommand\appendix{
    \pagebreak
    \section*{Annexes}
    \addcontentsline{toc}{section}{Annexes}
    \oldappendix
    \addtocontents{toc}{\setcounter{tocdepth}{0}}
    \renewcommand*{\thesection}{Annexe~\Alph{section}}
}

%\bigdocument
% Indique que le document est long
\newcommand{\bigdocument}{\isbigdocumenttrue}

%\toc
% Affiche le sommaire
\newcommand{\toc}{\toctrue}

%\bigmsgx
% Affiche un message en gros dans le texte
\newcommand{\bigmsgx}[1]{
    \Large\textbf{\textcolor{red}{-- #1 -- }}\normalsize
}

%\tocorrectx
% Indique que du texte est à corriger
\newcommand{\tocorrectx}[1]{
    \textcolor{red}{[X] #1 [X]}
}

%\mcx
% Créer un mini-block de code sur une ligne (comme `code` en markdown)
\newtcbox{\mcx}{on line, colback=gray!30, colframe=gray!80, boxrule=0.5pt, arc=3pt, boxsep=0pt, left=2pt, right=2pt, top=2pt, bottom=2pt}

%\labelx
% Créer un label à la ligne exact ou il est
\newcommand{\labelx}[1]{
    \hypertarget{#1}{}
}

\newcommand{\refx}[2]{
    \hyperlink{#1}{#2}
}

%\begin{code}[<language>]
% Créer un bloc de code qui colore automatiquement avec le language passé en paramètre
\lstnewenvironment{code}[1][python]
{\lstset{language=#1}}{}

%%%%%%%%%%%%% Block de code %%%%%%%%%%%%%
\definecolor{lightgray}{rgb}{.9,.9,.9}
\definecolor{darkgray}{rgb}{.4,.4,.4}
\definecolor{purple}{rgb}{0.65, 0.12, 0.82}
\lstdefinelanguage{JavaScript}{
  keywords={abstract, any, as, boolean, break, case, catch, class, console, 
    const, continue, debugger, declare, default, delete, do, else, enum, export, extends, false, finally, for, from, function, get, if, implements, import, in, infer, instanceof, interface, keyof, let, module, namespace, never, new, null, number, object, package, private, protected, public, readonly, require, return, set, static, string, super, switch, symbol, this, throw, true, try, type, typeof, undefined, unique, unknown, var, void, while, with, yield},
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
  ndkeywords={class, export, boolean, throw, implements, import, this},
  keywordstyle=\color{blue}\bfseries,
  ndkeywordstyle=\color{darkgray}\bfseries,
  identifierstyle=\color{black},
  commentstyle=\color{purple}\ttfamily,
  stringstyle=\color{red}\ttfamily,
  sensitive=true
}


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

%%%%%%%%%%%%% Block funcr %%%%%%%%%%%%%

% Créé un block de description de fonction

% Ce block définit les commande suivantes :
%\signature{#1} Donne la signature de la fonction
%\desc{#1} Ajoute de la description à la fonction
%\param{#1} Ajoute un paramètre à la fonction
%\return{#1} Ajoute une valeur de retour à la fonction

%%% Commande d'environnement %%%
% Stocke la signature spécifiée
\newenvcommand{funcr}{\signature}[1]{\def\signaturetext{#1}} 

% Stocke la description spécifiée
\newenvcommand{funcr}{\desc}[1]{\def\desctext{#1}} 

% Commandes pour ajouter des paramètres et retours
\newenvcommand{funcr}{\param}[1]{\gappto\paramlist{\item #1}}

\newenvcommand{funcr}{\return}[1]{\gappto\returnlist{\item #1}}

% Définition de l'environnement "funcrblock"
\newenvironment{funcr}
{   
    \checkenvcommands
    \begin{tcolorbox}[breakable,enhanced]
        % Initialisation des variables locales
        \def\signaturetext{} % Initialise la signature
        \def\desctext{} % Initialise la description
        \def\paramlist{} % Initialise la liste des paramètres
        \def\returnlist{} % Initialise la liste des retours
}
{
    % Affichage de la signature si définie
    \ifstrempty{\signaturetext}{}{% Si \signaturetext n'est pas vide, l'afficher
        \subsection*{\hspace{0.5cm} \signaturetext}
    }
    
    % Affichage de la description si définie
    \ifstrempty{\desctext}{}{% Si \desctext n'est pas vide, l'afficher
        \desctext \par\medskip % Ajoute un saut de ligne
    }
    
    % Affichage des paramètres si définis
    \ifstrempty{\paramlist}{}{% Si \paramlist n'est pas vide, l'afficher
        \textit{Paramètres :}
        \begin{itemize}
            \paramlist
        \end{itemize}
    }
    
    % Affichage du retour si défini
    \ifstrempty{\returnlist}{}{% Si \returnlist n'est pas vide, l'afficher
        \textit{Retour :}
        \begin{itemize}
            \returnlist
        \end{itemize}
    }
    
    \end{tcolorbox}
}

%%%%%%%%%%%%% Bloc bugr %%%%%%%%%%%%%

% Créé un block de description de bug

% Ce block accepte un titre optionnel en paramètres 
% Ce block définit les commande suivantes :
%\contextx Démarre la section "Contexte"
%\desiredx Démarre la section "Comportement souhaité"
%\bugx Démarre la section "Erreur"
%\solutionx Démarre la section "Solution"


% Démmarre la section "Contexte"
\newcommand{\contextx}[1][]{
    \ifthenelse{\equal{#1}{}}
    {\par\textbf{Contexte :}}
    {\par\textbf{#1}}\par
}

% Démarre la section "Comportement souhaité"
\newcommand{\desiredx}[1][]{
     \ifthenelse{\equal{#1}{}}
     {\par\medskip\textbf{Résultat désiré :}}
     {\par\medskip\textbf{#1}}\par
}

% Démarre la section "Erreur"
\newcommand{\bugx}[1][]{
     \ifthenelse{\equal{#1}{}}
     {\par\medskip\textbf{Erreur :}}
     {\par\medskip\textbf{#1}}\par
}

% Démarre la section "Research"
\newcommand{\researchx}[1][]{
     \ifthenelse{\equal{#1}{}}
     {\par\medskip\textbf{Recherche :}}
     {\par\medskip\textbf{#1}}\par
}

% Démarre la section "Solution"
\NewDocumentCommand{\solutionx}{O{}}{
    \ifthenelse{\equal{#1}{}}
     {\par\medskip\textbf{Solution :}}
     {\par\medskip\textbf{#1}}\par
     
    \gdef\solutiongiven{1}
}

% Création de l'environnement "bugr" avec un titre optionnel
\newenvironment{bugr}[1][]{ 
    % Incrémente le compteur de bugs
    \stepcounter{bugcounter}
    % Initialise la variable pour la solution donnée
    \gdef\solutiongiven{0} 

    \begin{tcolorbox}[title=Bug n°\arabic{bugcounter}\ifx&#1&\else: #1\fi, 
                      colframe=red!75!black, 
                      colback=red!10, 
                      breakable,
                      enhanced]
        \ignorespaces
    }{
        % Si aucune solution n'est fournie, afficher "Non résolu"
        \ifnum\solutiongiven=0
            \par\nlx\textbf{\@notsolv}
        \fi
    \end{tcolorbox}
}


%%%%%%%%%%%%% Fait au début du document %%%%%%%%%%%%%
\AtBeginDocument{

    %%%%%%%%%%%%% Corrige le titre du sommaire %%%%%%%%%%%%%
    \renewcommand{\contentsname}{\@titreSommaire}

    %%%%%%%%%%%%% Affiche l'encadré d'en tête %%%%%%%%%%%%%
    \makeheader

    %%%%%%%%%%%%% Crée la variable WIP %%%%%%%%%%%%%
    \makeatletter
    \renewcommand{\WIP}{
        \Large\textbf{\textcolor{red}{\@WIP}}\normalsize\\
    }
    \makeatother

    %%%%%%%%%%%%% Sommaire %%%%%%%%%%%%% 
    \iftoc{}\tableofcontents\else\fi

    %%%%%%%%%%%%% Paramètres de Babel %%%%%%%%%%%%%
    \frenchbsetup{
      ItemLabels=\textbullet,
      og=\string ",
      fg=\string "
    }

    %%%%%%%%%%%%% Document Imposant %%%%%%%%%%%%%
    \ifisbigdocument{}\newpage\else\fi
}
