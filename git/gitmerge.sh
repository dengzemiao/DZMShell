# 开始
echo "\033[1;32m============================== start merge ==============================\033[0m"

# 提交描述
msg=$1
# 合并目标分支
tb="dev"
# 没有提交描述
if [ ! $msg ]
then
  msg=$(date "+%Y-%m-%d %H:%M:%S")" 提交优化"
fi

# 当前分支
cb=$(git branch | sed -n '/\* /s///p')

# Git
git add .
git commit -m "$msg"
git pull origin $cb
git push origin $cb
git checkout $tb
git pull origin $tb
# 合并是否冲突
mmsg=$(git merge $cb)
mr=$(echo $mmsg | grep "冲突")
if [[ "$mr" != "" ]]
then
  echo "\033[1;31m============================== 合并冲突 ==============================\033[0m"
fi
echo $mmsg
git push origin $tb
git checkout $cb

# 结束
echo "\033[1;32m============================== end merge ==============================\033[0m"