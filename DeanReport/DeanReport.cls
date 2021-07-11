%% DeanReport.cls
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
% This work consists of the files DeanReport.cls, DeanReport-en.ltx, 
% DeanReport-zh.ltx.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{DeanReport}[2021/07/07 Document class for weekly report used by Dean Liu]


%% Error and warning aliases
\newcommand{\deanwr@error}{\ClassError{DeanReport}}
\newcommand{\deanwr@warning}{\ClassWarning{DeanReport}}
\newcommand{\deanwr@info}{\ClassInfo{DeanReport}}

%% Options declaration
\RequirePackage{kvoptions}
\RequirePackage{kvsetkeys}
\RequirePackage{kvdefinekeys}
\RequirePackage{ifthen}

\SetupKeyvalOptions{
    family=deanwr,
    prefix=deanwr@,
    setkeys=\kvsetkeys
}

% Create a key val database by the given scheme 
% \deanwr@create@kv@db{<database name>}{    % if use `deanwr` as name, then values can be updated by the class options
%      <key> = {                            % the key name for setting this field
%           name = <field name>,            % the name for accessing this field, i.e. will create a macro \<database name>@<field name>
%           choices = {<choice 1>, ...},    % optional, limits the possible values for this field,
%           initial = <initial value>,      % optional, initial value of this field,
%           default = <default value>       % optional, default value of this field, which means the value set 
%                                           % when you only specify this field but passes no specific value.
%       },
%       ...
% }
% for choices keys, the following newif is provided for each possible choice:
%   \newif\if<database name>@<field name>@<choice>
\newcommand{\deanwr@create@kv@db}[2]{
    \kv@set@family@handler{#1@scheme}{
        % ##1 is <key>, ##2 is the scheme definition for <key>
        \@namedef{#1@##1@name}{##1}
        \@namedef{#1@##1@initial}{}
        \@namedef{#1@##1@default}{}
        \@namedef{#1@##1@reset}{} % set every choice item to false
        \@namedef{#1@##1@check}{} % check the value is one of choices
        \@namedef{#1@##1@trigger}{relax} % trigger code called when value updated
        \kv@define@key{#1@##1@spec}{name}{
            % ####1 is /<database name>/<key>/<name>
            \@namedef{#1@##1@name}{####1}
        }
        \kv@define@key{#1@##1@spec}{trigger}{
            % ####1 is /<database name>/<key>/<trigger>
            \@namedef{#1@##1@trigger}{####1}
        }
        \kv@define@key{#1@##1@spec}{initial}{
            % ####1 is /<database name>/<key>/<initial>
            \@namedef{#1@##1@initial}{####1}
        }
        \kv@define@key{#1@##1@spec}{default}{
            % ####1 is /<database name>/<key>/<default>
            \@namedef{#1@##1@default}{####1}
            \expandafter\ifx\csname #1@##1@initial\endcsname\@empty
                \@namedef{#1@##1@initial}{####1}
            \fi
        }
        \kv@set@family@handler{#1@##1@choices}{
            % ####1 is a choice item for /<database name>/<key>
            % TODO: add reset, newif commands.
            \expandafter\ifx\csname #1@##1@default\endcsname\@empty 
                \@namedef{#1@##1@default}{####1}
            \fi
            \expandafter\ifx\csname #1@##1@initial\endcsname\@empty 
                \@namedef{#1@##1@initial}{####1}
            \fi
            \expandafter\newif\csname if#1@\@nameuse{#1@##1@name}@####1\endcsname
            \expandafter\g@addto@macro\csname #1@##1@reset\endcsname{\csname #1@\@nameuse{#1@##1@name}@####1false\endcsname}
        }
        \kv@define@key{#1@##1@spec}{choices}{
            % ####1 is /<database name>/<key>/<choices>
            \kvsetkeys{#1@##1@choices}{####1}
            \@namedef{#1@##1@check}{
                \@ifundefined{%
                    if#1@\@nameuse{#1@##1@name}@\@nameuse{#1@\@nameuse{#1@##1@name}}%
                }{
                    \deanwr@error{You cannot assign value `\@nameuse{#1@\@nameuse{#1@##1@name}}' to the key `#1.\@nameuse{#1@##1@name}'.}
                }{
                    \@nameuse{#1@##1@reset}
                    \@nameuse{#1@\@nameuse{#1@##1@name}@\@nameuse{#1@\@nameuse{#1@##1@name}}true}
                }
            }
        }
        \kvsetkeys{#1@##1@spec}{##2}
        \kv@define@key{#1}{##1}[\@nameuse{#1@##1@default}]{
            % ####1 is the value trying to assign to this <key>
            \@namedef{#1@\@nameuse{#1@##1@name}}{####1}
            \@nameuse{#1@##1@check}
            \@nameuse{\@nameuse{#1@##1@trigger}}
        }
        \kvsetkeys@expandafter{#1}{##1=\@nameuse{#1@##1@initial}}
    }
    \kvsetkeys{#1@scheme}{#2}
}

% options that can be specified at the option field for this class
\deanwr@create@kv@db{deanwr}{
    lang = {
        choices = {
            en,
            zh,
        },
        initial = en,
    },
    showlineno = {
        choices = {
            on, 
            off,
        },
        initial = off,
        default = on
    },
    showbib = {
        choices = {
            on,
            off,
        },
        default = on,
        initial = off,
    },
    bibstyle = {
        initial = abbrv,
    },
}

\newcommand{\deanset}[1]{\kvsetkeys{deanwr}{#1}}


%% Package loading
\RequirePackage{color}
\RequirePackage{xcolor}

%% Color definitions
\RequirePackage{material-color}

\newcommand{\primarycolorname}{indigo}
\newcommand{\secondarycolorname}{purple}
\newcommand{\accentcolorname}{teal}
\newcommand{\errorcolorname}{deep-orange}
\newcommand{\warningcolorname}{orange}
\newcommand{\infocolorname}{blue-grey}
\newcommand{\successcolorname}{green}

\newcommand{\getmaterialcolor}[2]{#1-#2}

\newcommand{\primarycolor}{\primarycolorname-base}
\newcommand{\secondarycolor}{\secondarycolorname-base}
\newcommand{\accentcolor}{\accentcolorname-base}
\newcommand{\errorcolor}{\errorcolorname-base}
\newcommand{\warningcolor}{\warningcolorname-base}
\newcommand{\infocolor}{\infocolorname-base}
\newcommand{\successcolor}{\successcolorname-base}

\definecolor{pagebg}{HTML}{FFFFFF}
\pagecolor{pagebg}


\DeclareDefaultOption{}
\ProcessKeyvalOptions*

% Input language-specified template file
\ifdeanwr@lang@en
    \deanwr@info{lang = en}
    \InputIfFileExists{DeanReport-en.ltx}{}{
        \deanwr@error{I cannot find the English template file.}
    }
\fi

\ifdeanwr@lang@zh
    \deanwr@info{lang = zh}
    \InputIfFileExists{DeanReport-zh.ltx}{}{
        \deanwr@error{I cannot find the Chinese template file.}
    }
\fi


%% Bibliography
\ifdeanwr@showbib@on
\AtEndDocument{
    \expandafter\bibliographystyle{\deanwr@bibstyle}
    \bibliography{\deanwr@info@bib}
}
\fi
