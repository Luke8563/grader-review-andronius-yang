for p in `cat submissions.txt`
do
    echo "============================================"
    echo "Running test for repository: "$p
    bash grade.sh $p
done