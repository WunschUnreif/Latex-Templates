$ENV{'TZ'}='Asia/Shanghai';

ensure_path( 'TEXINPUTS', '..//' );
ensure_path( 'TTFONTS', '..//' );

# Use xelatex with latexmk.
$pdf_mode = 5;
$postscript_mode = $dvi_mode = 0;

# Always try to embed fonts, ignoring licensing flags, etc.
$xdvipdfmx = 'xdvipdfmx -E -o %D %O %S';
