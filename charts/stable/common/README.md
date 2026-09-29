# common

![Version: 4.11.0](https://img.shields.io/badge/Version-4.11.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Function library for blissflow charts

Since a lot of the blissflow charts follow a similar pattern, this library was built to reduce maintenance cost between the charts that use it and try achieve a goal of being DRY.

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Using this library

Include this chart as a dependency in your `Chart.yaml` e.g.

```yaml
# Chart.yaml
dependencies:
- name: common
  version: 4.8.1
  repository: https://library-charts.blissflow.tech
```

For more information, take a look at the [Docs](http://docs.blissflow.tech/our-helm-charts/common-library/).

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/blissflow-tech/library-charts/tree/main/charts/stable/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | object | `{}` | Specify any additional containers here as dictionary items. Each additional container should have its own key. Helm templates can be used. |
| affinity | object | `{}` | Defines affinity constraint rules. [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| args | list | `[]` | Override the args for the default container |
| automountServiceAccountToken | bool | `true` | Specifies whether a service account token should be automatically mounted. |
| autoscaling | object | <disabled> | Add a Horizontal Pod Autoscaler |
| command | list | `[]` | Override the command(s) for the default container |
| configmap | object | See below | Configure configMaps for the chart here. Additional configMaps can be added by adding a dictionary key similar to the 'config' object. |
| configmap.config.annotations | object | `{}` | Annotations to add to the configMap |
| configmap.config.data | object | `{}` | configMap data content. Helm template enabled. |
| configmap.config.enabled | bool | `false` | Enables or disables the configMap |
| configmap.config.labels | object | `{}` | Labels to add to the configMap |
| controller.annotations | object | `{}` | Set annotations on the deployment/statefulset/daemonset |
| controller.enabled | bool | `true` | enable the controller. |
| controller.labels | object | `{}` | Set labels on the deployment/statefulset/daemonset |
| controller.podManagementPolicy | string | `nil` | Set statefulset podManagementPolicy, valid values are Parallel and OrderedReady (default). |
| controller.replicas | int | `1` | Number of desired pods |
| controller.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| controller.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| controller.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| controller.rollingUpdate.unavailable | string | `nil` | Set deployment RollingUpdate max unavailable |
| controller.strategy | string | `nil` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| controller.type | string | `"deployment"` | Set the controller type. Valid options are deployment, daemonset or statefulset |
| cronjob | object | `{}` | Set cronjob. |
| dnsConfig | object | `{}` | Optional DNS settings, configuring the ndots option may resolve nslookup issues on some Kubernetes setups. |
| dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| enableServiceLinks | bool | `true` | Enable/disable the generation of environment variables for services. [[ref]](https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/#accessing-the-service) |
| env | string | `nil` | Main environment variables. Template enabled. Syntax options: A) TZ: UTC B) PASSWD: '{{ .Release.Name }}' C) PASSWD:      configMapKeyRef:        name: config-map-name        key: key-name D) PASSWD:      valueFrom:        secretKeyRef:          name: secret-name          key: key-name      ... E) - name: TZ      value: UTC F) - name: TZ      value: '{{ .Release.Name }}' |
| envFrom | list | `[]` | Secrets and/or ConfigMaps that will be loaded as environment variables. [[ref]](https://unofficial-kubernetes.readthedocs.io/en/latest/tasks/configure-pod-container/configmap/#use-case-consume-configmap-in-environment-variables) |
| external-secrets | object | `{}` | Set External Secrets |
| extraDeploy | object | `{}` | Additional extra resources to deploy |
| gateway | object | `{"className":"cilium","enabled":false,"listeners":[{"hostname":"app.example.com"}]}` | Gateway api configuration |
| global.annotations | object | `{}` | Set additional global annotations. Helm templates can be used. |
| global.fullnameOverride | string | `nil` | Set the entire name definition |
| global.labels | object | `{}` | Set additional global labels. Helm templates can be used. |
| global.nameOverride | string | `nil` | Set an override for the prefix of the fullname |
| hostAliases | list | `[]` | Use hostAliases to add custom entries to /etc/hosts - mapping IP addresses to hostnames. [[ref]](https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/) |
| hostNetwork | bool | `false` | When using hostNetwork make sure you set dnsPolicy to `ClusterFirstWithHostNet` |
| hostname | string | `nil` | Allows specifying explicit hostname setting |
| httproute | object | `{"enabled":false,"gatewayName":"public","hostnames":["app.example.com"]}` | Gateway httproute configuration |
| image.digest | string | `nil` | image digest |
| image.pullPolicy | string | `nil` | image pull policy |
| image.repository | string | `nil` | image repository |
| image.tag | string | `nil` | image tag |
| imagePullSecrets | list | `[]` | Set image pull secrets |
| ingress | object | See below | Configure the ingresses for the chart here. Additional ingresses can be added by adding a dictionary key similar to the 'main' ingress. |
| ingress.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| ingress.main.enabled | bool | `false` | Enables or disables the ingress |
| ingress.main.hosts[0].host | string | `"chart-example.local"` | Host address. Helm template can be passed. |
| ingress.main.hosts[0].paths[0].path | string | `"/"` | Path.  Helm template can be passed. |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` | Ignored if not kubeVersion >= 1.14-0 |
| ingress.main.hosts[0].paths[0].service.name | string | `nil` | Overrides the service name reference for this path |
| ingress.main.hosts[0].paths[0].service.port | string | `nil` | Overrides the service port reference for this path |
| ingress.main.ingressClassName | string | `nil` | Set the ingressClass that is used for this ingress. Requires Kubernetes >=1.19 |
| ingress.main.labels | object | `{}` | Provide additional labels which may be required. |
| ingress.main.nameOverride | string | `nil` | Override the name suffix that is used for this ingress. |
| ingress.main.primary | bool | `true` | Make this the primary ingress (used in probes, notes, etc...). If there is more than 1 ingress, make sure that only 1 ingress is marked as primary. |
| ingress.main.tls | list | `[]` | Configure TLS for the ingress. Both secretName and hosts can process a Helm template. |
| initContainers | object | `{}` | Specify any initContainers here as dictionary items. Each initContainer should have its own key. The dictionary item key will determine the order. Helm templates can be used. |
| job | object | `{}` | Set job. |
| lifecycle | object | `{}` | Configure the lifecycle for the main container |
| nodeSelector | object | `{}` | Node selection constraint [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| persistence | object | See below | Configure persistence for the chart here. Additional items can be added by adding a dictionary key similar to the 'config' key. [[ref]](http://docs.blissflow.tech/our-helm-charts/common-library-storage) |
| persistence.config | object | See below | Default persistence for configuration files. |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | AccessMode for the persistent volume. Make sure to select an access mode that is supported by your storage provider! [[ref]](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.config.enabled | bool | `false` | Enables or disables the persistence item |
| persistence.config.existingClaim | string | `nil` | If you want to reuse an existing claim, the name of the existing PVC can be passed here. |
| persistence.config.mountPath | string | `nil` | Where to mount the volume in the main container. Defaults to `/<name_of_the_volume>`, setting to '-' creates the volume but disables the volumeMount. |
| persistence.config.nameOverride | string | `nil` | Override the name suffix that is used for this volume. |
| persistence.config.readOnly | bool | `false` | Specify if the volume should be mounted read-only. |
| persistence.config.retain | bool | `false` | Set to true to retain the PVC upon `helm uninstall` |
| persistence.config.size | string | `"1Gi"` | The amount of storage that is requested for the persistent volume. |
| persistence.config.storageClass | string | `nil` | Storage Class for the config volume. If set to `-`, dynamic provisioning is disabled. If set to something else, the given storageClass is used. If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| persistence.config.subPath | string | `nil` | Used in conjunction with `existingClaim`. Specifies a sub-path inside the referenced volume instead of its root |
| persistence.config.type | string | `"pvc"` | Sets the persistence type Valid options are pvc, emptyDir, hostPath, secret, configMap or custom |
| persistence.shared | object | See below | Create an emptyDir volume to share between all containers [[ref]]https://kubernetes.io/docs/concepts/storage/volumes/#emptydir) |
| persistence.shared.medium | string | `nil` | Set the medium to "Memory" to mount a tmpfs (RAM-backed filesystem) instead of the storage medium that backs the node. |
| persistence.shared.sizeLimit | string | `nil` | If the `SizeMemoryBackedVolumes` feature gate is enabled, you can specify a size for memory backed volumes. |
| podAnnotations | object | `{}` | Set annotations on the pod |
| podLabels | object | `{}` | Set labels on the pod |
| podSecurityContext | object | `{}` | Configure the Security Context for the Pod |
| priorityClassName | string | `nil` | Custom priority class for different treatment by the scheduler |
| probes | object | See below | [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.liveness.custom | bool | `false` | Set this to `true` if you wish to specify your own livenessProbe |
| probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.readiness.custom | bool | `false` | Set this to `true` if you wish to specify your own readinessProbe |
| probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. If you selected `custom: true`, this field holds the definition of the readinessProbe. |
| probes.startup | object | See below | Startup probe configuration |
| probes.startup.custom | bool | `false` | Set this to `true` if you wish to specify your own startupProbe |
| probes.startup.enabled | bool | `true` | Enable the startup probe |
| probes.startup.spec | object | See below | The spec field contains the values for the default startupProbe. If you selected `custom: true`, this field holds the definition of the startupProbe. |
| resources | object | `{}` | Set the resource requests / limits for the main container. |
| runtimeClassName | string | `nil` | Allow specifying a runtimeClassName other than the default one (ie: nvidia) |
| schedulerName | string | `nil` | Allows specifying a custom scheduler name |
| secret | object | `{}` | Use this to populate a secret with the values you specify. Be aware that these values are not encrypted by default, and could therefore visible to anybody with access to the values.yaml file. |
| securityContext | object | `{}` | Configure the Security Context for the main container |
| service | object | See below | Configure the services for the chart here. Additional services can be added by adding a dictionary key similar to the 'main' service. |
| service.main.annotations | object | `{}` | Provide additional annotations which may be required. |
| service.main.enabled | bool | `true` | Enables or disables the service |
| service.main.externalTrafficPolicy | string | `nil` | [[ref](https://kubernetes.io/docs/tutorials/services/source-ip/)] |
| service.main.ipFamilies | list | `[]` | The ip families that should be used. Options: IPv4, IPv6 |
| service.main.ipFamilyPolicy | string | `nil` | Specify the ip policy. Options: SingleStack, PreferDualStack, RequireDualStack |
| service.main.labels | object | `{}` | Provide additional labels which may be required. |
| service.main.nameOverride | string | `nil` | Override the name suffix that is used for this service |
| service.main.ports | object | See below | Configure the Service port information here. Additional ports can be added by adding a dictionary key similar to the 'http' service. |
| service.main.ports.http.enabled | bool | `true` | Enables or disables the port |
| service.main.ports.http.nodePort | string | `nil` | Specify the nodePort value for the LoadBalancer and NodePort service types. [[ref]](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| service.main.ports.http.port | string | `nil` | The port number |
| service.main.ports.http.primary | bool | `true` | Make this the primary port (used in probes, notes, etc...) If there is more than 1 service, make sure that only 1 port is marked as primary. |
| service.main.ports.http.protocol | string | `"HTTP"` | Port protocol. Support values are `HTTP`, `HTTPS`, `TCP` and `UDP`. HTTPS and HTTPS spawn a TCP service and get used for internal URL and name generation |
| service.main.ports.http.targetPort | string | `nil` | Specify a service targetPort if you wish to differ the service port from the application port. If `targetPort` is specified, this port number is used in the container definition instead of the `port` value. Therefore named ports are not supported for this field. |
| service.main.primary | bool | `true` | Make this the primary service (used in probes, notes, etc...). If there is more than 1 service, make sure that only 1 service is marked as primary. |
| service.main.type | string | `"ClusterIP"` | Set the service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.labels | object | `{}` | Lables to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| termination.gracePeriodSeconds | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)] |
| termination.messagePath | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| termination.messagePolicy | string | `nil` | [[ref](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)] |
| tolerations | list | `[]` | Specify taint tolerations [[ref]](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |
| topologySpreadConstraints | list | `[]` | Defines topologySpreadConstraint rules. [[ref]](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/) |
| volumeClaimTemplates | list | `[]` | Used in conjunction with `controller.type: statefulset` to create individual disks for each instance. |
| vpa.enabled | bool | `false` |  |
| vpa.resourcePolicy.containerPolicies[0].containerName | string | `"*"` |  |
| vpa.resourcePolicy.containerPolicies[0].controlledResources[0] | string | `"cpu"` |  |
| vpa.resourcePolicy.containerPolicies[0].controlledResources[1] | string | `"memory"` |  |
| vpa.resourcePolicy.containerPolicies[0].maxAllowed.cpu | int | `2` |  |
| vpa.resourcePolicy.containerPolicies[0].maxAllowed.memory | string | `"2Gi"` |  |
| vpa.resourcePolicy.containerPolicies[0].minAllowed.cpu | string | `"100m"` |  |
| vpa.resourcePolicy.containerPolicies[0].minAllowed.memory | string | `"128Mi"` |  |
| vpa.updatePolicy.updateMode | string | `"Auto"` |  |

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for the release history of this chart.

## Support

- Open an [issue](https://github.com/blissflow-tech/library-charts/issues/new/choose)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
