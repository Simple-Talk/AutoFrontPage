


switch -regex ('th y')
{
   ( '(^.*)UT' )  { $matches[1]+ 'GMT'     ; break }
   ( '(^.*)EST' )  { $matches[1]+ '-05:00' ; break }
   ( '(^.*)EDT' )  { $matches[1]+ '-04:00' ; break }
   ( '(^.*)CST' )  { $matches[1]+ '-06:00' ; break }
   ( '(^.*)CDT' )  { $matches[1]+ '-05:00' ; break }
   ( '(^.*)MST' )  { $matches[1]+ '-07:00' ; break }
   ( '(^.*)MDT' )  { $matches[1]+ '-06:00' ; break }
   ( '(^.*)PST' )  { $matches[1]+ '-08:00' ; break }
   ( '(^.*)PDT' )  { $matches[1]+ '-07:00' ; break }
   ( '(^.*)Z' )    { $matches[1]+ 'GMT'    ; break }
   ( '(^.*)A' )    { $matches[1]+ '-01:00' ; break }
   ( '(^.*)M' )    { $matches[1]+ '-12:00' ; break }
   ( '(^.*)N' )    { $matches[1]+ '+01:00' ; break }
   ( '(^.*)Y' )    { $matches[1]+ '+12:00' ; break }
      default         { $_ }
}

