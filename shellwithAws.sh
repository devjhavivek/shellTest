read -p "Please select 1 for aws and 2 for minio" bucketserver

if [ -z "$bucketserver" ]
then
   echo "No bucketserver name"
else
    if [ "$bucketserver" -eq 1 ]
        then
        read -p "please enter bucket name " bucketname
        if [ -z "$bucketname" ]
        then
        echo "Null value"
        else
        #no need to add http only enter IP
        bucket=$(aws s3 ls | grep "$bucketname" | awk '{print $3}')
        echo "$bucket"   
        for index in "$bucket"
        do
            read -p "Do you wish to delete s3 bucket y/n?" answer
            if [ "$answer" = "n" ]
            then
                echo "not deleted"
            else
                echo "s3://$index"
                aws s3 rb "s3://$index"
            echo " deleted"
            fi
        done
        fi

    else

        read -p "please enter bucket name " bucketname
        read -p "please enter the IP " endpointuip
        if [ -z "$bucketname" ] && [ -z "$endpointuip" ]
        then
            echo "Null value"
            else
            #no need to add http only enter IP
            bucket=$(aws --endpoint-url "http://$endpointuip/" s3 ls | grep "$bucketname" | awk '{print $3}')
            echo "$bucket"   
            for index in "$bucket"
            do
                echo "$index"
                read -p "Do you wish to delete minio y/n?" answer
                if [ "$answer" = "n" ]
                then
                    echo "not deleted"
                else
                    echo "s3://$index"
                    aws --endpoint-url "http://$endpointuip/" s3 rb "s3://$index"
                echo " deleted"
                fi
            done
        fi
    fi
fi
