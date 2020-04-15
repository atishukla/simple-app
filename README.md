Very simple app to work for ci cd

1. ```docker build -t atishayshukla/simple-app .```
2. ```docker run -rm -it -p 8080:80 atishayshukla/simple-app```
Verify after this going to localhost or docker host ip at port 8080
```
"GET / HTTP/1.1" 200 106 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36" "-"
2020/04/14 19:13:50 [error] 6#6: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 192.168.199.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "192.168.199.9:8080", referrer: "http://192.168.199.9:8080/"
192.168.199.1 - - [14/Apr/2020:19:13:50 +0000] "GET /favicon.ico HTTP/1.1" 404 571 "http://192.168.199.9:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36" "-"
```
3. ```docker push atishayshukla/simple-app```
4. Now since docker image is ok we need kubernetes resources
5. Change the image to use your docker hub account with the image
6. Create the service to make it usable
7. Apply them
8. Now test them locally 
``` kubectl port-forward simple-app-69464d8bbc-bdgl9 8080:80```
9. curl localhost:8080 and it will give the index.html content
10. Apply ingress (optional) and see you get the page
---------------------------------------------------------------------
## Circle CI part
1. Login with your github account on circle CI
2. select your project
3. Build an intial pipeline which will fail (Add manually)
4. Go to Project settings and add some environment variables
    - DOCKERHUB_USERNAME - You should know
    - DOCKERHUB_PASS - You should know
    - KUBERNETES_TOKEN - token you get in step 2 of kubernetes admin readme part
    - KUBERNETES_SERVER - you get from ~/.kube/config
    - KUBERNETES_CLUSTER_CERTIFICATE - you get from ~/.kube/config
5. Now instead of always using latest tag for docker image we will use the circle hash for the same
6. Also to replace the same in deployment file check the shell script