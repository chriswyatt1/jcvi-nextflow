process CHROMOPAINT {
    label 'chromo'
    tag 'chromo'
    publishDir "$params.outdir/Jcvi_results" , mode: "copy"
    container = 'chriswyatt/jcvi'
             
    input:

        path(anchors)
        tuple val(sample_id), path(fasta1), path(bed1), val(sample_id2), path(fasta2), path(bed2)
    
    output:
        
        path("*.pdf"), emit: pdf
        path("Chromo_equivalent.txt"), emit: chromosome_equivalents
        path("Chromopaint.txt"), emit: chromopaint

    script:
    """
        anchor.pl ${bed1} ${bed2} ${anchors} 
        python -m jcvi.graphics.chromosome Chromopaint.txt colour.idmap
        mv Chromopaint.pdf ${sample_id}${sample_id2}.chromo.pdf
        chromo_equiv.pl Chromopaint.txt 
    """
}
