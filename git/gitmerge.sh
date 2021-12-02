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
# 拉取冲突
cpmsg=$(git pull origin $cb)
if [[ $cpmsg =~ "冲突" || $cpmsg =~ "CONFLICT" ]]
then
  echo "\033[1;31m============================== 合并冲突 pull $cb ==============================\033[0m"
fi
# 拉取失败
if [[ $cpmsg =~ "fatal" ]]
then
  echo "\033[1;31m============================== 拉取失败 pull $cb ==============================\033[0m"
fi
echo $cpmsg
# 正常操作
git push origin $cb

# 当前分支不是合并目标分支
if [ $cb != $tb ]
then
  git checkout $tb
  # 拉取冲突
  tpmsg=$(git pull origin $tb)
  if [[ $tpmsg =~ "冲突" || $tpmsg =~ "CONFLICT" ]]
  then
    echo "\033[1;31m============================== 合并冲突 pull $tb ==============================\033[0m"
  fi
  # 拉取失败
  if [[ $tpmsg =~ "fatal" ]]
  then
    echo "\033[1;31m============================== 拉取失败 pull $tb ==============================\033[0m"
  fi
  echo $tpmsg
  # 合并冲突
  mmsg=$(git merge $cb)
  if [[ $mmsg =~ "冲突" || $mmsg =~ "CONFLICT" ]]
  then
    echo "\033[1;31m============================== 合并冲突 merge $cb ==============================\033[0m"
  fi
  echo $mmsg
  git push origin $tb
  git checkout $cb
fi

# 结束
echo "\033[1;32m============================== end merge ==============================\033[0m"