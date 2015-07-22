#!/usr/bin/env nextflow

params.snp = Channel.fromPath("$baseDir/data/*.gen.gz")
params.sample = Channel.fromPath("$baseDir/data/*.sample.gz")
params.out = "$baseDir/results"

out = file(params.out, type: 'dir')

log.info "GTOOL"
log.info "================================="
log.info "SNP                : ${params.snp}"
log.info "SAMPLE:            : ${params.sample}"
log.info ""
log.info "Current home       : $HOME"
log.info "Current user       : $USER"
log.info "Current path       : $PWD"
log.info "Script dir         : $baseDir"
log.info "Working dir        : $workDir"
log.info "Output dir         : ${out}"
log.info ""

process gtools {

  input:
  file snp from params.snp
  file sample from params.sample

  output:
  file '*.ped.gz' into results
  file '*.map.gz' into results

  """
  prefix=\$(echo $snp | sed 's/.gen.gz.*//')
  ~/bin/gtool -G --g $snp --s $sample --ped \$prefix.ped --map \$prefix.map --snp
  """
}

results.subscribe {
    log.info "Copying results to file: ${out}/${it.name}"
    it.copyTo(out)
}