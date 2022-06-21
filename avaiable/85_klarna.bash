export KLARNA_AWS_USERNAME=toby.batch@sayhero.com
# export KLARNA_AWS_PROFILE=launchteam
# export KLARNA_AWS_ARN=arn:aws:iam::701687141127:role/sso-launch-team-retailers-config
export KLARNA_AWS_ARN=arn:aws:iam::077497887442:role/qa-developer-poweruser
export KLARNA_AWS_SP_ID=857447085047
export KLARNA_AWS_IDP_ID=C02ftgj8a

export AWS_PROFILE=qa
export AWS_DEFAULT_REGION=eu-west-1

function aws_reauth {
  # gsts --aws-role-arn arn:aws:iam::701687141127:role/sso-launch-team-retailers-config --sp-id 857447085047 --idp-id C02ftgj8a --username toby.batch@sayhero.com --aws-profile launchteam --aws-session-duration 3500
  # gsts --aws-role-arn arn:aws:iam::077497887442:role/qa-developer-poweruser --sp-id 857447085047 --idp-id C02ftgj8a --username toby.batch@sayhero.com --aws-profile qa
  gsts \
    --aws-role-arn $KLARNA_AWS_ARN \
    --sp-id $KLARNA_AWS_SP_ID \
    --idp-id $KLARNA_AWS_IDP_ID \
    --username $KLARNA_AWS_USERNAME\
    --aws-profile $AWS_PROFILE
}

aws_reauth
