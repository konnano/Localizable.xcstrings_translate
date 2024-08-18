use strict;
use warnings;
my $File = 'Localizable.xcstrings';
my $Lang = 'ja'; ## trans code

if( $ARGV[0] ){ unlink 'trans.txt';
 open my $K,'<',$File or die" Line 1 $!\n";
  my( $i1,$e1,$sp,$lang,$code );
 while(my $data = <$K>){ my @lang;
  if( index($data,'localizations') > 0 ){ $i1++ ; next }
  if( $i1 ){ $data =~ s/\\"/'/g;
   if( not $e1 and $data =~ /(^\s*)"([^"]+)".+/ ){
    $sp = $1; $code = $2; $e1 = 1;
   }elsif( $data =~ /^\s*"value"\s+:\s+"(.*?)"/ ){
    if( $1 ){
     push @lang,split '\\\\n',$1;
      for( @lang ){ s/https:/ttps:/; $lang .= "$code $_\n" }
    }else{ $lang .= "$code \n" }
   }elsif( $data =~ /^$sp}/ ){ $i1 = $e1 = 0 }
  }
 }
 close $K;
 open my $G,'>','tran.txt' or die" Line 2 $!\n";
  print $G $lang; close $G;
 system qq(while read -r line;do set -- \$line;echo "\${*:2}"|
           trans -b "\$1":$Lang >> trans.txt;done < tran.txt);
}else{
 open my $M,'<','trans.txt' or die" Line 3 $!\n";
  chomp(my @bn = <$M>); close $M;

 open my $H,'<',$File or die" Line 4 $!\n";
  my( $m,$i1,$e1,$sp,@an,@cn ) = 0;
 while(my $data = <$H>){ push @cn,$data;
  if( index($data,'localizations') > 0 ){ $i1++ ; next }
  if( $i1 ){
   if( not $e1 and $data =~ s/(^\s*)"[^"]+"(.+\n)/$1"$Lang"$2/ ){
    $sp = $1; push @an,$data;
     $e1++; next;
   }elsif( $data =~ /^$sp}/ ){
    if( index($cn[-1],',') < 0 ){ substr $cn[-1],-1,1,",\n" }
     push @an,$data; $i1 = $e1 = 0;
      push @cn,@an; @an = (); next;
   }
   if( index($data,'value') > 0 ){ my $line;
     $data =~ s/\\"/'/g; my $kai = () = $data =~ /\\n/g;
    if( $data =~ s/(^\s*"value"\s+:\s+").*?(\\n|")/$1$bn[$m++]$2/ ){
        $data =~ s/ttps:/https:/; $line = $data }
    for(my $k=1;$kai>$k;$k++ ){ 
     if( $data =~ s/(^\s*"value"\s+:(?:.*?\\n){$k}).*?\\n/$1$bn[$m++]\\n/ ){
         $data =~ s/ttps:/https:/; $line = $data }
    }
    if( $data =~ s/(^\s*"value"\s+:.+)\\n[^"]+"\n/$1\\n$bn[$m++]"\n/ ){
        $data =~ s/ttps:/https:/; $line = $data }
    die " Translate Error 1\n" unless $bn[$m];
     push @an,$line;
      next;
   }
   push @an,$data;
  }
 }
 close $H;
die " Translate Error 2\n" if $bn[$m];
print @cn;
}
