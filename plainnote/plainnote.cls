%% plainnote.cls
%% Copyright 2021 WunschUnreif
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is WunschUnreif.
%
% This work consists of the files plainnote.cls


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{plainnote}[2021/07/12 A plain note template.]


%% Load packages for key-value option handling and colors
\RequirePackage{kvoptions}
\RequirePackage{kvdb}
\RequirePackage{material-color}


\SetupKeyvalOptions{
    family=plainnote,
    prefix=plainnote@,
    setkeys=\kvsetkeys
}


%% Declare class options
\kvdb@create{plainnote}{
    lang = {
        choices = {
            en,
            zh,
        },
        initial = en,
    },
    bib = {
        choices = {
            on,
            off
        },
        initial = off,
        default = on,
    },
    bibstyle = {
        initial = aplha,
    },
    lineno = {
        choices = {
            on,
            off,
        },
        initial = on,
        default = on,
    }
}

\newcommand{\wunschset}[1]{\kvsetkeys{plainnote}{#1}}


%% Color theme
\newcommand{\primarycolor}{purple}
\newcommand{\secondarycolor}{blue}
\newcommand{\accentcolor}{mint}
\newcommand{\warningcolor}{orange}
\newcommand{\errorcolor}{red}
\newcommand{\successcolor}{green}
\newcommand{\infocolor}{teal}


% Input language-specified template file
\DeclareDefaultOption{}
\ProcessKeyvalOptions*

\ifplainnote@lang@en
    \InputIfFileExists{plainnote-en.ltx}{}{
        \deanwr@error{I cannot find the English template file.}
    }
\fi

\ifplainnote@lang@zh
    \InputIfFileExists{plainnote-zh.ltx}{}{
        \deanwr@error{I cannot find the Chinese template file.}
    }
\fi


%% Bibliography
\ifplainnote@bib@on
\AtEndDocument{
    \expandafter\bibliographystyle{\plainnote@bibstyle}
    \bibliography{\plainnote@config@bibdb}
}
\fi
