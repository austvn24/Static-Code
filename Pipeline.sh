#TODO, Need to query the user to find out the stack name this is the only parameter we will need from them

echo "What is the name of the Cloudformation Stack? "
read stackJ


# Creating Stack of name user Specified
aws cloudformation create-stack --stack-name $stackJ --template-body file://NginxInstance.yaml

echo "creating the stack:"
echo stackJ

# This will retrieve the stack Instance IP here and use that ip manully or add to Pipeline Automation
for stack in $(aws cloudformation list-stacks --output text --query 'StackSummaries[?contains(StackName, `$stackJ`) && (StackStatus==`CREATE_COMPLETE`||StackStatus==`UPDATE_COMPLETE`)].[StackName]') ; do aws cloudformation describe-stacks --stack-name $stack --query "Stacks[0].Outputs[*].[OutputValue]| join(' ', [])" --output text ; done

echo "instance Spun up with IP Adress printed out OR Added to file for automation OR find in console output"


## --> ansible-playbook -l live -i hosts test.yml
## update host file
