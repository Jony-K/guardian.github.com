#!/bin/bash
 
for DIR in $(find . -type d  \( ! -regex '.*/\..*' \) ); do
  echo -e "Creating directory listing index.html for "$DIR
  (
    echo -e "<html>\n<body>\n<h1>Directory listing</h1>\n<hr/>\n<pre>"
    ls -1pa "${DIR}" |\
      grep -v "^\./$" |\
      grep -v "^\..*/$" |\
      grep -v "^index\.html$"|\
      awk '{ printf "<a href=\"%s\">%s</a>\n",$1,$1 }'
    echo -e "</pre>\n</body>\n</html>"
  ) > "${DIR}/index.html"
done

echo -e "Creating .index/nexus-maven-repository-index.properties"
mkdir -p .index
cat > .index/nexus-maven-repository-index.properties << EOF
nexus.index.time=$(date +'%Y%m%d%H%M%S.%3N %z')
nexus.index.timestamp=$(date +'%Y%m%d%H%M%S.%3N %z')
nexus.index.id=guardian-public-releases
EOF