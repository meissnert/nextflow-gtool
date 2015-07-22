#!/usr/bin/env nextflow

SNP = Channel.fromPath('/home/niels/Arbeitsfläche/Nextflow/SNP/*.gen.gz')
Sample = Channel.fromPath('/home/niels/Arbeitsfläche/Nextflow/SNP/*.sample.gz')
PED = Channel.fromPath('/home/niels/Arbeitsfläche/Nextflow/SNP/*.gen.gz')
MAP = Channel.fromPath('/home/niels/Arbeitsfläche/Nextflow/SNP/*.sample.gz')

process anyValue {
  input:
  file X from SNP
  file Y from Sample
  val Z from PED
  val A from MAP

  script:
  
  """
  /home/niels/Arbeitsfläche/Gtool/gtool -G --g ${X} --s ${Y} --ped ${Z} --map ${A}.map --snp
  """
}
