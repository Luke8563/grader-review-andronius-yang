CPATH=".;./lib/hamcrest-core-1.3.jar;./lib/junit-4.13.2.jar"

rm -rf student-submission
git clone $1 student-submission &>/dev/null

if [[ $? -ne 0 ]]
then
    echo "Invalid link"
else
    echo 'Repository found. Finished cloning.'
fi

if [[ -f ./student-submission/ListExamples.java ]]
then
    echo "File found: ListExamples.java"
else
    echo "File not found for: ListExamples.java"
    exit
fi

cp ./TestListExamples.java ./student-submission
cp -r ./lib ./student-submission

cd ./student-submission

javac -cp "$CPATH" *.java

if [[ $? -ne 0 ]]
then
    echo "Compile Error"
    exit
fi

java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples > errorOut.txt
N_ERRORS=`cat errorOut.txt | sed -n '2p' | grep -o 'E' | wc -l`
N_CASES=`cat errorOut.txt | sed -n '2p' | grep -o '\.' | wc -l`
echo $N_ERRORS" errors found for total "$N_CASES" cases."