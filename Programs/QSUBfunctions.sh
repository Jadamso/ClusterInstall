function strip() {
    in=$1
    key=$2
    out=$(echo $in | awk '{ gsub(/'$key'/, ""); print }')
    echo -e $out
}

## Job Size
if [[ $@ =~ "-mem" ]] || [[ $@ =~ "--mem=" ]]; then
	echo -e "\e[1;92m \n Setting Memory ... \e[0m\n";
    mem=scrape
else
    mem="500gb"
fi

if [[ $@ =~ "-wall" ]] || [[ $@ =~ "--walltime=" ]]; then
	echo -e "\e[1;92m \n Setting Time ... \e[0m\n";
    walltime=$(echo $1 | awk '{ gsub(/--walltime=/,""); print}')
else
    walltime="05:00:00"
fi

if [[ $@ =~ "-que" ]] || [[ $@ =~ "--que=" ]]; then
	echo -e "\e[1;92m \n Setting Time ... \e[0m\n";
    que=$(echo $1 | awk '{ gsub(/--que=/, ""); print }')
else
    #que=""
    que="-q bigmem"
fi


#-------------------------------------------------------------------
##################
# CHUNK D
################## 

## Defaults
mem="100gb"
walltime="05:00:00"
que=""  #que="-q bigmem"

## Override Defaults
while getopts mem:walltime:que: option
do
    case "${option}" in
        mem) mem=${OPTARG};;
        walltime) walltime=${OPTARG};;
        que) que=${OPTARG};;
    esac
done

echo -e "\e[1;92m \n Setting Memory ... \e[0m\n $mem";
echo -e "\e[1;92m \n Setting Time ... \e[0m\n $walltime";
echo -e "\e[1;92m \n Setting Que ... \e[0m\n $que";

