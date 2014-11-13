for f in *.log; do
base=`basename $f .log`
mv $f $base.log.z
done
