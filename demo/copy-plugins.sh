        set -e; \
	rm -rf plugins; \
	mkdir plugins; \
	for gav in `cat /root/plugins.txt`; do \
	  g=`echo $$gav | cut -f1 -d: | perl -pe 's{[.]}{/}g'`; \
	  a=`echo $$gav | cut -f2 -d:`; \
	  v=`echo $$gav | cut -f3 -d:`; \
	  hpi=$$HOME/.m2/repository/$$g/$$a/$$v/$$a-$$v.hpi; \
	  if [ \! -f $$hpi ]; then \
	    mvn -U org.apache.maven.plugins:maven-dependency-plugin:2.5.1:get -Dartifact=$$gav:hpi -Dtransitive=false ||\
	      (locate $$a-$$v.hpi | fgrep .m2/repository/; false); \
	  fi; \
	  cp -v $$hpi /usr/share/jenkins/ref/plugins/$$a.jpi; \
	done
