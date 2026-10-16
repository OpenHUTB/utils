# 参考 pr.bat 的思路重写
if [ $# -ne 1 ]; then
    echo "Usage: $0 <pr_number>"
    exit 1
fi

pr_id=$1

# 判断本地是否存在名为 pr_id 的分支
if git show-ref --verify --quiet refs/heads/$pr_id; then
    echo "Branch $pr_id already exists locally."
    git switch -f $pr_id
    git pull origin pull/$pr_id/head
else
    echo "Branch $pr_id does not exist locally."
    # 获取远程分支
    git fetch origin pull/$pr_id/head:$pr_id && git switch -f $pr_id
    if [ $? -ne 0 ]; then
        echo "Failed to fetch PR #$pr_id from remote."
        exit 1
    fi
fi


