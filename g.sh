echo "commit:"
read commit
git add .
git commit -m "Enhanment:$commit"
git push
sh r.sh
