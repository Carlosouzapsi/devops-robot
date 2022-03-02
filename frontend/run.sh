robot -l NONE -o NONE -r NONE resources/tasks/Delorean.robot
pabot -x xunit.xml -d ./logs -v BROWSER:chromium -v HEADLESS:True -e smoke tests

rm -rf ./logs/browser
mkdir ./logs/browser
mkdir ./logs/browser/screenshot
find ./logs/pabot_results -type f -name "*.png"

cp $(find ./logs/pabot_results -type f -name "*.png") ./logs/browser/screenshot/
