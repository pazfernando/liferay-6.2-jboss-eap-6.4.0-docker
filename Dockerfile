FROM jboss-eap:6.4.0

ENV LIFERAY_62_DEPENDENCIES liferay-portal-dependencies-6.2-ce-ga6
ENV LIFERAY_62 liferay-portal-6.2-ce-ga6

COPY ojdbc7.jar /tmp/ 
COPY module.xml /tmp/ 
COPY module-sun.xml /tmp/ 
COPY standalone.xml /tmp/ 
COPY standalone.conf /tmp/ 
COPY server.policy /tmp/ 
COPY liferay-portal-6.2-ce-ga6-20160112152609836.war /tmp/$LIFERAY_62.war
COPY startup-liferay.sh /tmp/

RUN mkdir -p $EAP_HOME/modules/com/liferay/portal/main \
    &&  curl -o "/tmp/$LIFERAY_62_DEPENDENCIES.zip" --location http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.5%20GA6/liferay-portal-dependencies-6.2-ce-ga6-20160112152609836.zip/download \
#    && curl -o "/tmp/$LIFERAY_62.war" --location http://sourceforge.net/projects/lportal/files/Liferay%20Portal/6.2.5%20GA6/liferay-portal-6.2-ce-ga6-20160112152609836.war/download /
    && unzip /tmp/$LIFERAY_62_DEPENDENCIES.zip -d /tmp/ \
    && mv /tmp/$LIFERAY_62_DEPENDENCIES/* $EAP_HOME/modules/com/liferay/portal/main \
    && mv /tmp/ojdbc7.jar $EAP_HOME/modules/com/liferay/portal/main \
    && cp /tmp/module.xml $EAP_HOME/modules/com/liferay/portal/main \
    && rm $EAP_HOME/modules/system/layers/base/sun/jdk/main/module.xml \
    && mv /tmp/module-sun.xml $EAP_HOME/modules/system/layers/base/sun/jdk/main/module.xml \
    && mv $EAP_HOME/standalone/configuration/standalone.xml $EAP_HOME/standalone/configuration/standalone.xml-origin \
    && mv $EAP_HOME/bin/standalone.conf $EAP_HOME/bin/standalone.conf-origin \
    && cp /tmp/standalone.xml $EAP_HOME/standalone/configuration \
    && cp /tmp/standalone.conf $EAP_HOME/bin \
    && cp /tmp/server.policy $EAP_HOME/bin \
    && $EAP_HOME/bin/add-user.sh admin welcome1! --silent \
    && mkdir $EAP_HOME/standalone/deployments/ROOT.war \
    && unzip /tmp/$LIFERAY_62.war -d $EAP_HOME/standalone/deployments/ROOT.war \
    && rm $EAP_HOME/standalone/deployments/ROOT.war/WEB-INF/lib/eclipselink.jar \
    && touch $EAP_HOME/standalone/deployments/ROOT.war.dodeploy

EXPOSE 8080 9990

WORKDIR $EAP_HOME/bin
ENTRYPOINT ["./standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
