%% jbc-article.cls, Version 1.1, 2017/07/15
\ProvidesClass{jbc-article}[2017/07/15 Document class for Journal of Biological Chemistry manuscripts]

\LoadClass[11pt]{article}

\RequirePackage{placeins}
\RequirePackage[nomarkers,nolists,heads,tablesfirst]{endfloat}
% Clears the original endfloat trigger; remove \onecolumn to prevent pagebreak before endfloats
\global\let\@enddocumenthook\@empty
\AtEndDocument{%                                      % jpg
   \message{AED endfloat: Processing end Figures and Tables}% % jpg
%    \onecolumn
   \processdelayedfloats }
\InputIfFileExists{endfloat.cfg}{%
   \typeout{*** Using endfloat.cfg ***}}{}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{etoolbox}
\RequirePackage{newtxtext,newtxmath}

\RequirePackage[letterpaper,margin=1in,columnsep=0.25in,headsep=0.35in,footskip=0.5in,headheight=14pt]{geometry}

\RequirePackage{xcolor}
\RequirePackage{multicol}
\RequirePackage[style]{abstract}
\RequirePackage{url}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{caption}

% Title
\def\@affil{}
\def\@runningtitle{}
\def\@corr{}
\def\@keywords{}
\DeclareUrlCommand\email{\urlstyle{rm}}
\newcommand{\authormark}[1]{\textsuperscript{#1}}
\newcommand{\affil}[1]{\def\@affil{#1}}
\newcommand{\runningtitle}[1]{\def\@runningtitle{#1}}
\newcommand{\corr}[1]{\def\@corr{#1}}
\newcommand{\keywords}[1]{\def\@keywords{#1}}

\renewcommand{\maketitle}{%
  \begin{center}
  \@title\par
  \vskip\baselineskip
  \textbf{\@author}\par
  \vskip\baselineskip
  From the \@affil\par
  \vskip\baselineskip
  Running title: \emph{\@runningtitle}\par
  \end{center}
  \noindent To whom correspondence should be addressed: \@corr\par
  \vskip\baselineskip
  \noindent\textbf{Keywords:} \@keywords\par
  \vskip\baselineskip
  \hrule width \hsize
}

% Header and footer
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[R]{\itshape\@runningtitle}
  \fancyfoot[C]{\thepage}
\pagestyle{fancy}

% Two column main text
\newenvironment{article}{%
  \setlength{\parindent}{0.5in}
  \begin{multicols}{2}
}{%
  \end{multicols}
}
\AfterEndEnvironment{article}{%
  \parskip=\baselineskip \advance\parskip by 0pt plus 2pt
  \setlength{\parindent}{0pt}
}

% Abstract
\renewcommand{\abstitlestyle}[1]{\section*{#1}\medskip}
\renewcommand{\abstracttextfont}{\normalfont}
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\AfterEndEnvironment{abstract}{%
    \vskip\baselineskip\hrule width \hsize%
    \vskip\baselineskip
%    \hfill\begin{minipage}{0.95\linewidth}\hrule width \hsize \kern 1pt \textcolor{gray}{\hrule width \hsize}\end{minipage}
% \hrulefill
}

% Sectional headings
\titleformat{\section}{\bfseries}{}{0pt}{\MakeUppercase}
\titleformat{\subsection}[runin]{\itshape}{}{0pt}{}[\,---\,]
\titleformat{\subsubsection}[runin]{}{}{0pt}{}[.]
\titleformat{\paragraph}[runin]{}{}{0pt}{}[.]
\titleformat{\subparagraph}[runin]{}{}{0pt}{}[.]
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
\titlespacing{\subsection}{\parindent}{0pt}{0pt}
\titlespacing{\subsubsection}{\parindent}{0pt}{1em}
\titlespacing{\paragraph}{\parindent}{0pt}{1em}
\titlespacing{\subparagraph}{\parindent}{0pt}{1em}

% Lists
\setlist{nosep}

%% Citations and references
\RequirePackage[numbers,round,sort&compress]{natbib}
\renewcommand\@biblabel[1]{\makebox[0.5in][l]{#1.}}
\setlength{\bibsep}{0pt}
\pretocmd{\thebibliography}{\clearpage}{}{}
\renewcommand{\bibpreamble}{\vspace*{-\parskip}\ignorespaces}
\apptocmd{\endthebibliography}{\clearpage}{}{}

%% Experimental: automatically abbreviating journal names
\RequirePackage{jabbrv}
\RequirePackage{xstring}
%% v1.1: If journal title consists of a single word, do not abbreviate
\patchcmd{\JournalTitle}{\@abbreviate@journal@true}{%
  \IfSubStr{#1}{ }
    {\@abbreviate@journal@true}
    {\@abbreviate@journal@false%
      #1\journal@char@stop}%
}{}{}

%% Various end-of-manuscript information
\newenvironment{acknowledgments}{%
%   \vskip\baselineskip%
  \textbf{Acknowledgments:\space}%
  \ignorespaces%
}{}

\newenvironment{conflict}{%
  \textbf{Conflict of interest:\space}%
  \ignorespaces%
}{}

\newenvironment{contributions}{%
  \textbf{Author contributions:\space}%
  \ignorespaces%
}{}

\newenvironment{footnotes}{%
  \section*{Footnotes}\vspace*{-\parskip}%
  \ignorespaces%
  \FloatBarrier
}{}

%% List of Tables and Figures at end
\captionsetup{labelfont={bf,sf}, position=bottom}
% \renewcommand{\listfigurename}{Figure Legends}
% \renewcommand{\listtablename}{Table Legends}
% \renewcommand*{\l@figure}[2]{%
%   \renewcommand{\numberline}[1]{\textbf{\MakeUppercase{\figurename} ##1.}\space}
%   #1\par
% }
% \renewcommand*{\l@table}[2]{%
%   \renewcommand{\numberline}[1]{\textbf{\MakeUppercase{\tablename} ##1.}\space}
%   #1\par
% }

% Prevent pagebreak before endfloats
\patchcmd{\efloat@process}{\clearpage}{}{}{}
