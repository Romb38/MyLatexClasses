# Répertoire de classe Latex

Ce répertoire contient une classe latex que j'utilise pour mes rapport en cours

## Commandes disponibles

### Avant le début du document

- \\titre{1} : Change le titre du document
- \\matiere{1} : Modifie la matière donnée dans le document
- \\lieu{1} : Change le lieu du document
- \\auteurs{1} : Change les auteurs du document
- \\date{1} : Change la date du document
- \\toc : Affiche le sommaire
- \\bigdocument : Indique que le document est imposant et laisse une page complète pour le sommaire
- \\titreSommaire{1} : Change le titre du sommaire
- \\WIP{1} : Modifier le texte du placeholder de WIP (voir \\WIP plus bas)
- \\langue{1} : Change la langue du document

### Dans le document

- \\WIP : A placer DANS le document. Affiche un placeholder en grand pour indiquer que le travail n'est pas terminé
- \\bigmsgx{1} : Affiche un message plus gros et en rouge dans le document
- \\parx : Affiche une tabulation dans les endroits "impossible"
- \\nlx : Saute une ligne dans les endroits "impossible"
- \\hrefx{2} : Affiche un hyperlien en bleu. Le premier argument est les lien et le deuxième le texte
- \\ra : Affiche une flèche vers la droite
- \\la : Affiche une flèche vers la gauche
- \\fullref{1} : Affiche une référence complète (Section + n° + nom de la section) avec un hyperlien pour s'y rendre
- \\appendix : Commence le paragraphe "Annexe"
- \\labelx{1} : Créer un label a la ligne exact ou il est placé
- \\refx{2} : Renvoie vers un labelx précédement défini. Le premier argument est le labelx et le deuxième le texte qu'il doit afficher

## Blocs disponibles

### funcr

Ce bloc permet de décrire la spécification d'une fonction
Il définit les fonctions suivantes : 

- \\signature{1} : Ajoute la signature de la fonction
- \\desc{1} : Ajoute la description de la fonction
- \\param{1} : Ajoute un paramètre à la fonction. On peut l'utiliser autant de fois qu'on à de paramètres
- \\return{1} : Ajoute un retour à la fonction. On peut l'utiliser autant de fois qu'on le souhaite

#### Exemple

```
\begin{funcr}
    \signature{foo(int a, int b)}
    \desc{Ajoute deux entiers}
    \param{a : Entier n°1}
    \param{b : Entier n°2}
    \return{Somme des deux entiers}
\end{funcr}
```

### bugr

Ce bloc permet de décrire un bug apparent. Il est également possible de lui donner un titre
Il définit les fonctions suivantes

- \\contextx[1] Commence le block "Contexte". Il est possible de changer le nom du paragraphe avec le paramètre optionnel.
- \\desiredx[1] Commence le block "Comportement souhaité". Il est possible de changer le nom du paragraphe avec le paramètre optionnel.
- \\bugx[1] Commence le block "Bug". Il est possible de changer le nom du paragraphe avec le paramètre optionnel
- \\researchx[1] Commence le block "Research". Il est possible de changer le nom du paragraphe avec le paramètre optionnel
- \\solutionx[1] Commence le block "Solution". Si ce bloc n'est pas la alors un placeholder "-- NOT SOLVED--" est mis. Il est possible de changer le nom du paragraphe avec le paramètre optionnel

- \\NOTSOLVED{1} Change le texte du placeholder quand la solution au bug n'est pas proposée

#### Exemple

Ici nous n'affichons pas la solution au bug donc le placeholder est utilisé

```
\NOTSOLVED{En cours}
\begin{document}

\begin{bugr}
    \contextx
    Projet JAVANAISE avec JAVA IRC
    \desiredx[Résultat attendu]
    Message envoyé du serveur 1 au serveur 2
    \bugx
    Message non reçu
\end{bugr}

\end{document}
```

### code

Ce bloc permet de définir un block de code avec la coloration syntaxique.
Il prends en paramètre optionnel le language qui est par défaut Python

#### Exemple
Ici on créer un block de code en C
```
\begin{code}[C]
    #include <stdio.h>
        int main() {
           // printf() displays the string inside quotation
           printf("Hello, World!");
           return 0;
        }
\end{code}
```