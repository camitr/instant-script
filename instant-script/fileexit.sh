echo 'check your file'
read file

if [ ! -f $file ]; then

	echo "file not found"

else

	echo "your file exists"
fi
