use strict;
use warnings;

# get_file_data
#
# A subroutine to get data from a file given its filename
sub get_file_data {
    my($filename) = @_;
    
    # Initialize variables
    my @filedata = ();
    unless( open(GET_FILE_DATA, $filename) ) {
	print STDERR "Cannot open file \"$filename\"\n\n";
	exit;
    }
    @filedata = <GET_FILE_DATA>;
    close GET_FILE_DATA;
    return @filedata;
}

# extract_sequence_from_fasta_data
#
# A subroutine to extract FASTA sequence data from an array
# A subroutine to extract FASTA sequence data from an array
sub extract_sequence_from_fasta_data {
    my(@fasta_file_data) = @_;
   # Declare and initialize variables
    my $sequence = '';
    my $sequence_name = '';
    foreach my $line (@fasta_file_data) {
      # discard blank line
	if ($line =~ /^\s*$/) {
	    next;
      # discard comment line
	} elsif($line =~ /^\s*#/) {
	    next;
      # discard fasta header line
	} elsif($line =~ /^>/) {
	    $sequence_name = $line;
	    next;
      # keep line, add to sequence string
	} else {
	    $sequence .= $line;
	}
    }
   # remove non-sequence data (in this case, whitespace)
    from $sequence string;
    $sequence =~ s/\s//g;
    return （sequence,$sequence_name);
}


# calculate percentage of A,T,C,G in a DNA sequence
sub calc_percentage {
    my($DNA) = @_;
    my($length) = length($DNA);
    my($position,$letter);
    my $countA=$countT=$countC=$countG = 0;
    for ($position=0; $position < $length ; ++$positio){
        $letter = (substr($DNA,$position,1);
	if ($letter == 'A') {
	    ++$countA;
	} elsif ($letter == 'T'{
	    ++$countT;
	} elsif ($letter == 'C'{
            ++$countC;
        } elsif ($letter == 'G'{
            ++$countG;
	} else {
            print "wrong DNA codes:$letter\n";
	}
    }
    return ($countA/$length*100,$countT/$length*100,$countC/$length*100,$countG/$length*100);
}

#$percentage = calc_percentage("ATCGATTACG")
#print "Percentage:$percentage\n"


#trim off a string
sub trim_string{
    my($DNA) = $_[0];
    my($DNA_qread) = $_[1];
    my($chop_DNA) = substr($DNA, 0, -15);
    my @chop_qread = split(' ',$DNA_read);
    @chop_qread = splice(@chop_read,-15); 
    my $chop_qread = join(' ', @chop_qread); 
    return ($chop_DNA, $chop_qread);
}


#calculate average_quality of the read
sub calc_avg_qscore {
    my $qread = $_[0];
    my $length = $_[1];
    my $sum = 0;
    foreach( split ' ', $qread ) { $sum += $_; }
    my $avg_read_score = $sum/$length;
    return $avg_read_score;
}


#only call for fasta dna sequence with length > 65bp
sub master_dna_handle{
    my($DNA) = $_[0];
    my($DNA_read) = $_[1];
    my($length) = length($DNA);
    my($percentA,$percentC,$percentG,$percentT);
    my($avg_quality);
    my($chopped_quality);
    my($chop_dna,$chop_read);
     
    $avg_quality = &calc_avg_qscore($DNA,$length);
    ($chop_dna,$chop_read) = &trim($DNA,$DNA_read);
    ($percentA,$percentC,$percentG,$percentT) = &calc_percentage($DNA);
    $chopped_quality = &calc_avg_qscore($DNA_read,length($chop_dna));
    return ($length,$percentA,$percentC,$percentG,$percentT, $avg_quality,$chopped_quality,$chop_dna);
}


# Declare and initialize variables
my @file_data = ();
my $dna = '';
# Read in the contents of the fasta files
@files = <./gileadTechnicalEval/*.fastq.fasta>;
foreach $file (@files){
    @file_data = get_file_data("$file");
    # Extract the sequence data from the contents of the file "sample.dna"
    $dna = extract_sequence_from_fasta_data(@file_data);
    trim_string($dna);
}
