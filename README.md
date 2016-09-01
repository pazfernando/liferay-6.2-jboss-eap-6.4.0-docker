# liferay-6.2-jboss-eap-6.4.0-docker

**Before you start you need to understand and accept the following terms about the third software provided**

- For ojdcb7.jar http://www.oracle.com/technetwork/licenses/distribution-license-152002.html
- For automatic downloads of liferay https://www.liferay.com/downloads/ce-license, and all internal dependencies licenses

This implementation is based on https://github.com/pazfernando/liferay-6.2-jboss-eap-6.4.0-docker, so you need to built the previous container with the name *jboss-eap:6.4.0* as suggested in the README.md project file.

#### Database:
We use Oracle as BDD, that is the reason why ojdbc.jar was included.  So, edit the my_standalone.xml file from the line 142 to 154 with your BDD information.  After that, rename this file as standalone.xml.

Remember that the Oracle user needs `connect`, `resource` and `sequence` privileges to let Liferay creates the initial structure.

#### Let's do it:
The first step is built image ``docker build -t jboss-eap-liferay:6.4.0-6.2 .``
The second step es run the container ``docker run --name jboss-eap-liferay-6.4.0-6.2 -p 8085:8080 -p 9995:9990 -d jboss-eap-liferay:6.4.0-6.2``

Of course the name *jboss-eap-liferay-6.4.0-6.2* could be different according your needs.

This installation was made replacing the "ROOT context" as "the Liferay deployment context" so you can access to this portal with http://localhost:8085

The console access is on `http://localhost:9995/` URL, with the following credentials:
- User: admin
- Password: welcome1!

I hope helps
Thanks

_pazfernando_
