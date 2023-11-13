# For each "contiuous non-zero signal block" in a given bedgraph file
# Calculate AUC (area under curve) and maximum value
# Input:
#   Bedgraph file
# Output
#   chr / start / end/ auc / max / coord / num
BEGIN{s=1}
$1 ~ /^chr/ {
    if(s==1){
        if($4 > 0){
            chr=$1;
            start=$2;
            stop=$3;
            max=$4;
            coord=$1":"$2"-"$3;
            auc=$4*($3-$2);
            num=1;
            s++
	    }
    }else{
        if($4 > 0){
            if(chr==$1 && $2==stop){
                num++;
                stop=$3;
                auc=auc+($4*($3-$2));
                if ($4 > max){
                    max=$4;
                    coord=$1":"$2"-"$3
                }else if($4 == max){
                    split(coord,t,"-");
                    coord=t[1]"-"$3
                }
            }else{
                print chr"\t"start"\t"stop"\t"auc"\t"max"\t"coord"\t"num; chr=$1;
                start=$2;
                stop=$3;
                max=$4;
                coord=$1":"$2"-"$3;
                auc=$4*($3-$2);
                num=1
            }
        }
    }
}