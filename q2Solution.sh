DIRPATH=./gileadTechnicalEval
UNZIPFILES=$DIRPATH/*.fastq.gz
for f in $UNZIPFILES
do
    gunzip $f
done

PERLFILES=$DIRPATH/*.fastq
for f in $PERLFILES
do 
    perl ./gileadTechnicalEval/fastq_to_fasta_qual.pl $f
done  