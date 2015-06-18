#!bash/bin
echo "type project name"

read project_name
echo $project_name
cd $project_name/$project_name\_DETAILS/$project_name\_Slides/$project_name\_Slides_Full/$project_name\_PNG/

pwd
# Make changes inside slides_full/PNG
for each in `ls -d */| tr -d [/]`;
do 
        echo $each;
        cd $each; 
        rename -v s//$each\_/ *  *;  
        cd -;
done

## Make change in parts PDF
cd ../../$project_name\_Slides_Parts/$project_name\_PDF/
pwd
for each in `ls -d */| tr -d [/]`;
do 
        echo $each;
        cd $each; 
 
        rename -v s/^[^_]*/$project_name/ *

        cd -;
done


## Make changes in parts PNG directory 
 cd ../$project_name\_PNG/
 pwd


 for each in `ls -d */| tr -d [/]`;
 do 
        echo $each;
        cd $each; 
 
        rename -v s/^[^_]*/$project_name/ *
#	echo $each

        cd -;
 done

 for dir1 in `ls -d */| tr -d [/]` ; 
        do

                cd $dir1;
    
                echo $dir1 ;
                for dir2 in `ls -d */| tr -d [/]`; 
                do
                        cd $dir2  
                        echo $dir2; 
                        rename -v s//$dir2\_/  *;  

                        cd - ; 
                done; 
                cd ..
                echo $dir1
    
        done

