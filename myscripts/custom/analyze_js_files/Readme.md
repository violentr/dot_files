**Download and beautify JS files**

./beautify-files.sh js_files.txt

**Webpack unpack and beautify**

$ ./run-webpack-unpack.sh js_bundle.js

Behind the scenes

$ webpack-unpack < \10.15d9ed80da893da943f4.5-5-0.bundle.js | js-beautify > processed/chk-10.15d9ed80da893da943f4.5-5-0.bundle.js


Process JS files make more readable format

substitute ; with \n;

$ cat filename.js | awk '{gsub(/[;]/, "&\n")};1'


Search for api endpoints:

- /api/(\w{1,20}(/){1,10}){1,10}
- /api(/(\w{1,20}/){1,10})(\w{1,100})?
