git pull
echo "commit:"
read commit
git add .
git commit -m "$commit"
git push
sh r.sh
