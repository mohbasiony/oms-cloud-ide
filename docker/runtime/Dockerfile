FROM om-base:10.0.2309.2_20240119-0651 as base
ARG OLD_RT="/opt/SSFS_9.5/runtime"
ARG RT_BASE="/projects"
ARG NEW_RT="$RT_BASE/runtime"
USER 0

RUN yum -y install make &&\
        cp -r ${OLD_RT}/repository/eardata/isf/war/storesrc ${OLD_RT}/ &&\
        cp -r ${OLD_RT}/nodejs_angularbuild/node_modules ${OLD_RT}/storesrc &&\
        mkdir -p ${NEW_RT} &&\
        rsync -aq ${OLD_RT} ${RT_BASE} --exclude "tmp/*" --exclude "external_deployments/*" --exclude "installed_data/*" --exclude "repository/entitybuild/*" &&\
        grep -rl "${OLD_RT}" $NEW_RT/bin | xargs sed -i "s#${OLD_RT}#${NEW_RT}#g" &&\
        grep -rl "${OLD_RT}" $NEW_RT/properties | xargs sed -i "s#${OLD_RT}#${NEW_RT}#g" &&\
        chmod +x $NEW_RT/bin/* $NEW_RT/jdk/bin/* $NEW_RT/jdk/jre/bin/* &&\
        cd $NEW_RT/bin && ./setupfiles.sh && ./deployer.sh -t resourcejargen &&\
        cd $RT_BASE && tar czf runtime.tar.gz runtime


FROM registry.centos.org/che-stacks/centos-stack-base
ARG RT_BASE="/projects"
ENV OMS_RUNTIME="$RT_BASE/runtime"
ENV PATH="${OMS_RUNTIME}/node_js/bin:${OMS_RUNTIME}/storesrc/node_modules/@angular/cli/bin:${PATH}"
COPY --from=base $RT_BASE/runtime.tar.gz /tmp
COPY startup.sh $HOME/startup.sh
RUN sudo chmod a+x $HOME/startup.sh
CMD ["sh","-c","${HOME}/startup.sh"]
