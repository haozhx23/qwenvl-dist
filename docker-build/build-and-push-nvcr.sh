
# img_name=dlc-torch2.6-ec2
img_name=nvcr-2409-sm

docker build -t $img_name:latest -f 0.nvcr-pytorch-aws.dockerfile .

AWS_REGION=us-east-1
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO_NAME="$img_name"
IMAGE_TAG="latest"
LOCAL_IMAGE="$img_name:latest"

# 登录到 ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# 创建仓库 (如果不存在)
aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION || aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION

# 标记镜像
docker tag $LOCAL_IMAGE $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG

# 推送镜像
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG

echo "镜像已成功上传到 ECR: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:$IMAGE_TAG"
