echo "./$config"

for i in "$@"
do
case $i in
	--gpu=*)
	gpu=${i#*=}
	shift
	;;
	--config=*)
	config="${i#*=}"
	shift
	;;
	*)
	;;
esac
done

echo "./$config"

. ./${config:-config.sh}
echo ${test_output_file}
echo "CUDA_VISIBLE_DEVICES=${gpu:-0}"
