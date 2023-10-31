BEGIN{s=1}
{
    if(s==1){
        chr=$1;
        start=$2;
        stop=$3;
        auc=$4;
        max=$5;
        coord=$6;
        s++
    }else{
        if(chr==$1 && $2 < stop+value){
            stop=$3;
            auc=auc+$4;
            if($5 > max){
                max=$5;
                coord=$6
            }else if($5==max){
                split(coord,t,"-");
                split($6,u,"-");
                coord=t[1]"-"u[2]
            }
        }else{
            print chr"\t"start"\t"stop"\t"auc"\t"max"\t"coord;
            chr=$1;
            start=$2;
            stop=$3;
            auc=$4;
            max=$5;
            coord=$6
        }
    }
}