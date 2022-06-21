terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
  }
}

resource "kubectl_manifest" "org_virtualservers" {

    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.8.0
  creationTimestamp: null
  name: virtualservers.k8s.nginx.org
spec:
  group: k8s.nginx.org
  names:
    kind: VirtualServer
    listKind: VirtualServerList
    plural: virtualservers
    shortNames:
      - vs
    singular: virtualserver
  scope: Namespaced
  versions:
    - additionalPrinterColumns:
        - description: Current state of the VirtualServer. If the resource has a valid status, it means it has been validated and accepted by the Ingress Controller.
          jsonPath: .status.state
          name: State
          type: string
        - jsonPath: .spec.host
          name: Host
          type: string
        - jsonPath: .status.externalEndpoints[*].ip
          name: IP
          type: string
        - jsonPath: .status.externalEndpoints[*].ports
          name: Ports
          type: string
        - jsonPath: .metadata.creationTimestamp
          name: Age
          type: date
      name: v1
      schema:
        openAPIV3Schema:
          description: VirtualServer defines the VirtualServer resource.
          type: object
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: VirtualServerSpec is the spec of the VirtualServer resource.
              type: object
              properties:
                dos:
                  type: string
                host:
                  type: string
                http-snippets:
                  type: string
                ingressClassName:
                  type: string
                policies:
                  type: array
                  items:
                    description: PolicyReference references a policy by name and an optional namespace.
                    type: object
                    properties:
                      name:
                        type: string
                      namespace:
                        type: string
                routes:
                  type: array
                  items:
                    description: Route defines a route.
                    type: object
                    properties:
                      action:
                        description: Action defines an action.
                        type: object
                        properties:
                          pass:
                            type: string
                          proxy:
                            description: ActionProxy defines a proxy in an Action.
                            type: object
                            properties:
                              requestHeaders:
                                description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                type: object
                                properties:
                                  pass:
                                    type: boolean
                                  set:
                                    type: array
                                    items:
                                      description: Header defines an HTTP Header.
                                      type: object
                                      properties:
                                        name:
                                          type: string
                                        value:
                                          type: string
                              responseHeaders:
                                description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                type: object
                                properties:
                                  add:
                                    type: array
                                    items:
                                      description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                      type: object
                                      properties:
                                        always:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                  hide:
                                    type: array
                                    items:
                                      type: string
                                  ignore:
                                    type: array
                                    items:
                                      type: string
                                  pass:
                                    type: array
                                    items:
                                      type: string
                              rewritePath:
                                type: string
                              upstream:
                                type: string
                          redirect:
                            description: ActionRedirect defines a redirect in an Action.
                            type: object
                            properties:
                              code:
                                type: integer
                              url:
                                type: string
                          return:
                            description: ActionReturn defines a return in an Action.
                            type: object
                            properties:
                              body:
                                type: string
                              code:
                                type: integer
                              type:
                                type: string
                      dos:
                        type: string
                      errorPages:
                        type: array
                        items:
                          description: ErrorPage defines an ErrorPage in a Route.
                          type: object
                          properties:
                            codes:
                              type: array
                              items:
                                type: integer
                            redirect:
                              description: ErrorPageRedirect defines a redirect for an ErrorPage.
                              type: object
                              properties:
                                code:
                                  type: integer
                                url:
                                  type: string
                            return:
                              description: ErrorPageReturn defines a return for an ErrorPage.
                              type: object
                              properties:
                                body:
                                  type: string
                                code:
                                  type: integer
                                headers:
                                  type: array
                                  items:
                                    description: Header defines an HTTP Header.
                                    type: object
                                    properties:
                                      name:
                                        type: string
                                      value:
                                        type: string
                                type:
                                  type: string
                      location-snippets:
                        type: string
                      matches:
                        type: array
                        items:
                          description: Match defines a match.
                          type: object
                          properties:
                            action:
                              description: Action defines an action.
                              type: object
                              properties:
                                pass:
                                  type: string
                                proxy:
                                  description: ActionProxy defines a proxy in an Action.
                                  type: object
                                  properties:
                                    requestHeaders:
                                      description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        pass:
                                          type: boolean
                                        set:
                                          type: array
                                          items:
                                            description: Header defines an HTTP Header.
                                            type: object
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                    responseHeaders:
                                      description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        add:
                                          type: array
                                          items:
                                            description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                            type: object
                                            properties:
                                              always:
                                                type: boolean
                                              name:
                                                type: string
                                              value:
                                                type: string
                                        hide:
                                          type: array
                                          items:
                                            type: string
                                        ignore:
                                          type: array
                                          items:
                                            type: string
                                        pass:
                                          type: array
                                          items:
                                            type: string
                                    rewritePath:
                                      type: string
                                    upstream:
                                      type: string
                                redirect:
                                  description: ActionRedirect defines a redirect in an Action.
                                  type: object
                                  properties:
                                    code:
                                      type: integer
                                    url:
                                      type: string
                                return:
                                  description: ActionReturn defines a return in an Action.
                                  type: object
                                  properties:
                                    body:
                                      type: string
                                    code:
                                      type: integer
                                    type:
                                      type: string
                            conditions:
                              type: array
                              items:
                                description: Condition defines a condition in a MatchRule.
                                type: object
                                properties:
                                  argument:
                                    type: string
                                  cookie:
                                    type: string
                                  header:
                                    type: string
                                  value:
                                    type: string
                                  variable:
                                    type: string
                            splits:
                              type: array
                              items:
                                description: Split defines a split.
                                type: object
                                properties:
                                  action:
                                    description: Action defines an action.
                                    type: object
                                    properties:
                                      pass:
                                        type: string
                                      proxy:
                                        description: ActionProxy defines a proxy in an Action.
                                        type: object
                                        properties:
                                          requestHeaders:
                                            description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                            type: object
                                            properties:
                                              pass:
                                                type: boolean
                                              set:
                                                type: array
                                                items:
                                                  description: Header defines an HTTP Header.
                                                  type: object
                                                  properties:
                                                    name:
                                                      type: string
                                                    value:
                                                      type: string
                                          responseHeaders:
                                            description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                            type: object
                                            properties:
                                              add:
                                                type: array
                                                items:
                                                  description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                                  type: object
                                                  properties:
                                                    always:
                                                      type: boolean
                                                    name:
                                                      type: string
                                                    value:
                                                      type: string
                                              hide:
                                                type: array
                                                items:
                                                  type: string
                                              ignore:
                                                type: array
                                                items:
                                                  type: string
                                              pass:
                                                type: array
                                                items:
                                                  type: string
                                          rewritePath:
                                            type: string
                                          upstream:
                                            type: string
                                      redirect:
                                        description: ActionRedirect defines a redirect in an Action.
                                        type: object
                                        properties:
                                          code:
                                            type: integer
                                          url:
                                            type: string
                                      return:
                                        description: ActionReturn defines a return in an Action.
                                        type: object
                                        properties:
                                          body:
                                            type: string
                                          code:
                                            type: integer
                                          type:
                                            type: string
                                  weight:
                                    type: integer
                      path:
                        type: string
                      policies:
                        type: array
                        items:
                          description: PolicyReference references a policy by name and an optional namespace.
                          type: object
                          properties:
                            name:
                              type: string
                            namespace:
                              type: string
                      route:
                        type: string
                      splits:
                        type: array
                        items:
                          description: Split defines a split.
                          type: object
                          properties:
                            action:
                              description: Action defines an action.
                              type: object
                              properties:
                                pass:
                                  type: string
                                proxy:
                                  description: ActionProxy defines a proxy in an Action.
                                  type: object
                                  properties:
                                    requestHeaders:
                                      description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        pass:
                                          type: boolean
                                        set:
                                          type: array
                                          items:
                                            description: Header defines an HTTP Header.
                                            type: object
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                    responseHeaders:
                                      description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        add:
                                          type: array
                                          items:
                                            description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                            type: object
                                            properties:
                                              always:
                                                type: boolean
                                              name:
                                                type: string
                                              value:
                                                type: string
                                        hide:
                                          type: array
                                          items:
                                            type: string
                                        ignore:
                                          type: array
                                          items:
                                            type: string
                                        pass:
                                          type: array
                                          items:
                                            type: string
                                    rewritePath:
                                      type: string
                                    upstream:
                                      type: string
                                redirect:
                                  description: ActionRedirect defines a redirect in an Action.
                                  type: object
                                  properties:
                                    code:
                                      type: integer
                                    url:
                                      type: string
                                return:
                                  description: ActionReturn defines a return in an Action.
                                  type: object
                                  properties:
                                    body:
                                      type: string
                                    code:
                                      type: integer
                                    type:
                                      type: string
                            weight:
                              type: integer
                server-snippets:
                  type: string
                tls:
                  description: TLS defines TLS configuration for a VirtualServer.
                  type: object
                  properties:
                    cert-manager:
                      description: CertManager defines a cert manager config for a TLS.
                      type: object
                      properties:
                        cluster-issuer:
                          type: string
                        common-name:
                          type: string
                        duration:
                          type: string
                        issuer:
                          type: string
                        issuer-group:
                          type: string
                        issuer-kind:
                          type: string
                        renew-before:
                          type: string
                        usages:
                          type: string
                    redirect:
                      description: TLSRedirect defines a redirect for a TLS.
                      type: object
                      properties:
                        basedOn:
                          type: string
                        code:
                          type: integer
                        enable:
                          type: boolean
                    secret:
                      type: string
                upstreams:
                  type: array
                  items:
                    description: Upstream defines an upstream.
                    type: object
                    properties:
                      buffer-size:
                        type: string
                      buffering:
                        type: boolean
                      buffers:
                        description: UpstreamBuffers defines Buffer Configuration for an Upstream.
                        type: object
                        properties:
                          number:
                            type: integer
                          size:
                            type: string
                      client-max-body-size:
                        type: string
                      connect-timeout:
                        type: string
                      fail-timeout:
                        type: string
                      healthCheck:
                        description: HealthCheck defines the parameters for active Upstream HealthChecks.
                        type: object
                        properties:
                          connect-timeout:
                            type: string
                          enable:
                            type: boolean
                          fails:
                            type: integer
                          grpcService:
                            type: string
                          grpcStatus:
                            type: integer
                          headers:
                            type: array
                            items:
                              description: Header defines an HTTP Header.
                              type: object
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                          interval:
                            type: string
                          jitter:
                            type: string
                          mandatory:
                            type: boolean
                          passes:
                            type: integer
                          path:
                            type: string
                          persistent:
                            type: boolean
                          port:
                            type: integer
                          read-timeout:
                            type: string
                          send-timeout:
                            type: string
                          statusMatch:
                            type: string
                          tls:
                            description: UpstreamTLS defines a TLS configuration for an Upstream.
                            type: object
                            properties:
                              enable:
                                type: boolean
                      keepalive:
                        type: integer
                      lb-method:
                        type: string
                      max-conns:
                        type: integer
                      max-fails:
                        type: integer
                      name:
                        type: string
                      next-upstream:
                        type: string
                      next-upstream-timeout:
                        type: string
                      next-upstream-tries:
                        type: integer
                      ntlm:
                        type: boolean
                      port:
                        type: integer
                      queue:
                        description: UpstreamQueue defines Queue Configuration for an Upstream.
                        type: object
                        properties:
                          size:
                            type: integer
                          timeout:
                            type: string
                      read-timeout:
                        type: string
                      send-timeout:
                        type: string
                      service:
                        type: string
                      sessionCookie:
                        description: SessionCookie defines the parameters for session persistence.
                        type: object
                        properties:
                          domain:
                            type: string
                          enable:
                            type: boolean
                          expires:
                            type: string
                          httpOnly:
                            type: boolean
                          name:
                            type: string
                          path:
                            type: string
                          secure:
                            type: boolean
                      slow-start:
                        type: string
                      subselector:
                        type: object
                        additionalProperties:
                          type: string
                      tls:
                        description: UpstreamTLS defines a TLS configuration for an Upstream.
                        type: object
                        properties:
                          enable:
                            type: boolean
                      type:
                        type: string
                      use-cluster-ip:
                        type: boolean
            status:
              description: VirtualServerStatus defines the status for the VirtualServer resource.
              type: object
              properties:
                externalEndpoints:
                  type: array
                  items:
                    description: ExternalEndpoint defines the IP and ports used to connect to this resource.
                    type: object
                    properties:
                      ip:
                        type: string
                      ports:
                        type: string
                message:
                  type: string
                reason:
                  type: string
                state:
                  type: string
      served: true
      storage: true
      subresources:
        status: {}
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
    YAML
}

resource "kubectl_manifest" "org_virtualserverroutes" {

    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.8.0
  creationTimestamp: null
  name: virtualserverroutes.k8s.nginx.org
spec:
  group: k8s.nginx.org
  names:
    kind: VirtualServerRoute
    listKind: VirtualServerRouteList
    plural: virtualserverroutes
    shortNames:
      - vsr
    singular: virtualserverroute
  scope: Namespaced
  versions:
    - additionalPrinterColumns:
        - description: Current state of the VirtualServerRoute. If the resource has a valid status, it means it has been validated and accepted by the Ingress Controller.
          jsonPath: .status.state
          name: State
          type: string
        - jsonPath: .spec.host
          name: Host
          type: string
        - jsonPath: .status.externalEndpoints[*].ip
          name: IP
          type: string
        - jsonPath: .status.externalEndpoints[*].ports
          name: Ports
          type: string
        - jsonPath: .metadata.creationTimestamp
          name: Age
          type: date
      name: v1
      schema:
        openAPIV3Schema:
          description: VirtualServerRoute defines the VirtualServerRoute resource.
          type: object
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: VirtualServerRouteSpec is the spec of the VirtualServerRoute resource.
              type: object
              properties:
                host:
                  type: string
                ingressClassName:
                  type: string
                subroutes:
                  type: array
                  items:
                    description: Route defines a route.
                    type: object
                    properties:
                      action:
                        description: Action defines an action.
                        type: object
                        properties:
                          pass:
                            type: string
                          proxy:
                            description: ActionProxy defines a proxy in an Action.
                            type: object
                            properties:
                              requestHeaders:
                                description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                type: object
                                properties:
                                  pass:
                                    type: boolean
                                  set:
                                    type: array
                                    items:
                                      description: Header defines an HTTP Header.
                                      type: object
                                      properties:
                                        name:
                                          type: string
                                        value:
                                          type: string
                              responseHeaders:
                                description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                type: object
                                properties:
                                  add:
                                    type: array
                                    items:
                                      description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                      type: object
                                      properties:
                                        always:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                  hide:
                                    type: array
                                    items:
                                      type: string
                                  ignore:
                                    type: array
                                    items:
                                      type: string
                                  pass:
                                    type: array
                                    items:
                                      type: string
                              rewritePath:
                                type: string
                              upstream:
                                type: string
                          redirect:
                            description: ActionRedirect defines a redirect in an Action.
                            type: object
                            properties:
                              code:
                                type: integer
                              url:
                                type: string
                          return:
                            description: ActionReturn defines a return in an Action.
                            type: object
                            properties:
                              body:
                                type: string
                              code:
                                type: integer
                              type:
                                type: string
                      dos:
                        type: string
                      errorPages:
                        type: array
                        items:
                          description: ErrorPage defines an ErrorPage in a Route.
                          type: object
                          properties:
                            codes:
                              type: array
                              items:
                                type: integer
                            redirect:
                              description: ErrorPageRedirect defines a redirect for an ErrorPage.
                              type: object
                              properties:
                                code:
                                  type: integer
                                url:
                                  type: string
                            return:
                              description: ErrorPageReturn defines a return for an ErrorPage.
                              type: object
                              properties:
                                body:
                                  type: string
                                code:
                                  type: integer
                                headers:
                                  type: array
                                  items:
                                    description: Header defines an HTTP Header.
                                    type: object
                                    properties:
                                      name:
                                        type: string
                                      value:
                                        type: string
                                type:
                                  type: string
                      location-snippets:
                        type: string
                      matches:
                        type: array
                        items:
                          description: Match defines a match.
                          type: object
                          properties:
                            action:
                              description: Action defines an action.
                              type: object
                              properties:
                                pass:
                                  type: string
                                proxy:
                                  description: ActionProxy defines a proxy in an Action.
                                  type: object
                                  properties:
                                    requestHeaders:
                                      description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        pass:
                                          type: boolean
                                        set:
                                          type: array
                                          items:
                                            description: Header defines an HTTP Header.
                                            type: object
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                    responseHeaders:
                                      description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        add:
                                          type: array
                                          items:
                                            description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                            type: object
                                            properties:
                                              always:
                                                type: boolean
                                              name:
                                                type: string
                                              value:
                                                type: string
                                        hide:
                                          type: array
                                          items:
                                            type: string
                                        ignore:
                                          type: array
                                          items:
                                            type: string
                                        pass:
                                          type: array
                                          items:
                                            type: string
                                    rewritePath:
                                      type: string
                                    upstream:
                                      type: string
                                redirect:
                                  description: ActionRedirect defines a redirect in an Action.
                                  type: object
                                  properties:
                                    code:
                                      type: integer
                                    url:
                                      type: string
                                return:
                                  description: ActionReturn defines a return in an Action.
                                  type: object
                                  properties:
                                    body:
                                      type: string
                                    code:
                                      type: integer
                                    type:
                                      type: string
                            conditions:
                              type: array
                              items:
                                description: Condition defines a condition in a MatchRule.
                                type: object
                                properties:
                                  argument:
                                    type: string
                                  cookie:
                                    type: string
                                  header:
                                    type: string
                                  value:
                                    type: string
                                  variable:
                                    type: string
                            splits:
                              type: array
                              items:
                                description: Split defines a split.
                                type: object
                                properties:
                                  action:
                                    description: Action defines an action.
                                    type: object
                                    properties:
                                      pass:
                                        type: string
                                      proxy:
                                        description: ActionProxy defines a proxy in an Action.
                                        type: object
                                        properties:
                                          requestHeaders:
                                            description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                            type: object
                                            properties:
                                              pass:
                                                type: boolean
                                              set:
                                                type: array
                                                items:
                                                  description: Header defines an HTTP Header.
                                                  type: object
                                                  properties:
                                                    name:
                                                      type: string
                                                    value:
                                                      type: string
                                          responseHeaders:
                                            description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                            type: object
                                            properties:
                                              add:
                                                type: array
                                                items:
                                                  description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                                  type: object
                                                  properties:
                                                    always:
                                                      type: boolean
                                                    name:
                                                      type: string
                                                    value:
                                                      type: string
                                              hide:
                                                type: array
                                                items:
                                                  type: string
                                              ignore:
                                                type: array
                                                items:
                                                  type: string
                                              pass:
                                                type: array
                                                items:
                                                  type: string
                                          rewritePath:
                                            type: string
                                          upstream:
                                            type: string
                                      redirect:
                                        description: ActionRedirect defines a redirect in an Action.
                                        type: object
                                        properties:
                                          code:
                                            type: integer
                                          url:
                                            type: string
                                      return:
                                        description: ActionReturn defines a return in an Action.
                                        type: object
                                        properties:
                                          body:
                                            type: string
                                          code:
                                            type: integer
                                          type:
                                            type: string
                                  weight:
                                    type: integer
                      path:
                        type: string
                      policies:
                        type: array
                        items:
                          description: PolicyReference references a policy by name and an optional namespace.
                          type: object
                          properties:
                            name:
                              type: string
                            namespace:
                              type: string
                      route:
                        type: string
                      splits:
                        type: array
                        items:
                          description: Split defines a split.
                          type: object
                          properties:
                            action:
                              description: Action defines an action.
                              type: object
                              properties:
                                pass:
                                  type: string
                                proxy:
                                  description: ActionProxy defines a proxy in an Action.
                                  type: object
                                  properties:
                                    requestHeaders:
                                      description: ProxyRequestHeaders defines the request headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        pass:
                                          type: boolean
                                        set:
                                          type: array
                                          items:
                                            description: Header defines an HTTP Header.
                                            type: object
                                            properties:
                                              name:
                                                type: string
                                              value:
                                                type: string
                                    responseHeaders:
                                      description: ProxyResponseHeaders defines the response headers manipulation in an ActionProxy.
                                      type: object
                                      properties:
                                        add:
                                          type: array
                                          items:
                                            description: AddHeader defines an HTTP Header with an optional Always field to use with the add_header NGINX directive.
                                            type: object
                                            properties:
                                              always:
                                                type: boolean
                                              name:
                                                type: string
                                              value:
                                                type: string
                                        hide:
                                          type: array
                                          items:
                                            type: string
                                        ignore:
                                          type: array
                                          items:
                                            type: string
                                        pass:
                                          type: array
                                          items:
                                            type: string
                                    rewritePath:
                                      type: string
                                    upstream:
                                      type: string
                                redirect:
                                  description: ActionRedirect defines a redirect in an Action.
                                  type: object
                                  properties:
                                    code:
                                      type: integer
                                    url:
                                      type: string
                                return:
                                  description: ActionReturn defines a return in an Action.
                                  type: object
                                  properties:
                                    body:
                                      type: string
                                    code:
                                      type: integer
                                    type:
                                      type: string
                            weight:
                              type: integer
                upstreams:
                  type: array
                  items:
                    description: Upstream defines an upstream.
                    type: object
                    properties:
                      buffer-size:
                        type: string
                      buffering:
                        type: boolean
                      buffers:
                        description: UpstreamBuffers defines Buffer Configuration for an Upstream.
                        type: object
                        properties:
                          number:
                            type: integer
                          size:
                            type: string
                      client-max-body-size:
                        type: string
                      connect-timeout:
                        type: string
                      fail-timeout:
                        type: string
                      healthCheck:
                        description: HealthCheck defines the parameters for active Upstream HealthChecks.
                        type: object
                        properties:
                          connect-timeout:
                            type: string
                          enable:
                            type: boolean
                          fails:
                            type: integer
                          grpcService:
                            type: string
                          grpcStatus:
                            type: integer
                          headers:
                            type: array
                            items:
                              description: Header defines an HTTP Header.
                              type: object
                              properties:
                                name:
                                  type: string
                                value:
                                  type: string
                          interval:
                            type: string
                          jitter:
                            type: string
                          mandatory:
                            type: boolean
                          passes:
                            type: integer
                          path:
                            type: string
                          persistent:
                            type: boolean
                          port:
                            type: integer
                          read-timeout:
                            type: string
                          send-timeout:
                            type: string
                          statusMatch:
                            type: string
                          tls:
                            description: UpstreamTLS defines a TLS configuration for an Upstream.
                            type: object
                            properties:
                              enable:
                                type: boolean
                      keepalive:
                        type: integer
                      lb-method:
                        type: string
                      max-conns:
                        type: integer
                      max-fails:
                        type: integer
                      name:
                        type: string
                      next-upstream:
                        type: string
                      next-upstream-timeout:
                        type: string
                      next-upstream-tries:
                        type: integer
                      ntlm:
                        type: boolean
                      port:
                        type: integer
                      queue:
                        description: UpstreamQueue defines Queue Configuration for an Upstream.
                        type: object
                        properties:
                          size:
                            type: integer
                          timeout:
                            type: string
                      read-timeout:
                        type: string
                      send-timeout:
                        type: string
                      service:
                        type: string
                      sessionCookie:
                        description: SessionCookie defines the parameters for session persistence.
                        type: object
                        properties:
                          domain:
                            type: string
                          enable:
                            type: boolean
                          expires:
                            type: string
                          httpOnly:
                            type: boolean
                          name:
                            type: string
                          path:
                            type: string
                          secure:
                            type: boolean
                      slow-start:
                        type: string
                      subselector:
                        type: object
                        additionalProperties:
                          type: string
                      tls:
                        description: UpstreamTLS defines a TLS configuration for an Upstream.
                        type: object
                        properties:
                          enable:
                            type: boolean
                      type:
                        type: string
                      use-cluster-ip:
                        type: boolean
            status:
              description: VirtualServerRouteStatus defines the status for the VirtualServerRoute resource.
              type: object
              properties:
                externalEndpoints:
                  type: array
                  items:
                    description: ExternalEndpoint defines the IP and ports used to connect to this resource.
                    type: object
                    properties:
                      ip:
                        type: string
                      ports:
                        type: string
                message:
                  type: string
                reason:
                  type: string
                referencedBy:
                  type: string
                state:
                  type: string
      served: true
      storage: true
      subresources:
        status: {}
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
    YAML
}


resource "kubectl_manifest" "org_policies" {

    yaml_body = <<YAML
    apiVersion: apiextensions.k8s.io/v1
    kind: CustomResourceDefinition
    metadata:
      annotations:
        controller-gen.kubebuilder.io/version: v0.8.0
      creationTimestamp: null
      name: policies.k8s.nginx.org
    spec:
      group: k8s.nginx.org
      names:
        kind: Policy
        listKind: PolicyList
        plural: policies
        shortNames:
          - pol
        singular: policy
      scope: Namespaced
      versions:
        - additionalPrinterColumns:
            - description: Current state of the Policy. If the resource has a valid status, it means it has been validated and accepted by the Ingress Controller.
              jsonPath: .status.state
              name: State
              type: string
            - jsonPath: .metadata.creationTimestamp
              name: Age
              type: date
          name: v1
          schema:
            openAPIV3Schema:
              description: Policy defines a Policy for VirtualServer and VirtualServerRoute resources.
              type: object
              properties:
                apiVersion:
                  description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
                  type: string
                kind:
                  description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                  type: string
                metadata:
                  type: object
                spec:
                  description: PolicySpec is the spec of the Policy resource. The spec includes multiple fields, where each field represents a different policy. Only one policy (field) is allowed.
                  type: object
                  properties:
                    accessControl:
                      description: AccessControl defines an access policy based on the source IP of a request.
                      type: object
                      properties:
                        allow:
                          type: array
                          items:
                            type: string
                        deny:
                          type: array
                          items:
                            type: string
                    egressMTLS:
                      description: EgressMTLS defines an Egress MTLS policy.
                      type: object
                      properties:
                        ciphers:
                          type: string
                        protocols:
                          type: string
                        serverName:
                          type: boolean
                        sessionReuse:
                          type: boolean
                        sslName:
                          type: string
                        tlsSecret:
                          type: string
                        trustedCertSecret:
                          type: string
                        verifyDepth:
                          type: integer
                        verifyServer:
                          type: boolean
                    ingressClassName:
                      type: string
                    ingressMTLS:
                      description: IngressMTLS defines an Ingress MTLS policy.
                      type: object
                      properties:
                        clientCertSecret:
                          type: string
                        verifyClient:
                          type: string
                        verifyDepth:
                          type: integer
                    jwt:
                      description: JWTAuth holds JWT authentication configuration.
                      type: object
                      properties:
                        realm:
                          type: string
                        secret:
                          type: string
                        token:
                          type: string
                    oidc:
                      description: OIDC defines an Open ID Connect policy.
                      type: object
                      properties:
                        authEndpoint:
                          type: string
                        clientID:
                          type: string
                        clientSecret:
                          type: string
                        jwksURI:
                          type: string
                        redirectURI:
                          type: string
                        scope:
                          type: string
                        tokenEndpoint:
                          type: string
                        zoneSyncLeeway:
                          type: integer
                    rateLimit:
                      description: RateLimit defines a rate limit policy.
                      type: object
                      properties:
                        burst:
                          type: integer
                        delay:
                          type: integer
                        dryRun:
                          type: boolean
                        key:
                          type: string
                        logLevel:
                          type: string
                        noDelay:
                          type: boolean
                        rate:
                          type: string
                        rejectCode:
                          type: integer
                        zoneSize:
                          type: string
                    waf:
                      description: WAF defines an WAF policy.
                      type: object
                      properties:
                        apPolicy:
                          type: string
                        enable:
                          type: boolean
                        securityLog:
                          description: SecurityLog defines the security log of a WAF policy.
                          type: object
                          properties:
                            apLogConf:
                              type: string
                            enable:
                              type: boolean
                            logDest:
                              type: string
                        securityLogs:
                          type: array
                          items:
                            description: SecurityLog defines the security log of a WAF policy.
                            type: object
                            properties:
                              apLogConf:
                                type: string
                              enable:
                                type: boolean
                              logDest:
                                type: string
                status:
                  description: PolicyStatus is the status of the policy resource
                  type: object
                  properties:
                    message:
                      type: string
                    reason:
                      type: string
                    state:
                      type: string
          served: true
          storage: true
          subresources:
            status: {}
        - name: v1alpha1
          schema:
            openAPIV3Schema:
              description: Policy defines a Policy for VirtualServer and VirtualServerRoute resources.
              type: object
              properties:
                apiVersion:
                  description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
                  type: string
                kind:
                  description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                  type: string
                metadata:
                  type: object
                spec:
                  description: PolicySpec is the spec of the Policy resource. The spec includes multiple fields, where each field represents a different policy. Only one policy (field) is allowed.
                  type: object
                  properties:
                    accessControl:
                      description: AccessControl defines an access policy based on the source IP of a request.
                      type: object
                      properties:
                        allow:
                          type: array
                          items:
                            type: string
                        deny:
                          type: array
                          items:
                            type: string
                    egressMTLS:
                      description: EgressMTLS defines an Egress MTLS policy.
                      type: object
                      properties:
                        ciphers:
                          type: string
                        protocols:
                          type: string
                        serverName:
                          type: boolean
                        sessionReuse:
                          type: boolean
                        sslName:
                          type: string
                        tlsSecret:
                          type: string
                        trustedCertSecret:
                          type: string
                        verifyDepth:
                          type: integer
                        verifyServer:
                          type: boolean
                    ingressMTLS:
                      description: IngressMTLS defines an Ingress MTLS policy.
                      type: object
                      properties:
                        clientCertSecret:
                          type: string
                        verifyClient:
                          type: string
                        verifyDepth:
                          type: integer
                    jwt:
                      description: JWTAuth holds JWT authentication configuration.
                      type: object
                      properties:
                        realm:
                          type: string
                        secret:
                          type: string
                        token:
                          type: string
                    rateLimit:
                      description: RateLimit defines a rate limit policy.
                      type: object
                      properties:
                        burst:
                          type: integer
                        delay:
                          type: integer
                        dryRun:
                          type: boolean
                        key:
                          type: string
                        logLevel:
                          type: string
                        noDelay:
                          type: boolean
                        rate:
                          type: string
                        rejectCode:
                          type: integer
                        zoneSize:
                          type: string
          served: true
          storage: false
    status:
      acceptedNames:
        kind: ""
        plural: ""
      conditions: []
      storedVersions: []
    YAML
}


resource "kubectl_manifest" "org_transportservers" {

    yaml_body = <<YAML
    apiVersion: apiextensions.k8s.io/v1
    kind: CustomResourceDefinition
    metadata:
      annotations:
        controller-gen.kubebuilder.io/version: v0.8.0
      creationTimestamp: null
      name: transportservers.k8s.nginx.org
    spec:
      group: k8s.nginx.org
      names:
        kind: TransportServer
        listKind: TransportServerList
        plural: transportservers
        shortNames:
          - ts
        singular: transportserver
      scope: Namespaced
      versions:
        - additionalPrinterColumns:
            - description: Current state of the TransportServer. If the resource has a valid status, it means it has been validated and accepted by the Ingress Controller.
              jsonPath: .status.state
              name: State
              type: string
            - jsonPath: .status.reason
              name: Reason
              type: string
            - jsonPath: .metadata.creationTimestamp
              name: Age
              type: date
          name: v1alpha1
          schema:
            openAPIV3Schema:
              description: TransportServer defines the TransportServer resource.
              type: object
              properties:
                apiVersion:
                  description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
                  type: string
                kind:
                  description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                  type: string
                metadata:
                  type: object
                spec:
                  description: TransportServerSpec is the spec of the TransportServer resource.
                  type: object
                  properties:
                    action:
                      description: Action defines an action.
                      type: object
                      properties:
                        pass:
                          type: string
                    host:
                      type: string
                    ingressClassName:
                      type: string
                    listener:
                      description: TransportServerListener defines a listener for a TransportServer.
                      type: object
                      properties:
                        name:
                          type: string
                        protocol:
                          type: string
                    serverSnippets:
                      type: string
                    sessionParameters:
                      description: SessionParameters defines session parameters.
                      type: object
                      properties:
                        timeout:
                          type: string
                    streamSnippets:
                      type: string
                    upstreamParameters:
                      description: UpstreamParameters defines parameters for an upstream.
                      type: object
                      properties:
                        connectTimeout:
                          type: string
                        nextUpstream:
                          type: boolean
                        nextUpstreamTimeout:
                          type: string
                        nextUpstreamTries:
                          type: integer
                        udpRequests:
                          type: integer
                        udpResponses:
                          type: integer
                    upstreams:
                      type: array
                      items:
                        description: Upstream defines an upstream.
                        type: object
                        properties:
                          failTimeout:
                            type: string
                          healthCheck:
                            description: HealthCheck defines the parameters for active Upstream HealthChecks.
                            type: object
                            properties:
                              enable:
                                type: boolean
                              fails:
                                type: integer
                              interval:
                                type: string
                              jitter:
                                type: string
                              match:
                                description: Match defines the parameters of a custom health check.
                                type: object
                                properties:
                                  expect:
                                    type: string
                                  send:
                                    type: string
                              passes:
                                type: integer
                              port:
                                type: integer
                              timeout:
                                type: string
                          loadBalancingMethod:
                            type: string
                          maxConns:
                            type: integer
                          maxFails:
                            type: integer
                          name:
                            type: string
                          port:
                            type: integer
                          service:
                            type: string
                status:
                  description: TransportServerStatus defines the status for the TransportServer resource.
                  type: object
                  properties:
                    message:
                      type: string
                    reason:
                      type: string
                    state:
                      type: string
          served: true
          storage: true
          subresources:
            status: {}
    status:
      acceptedNames:
        kind: ""
        plural: ""
      conditions: []
      storedVersions: []
    YAML
}


resource "kubectl_manifest" "org_globalconfigurations" {

    yaml_body = <<YAML
    apiVersion: apiextensions.k8s.io/v1
    kind: CustomResourceDefinition
    metadata:
      annotations:
        controller-gen.kubebuilder.io/version: v0.8.0
      creationTimestamp: null
      name: globalconfigurations.k8s.nginx.org
    spec:
      group: k8s.nginx.org
      names:
        kind: GlobalConfiguration
        listKind: GlobalConfigurationList
        plural: globalconfigurations
        shortNames:
          - gc
        singular: globalconfiguration
      scope: Namespaced
      versions:
        - name: v1alpha1
          schema:
            openAPIV3Schema:
              description: GlobalConfiguration defines the GlobalConfiguration resource.
              type: object
              properties:
                apiVersion:
                  description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
                  type: string
                kind:
                  description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
                  type: string
                metadata:
                  type: object
                spec:
                  description: GlobalConfigurationSpec is the spec of the GlobalConfiguration resource.
                  type: object
                  properties:
                    listeners:
                      type: array
                      items:
                        description: Listener defines a listener.
                        type: object
                        properties:
                          name:
                            type: string
                          port:
                            type: integer
                          protocol:
                            type: string
          served: true
          storage: true
    status:
      acceptedNames:
        kind: ""
        plural: ""
      conditions: []
      storedVersions: []
    YAML
}

resource "kubectl_manifest" "com_dosprotectedresources" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.7.0
  creationTimestamp: null
  name: dosprotectedresources.appprotectdos.f5.com
spec:
  group: appprotectdos.f5.com
  names:
    kind: DosProtectedResource
    listKind: DosProtectedResourceList
    plural: dosprotectedresources
    shortNames:
      - pr
    singular: dosprotectedresource
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          description: DosProtectedResource defines a Dos protected resource.
          type: object
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: DosProtectedResourceSpec defines the properties and values a DosProtectedResource can have.
              type: object
              properties:
                apDosMonitor:
                  description: 'ApDosMonitor is how NGINX App Protect DoS monitors the stress level of the protected object. The monitor requests are sent from localhost (127.0.0.1). Default value: URI - None, protocol - http1, timeout - NGINX App Protect DoS default.'
                  type: object
                  properties:
                    protocol:
                      description: Protocol determines if the server listens on http1 / http2 / grpc. The default is http1.
                      type: string
                      enum:
                        - http1
                        - http2
                        - grpc
                    timeout:
                      description: Timeout determines how long (in seconds) should NGINX App Protect DoS wait for a response. Default is 10 seconds for http1/http2 and 5 seconds for grpc.
                      type: integer
                      format: int64
                    uri:
                      description: 'URI is the destination to the desired protected object in the nginx.conf:'
                      type: string
                apDosPolicy:
                  description: ApDosPolicy is the namespace/name of a ApDosPolicy resource
                  type: string
                dosAccessLogDest:
                  description: DosAccessLogDest is the network address for the access logs
                  type: string
                dosSecurityLog:
                  description: DosSecurityLog defines the security log of the DosProtectedResource.
                  type: object
                  properties:
                    apDosLogConf:
                      description: ApDosLogConf is the namespace/name of a APDosLogConf resource
                      type: string
                    dosLogDest:
                      description: DosLogDest is the network address of a logging service, can be either IP or DNS name.
                      type: string
                    enable:
                      description: Enable enables the security logging feature if set to true
                      type: boolean
                enable:
                  description: Enable enables the DOS feature if set to true
                  type: boolean
                name:
                  description: Name is the name of protected object, max of 63 characters.
                  type: string
      served: true
      storage: true
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []
    YAML
}

resource "kubectl_manifest" "com_apdospolicy" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.0
  creationTimestamp: null
  name: apdospolicies.appprotectdos.f5.com
spec:
  group: appprotectdos.f5.com
  names:
    kind: APDosPolicy
    listKind: APDosPoliciesList
    plural: apdospolicies
    singular: apdospolicy
  preserveUnknownFields: false
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          type: object
          description: APDosPolicy is the Schema for the APDosPolicy API
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              type: object
              description: APDosPolicySpec defines the desired state of APDosPolicy
              properties:
                mitigation_mode:
                  enum:
                    - "standard"
                    - "conservative"
                    - "none"
                  default: "standard"
                  type: string
                signatures:
                  enum:
                    - "on"
                    - "off"
                  default: "on"
                  type: string
                bad_actors:
                  enum:
                    - "on"
                    - "off"
                  default: "on"
                  type: string
                automation_tools_detection:
                  enum:
                    - "on"
                    - "off"
                  default: "on"
                  type: string
                tls_fingerprint:
                  enum:
                    - "on"
                    - "off"
                  default: "on"
                  type: string
      served: true
      storage: true
    YAML
}

resource "kubectl_manifest" "com_apdoslogconfs" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.0
  creationTimestamp: null
  name: apdoslogconfs.appprotectdos.f5.com
spec:
  group: appprotectdos.f5.com
  names:
    kind: APDosLogConf
    listKind: APDosLogConfList
    plural: apdoslogconfs
    singular: apdoslogconf
  preserveUnknownFields: false
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          description: APDosLogConf is the Schema for the APDosLogConfs API
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: APDosLogConfSpec defines the desired state of APDosLogConf
              properties:
                content:
                  properties:
                    format:
                      enum:
                        - splunk
                        - arcsight
                        - user-defined
                      default: splunk
                      type: string
                    format_string:
                      type: string
                    max_message_size:
                      pattern: ^([1-9]|[1-5][0-9]|6[0-4])k$
                      default: 5k
                      type: string
                  type: object
                filter:
                  properties:
                    traffic-mitigation-stats:
                      enum:
                        - none
                        - all
                      default: all
                      type: string
                    bad-actors:
                      pattern: ^(none|all|top ([1-9]|[1-9][0-9]|[1-9][0-9]{2,4}|100000))$
                      default: top 10
                      type: string
                    attack-signatures:
                      pattern: ^(none|all|top ([1-9]|[1-9][0-9]|[1-9][0-9]{2,4}|100000))$
                      default: top 10
                      type: string
                  type: object
              type: object
          type: object
      served: true
      storage: true    
    YAML
}

resource "kubectl_manifest" "com_apusersigs" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.0
  creationTimestamp: null
  name: apusersigs.appprotect.f5.com
spec:
  group: appprotect.f5.com
  names:
    kind: APUserSig
    listKind: APUserSigList
    plural: apusersigs
    singular: apusersig
  preserveUnknownFields: false
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          description: APUserSig is the Schema for the apusersigs API
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: APUserSigSpec defines the desired state of APUserSig
              properties:
                properties:
                  type: string
                signatures:
                  items:
                    properties:
                      accuracy:
                        enum:
                          - high
                          - medium
                          - low
                        type: string
                      attackType:
                        properties:
                          name:
                            type: string
                        type: object
                      description:
                        type: string
                      name:
                        type: string
                      references:
                        properties:
                          type:
                            enum:
                              - bugtraq
                              - cve
                              - nessus
                              - url
                            type: string
                          value:
                            type: string
                        type: object
                      risk:
                        enum:
                          - high
                          - medium
                          - low
                        type: string
                      rule:
                        type: string
                      signatureType:
                        enum:
                          - request
                          - response
                        type: string
                      systems:
                        items:
                          properties:
                            name:
                              type: string
                          type: object
                        type: array
                    type: object
                  type: array
                tag:
                  type: string
              type: object
          type: object
      served: true
      storage: true
    YAML
}

resource "kubectl_manifest" "com_appolicies" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.0
  creationTimestamp: null
  name: appolicies.appprotect.f5.com
spec:
  group: appprotect.f5.com
  names:
    kind: APPolicy
    listKind: APPolicyList
    plural: appolicies
    singular: appolicy
  preserveUnknownFields: false
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          description: APPolicyConfig is the Schema for the APPolicyconfigs API
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: APPolicySpec defines the desired state of APPolicy
              properties:
                modifications:
                  items:
                    properties:
                      action:
                        type: string
                      description:
                        type: string
                      entity:
                        properties:
                          name:
                            type: string
                        type: object
                      entityChanges:
                        properties:
                          type:
                            type: string
                        type: object
                    type: object
                    x-kubernetes-preserve-unknown-fields: true
                  type: array
                modificationsReference:
                  properties:
                    link:
                      pattern: ^http
                      type: string
                  type: object
                policy:
                  description: Defines the App Protect policy
                  properties:
                    applicationLanguage:
                      enum:
                        - iso-8859-10
                        - iso-8859-6
                        - windows-1255
                        - auto-detect
                        - koi8-r
                        - gb18030
                        - iso-8859-8
                        - windows-1250
                        - iso-8859-9
                        - windows-1252
                        - iso-8859-16
                        - gb2312
                        - iso-8859-2
                        - iso-8859-5
                        - windows-1257
                        - windows-1256
                        - iso-8859-13
                        - windows-874
                        - windows-1253
                        - iso-8859-3
                        - euc-jp
                        - utf-8
                        - gbk
                        - windows-1251
                        - big5
                        - iso-8859-1
                        - shift_jis
                        - euc-kr
                        - iso-8859-4
                        - iso-8859-7
                        - iso-8859-15
                      type: string
                    blocking-settings:
                      properties:
                        evasions:
                          items:
                            properties:
                              description:
                                enum:
                                  - '%u decoding'
                                  - Apache whitespace
                                  - Bad unescape
                                  - Bare byte decoding
                                  - Directory traversals
                                  - IIS backslashes
                                  - IIS Unicode codepoints
                                  - Multiple decoding
                                type: string
                              enabled:
                                type: boolean
                              maxDecodingPasses:
                                type: integer
                            type: object
                          type: array
                        http-protocols:
                          items:
                            properties:
                              description:
                                enum:
                                  - Unescaped space in URL
                                  - Unparsable request content
                                  - Several Content-Length headers
                                  - 'POST request with Content-Length: 0'
                                  - Null in request
                                  - No Host header in HTTP/1.1 request
                                  - Multiple host headers
                                  - Host header contains IP address
                                  - High ASCII characters in headers
                                  - Header name with no header value
                                  - CRLF characters before request start
                                  - Content length should be a positive number
                                  - Chunked request with Content-Length header
                                  - Check maximum number of parameters
                                  - Check maximum number of headers
                                  - Body in GET or HEAD requests
                                  - Bad multipart/form-data request parsing
                                  - Bad multipart parameters parsing
                                  - Bad HTTP version
                                  - Bad host header value
                                type: string
                              enabled:
                                type: boolean
                              maxHeaders:
                                type: integer
                              maxParams:
                                type: integer
                            type: object
                          type: array
                        violations:
                          items:
                            properties:
                              alarm:
                                type: boolean
                              block:
                                type: boolean
                              description:
                                type: string
                              name:
                                enum:
                                  - VIOL_GRPC_FORMAT
                                  - VIOL_GRPC_MALFORMED
                                  - VIOL_GRPC_METHOD
                                  - VIOL_PARAMETER_ARRAY_VALUE
                                  - VIOL_PARAMETER_VALUE_REGEXP
                                  - VIOL_CSRF
                                  - VIOL_PARAMETER_VALUE_BASE64
                                  - VIOL_MANDATORY_HEADER
                                  - VIOL_HEADER_REPEATED
                                  - VIOL_ASM_COOKIE_MODIFIED
                                  - VIOL_BLACKLISTED_IP
                                  - VIOL_COOKIE_EXPIRED
                                  - VIOL_COOKIE_LENGTH
                                  - VIOL_COOKIE_MALFORMED
                                  - VIOL_COOKIE_MODIFIED
                                  - VIOL_DATA_GUARD
                                  - VIOL_ENCODING
                                  - VIOL_EVASION
                                  - VIOL_FILETYPE
                                  - VIOL_FILE_UPLOAD
                                  - VIOL_FILE_UPLOAD_IN_BODY
                                  - VIOL_HEADER_LENGTH
                                  - VIOL_HEADER_METACHAR
                                  - VIOL_HTTP_PROTOCOL
                                  - VIOL_HTTP_RESPONSE_STATUS
                                  - VIOL_JSON_FORMAT
                                  - VIOL_JSON_MALFORMED
                                  - VIOL_JSON_SCHEMA
                                  - VIOL_MANDATORY_PARAMETER
                                  - VIOL_MANDATORY_REQUEST_BODY
                                  - VIOL_METHOD
                                  - VIOL_PARAMETER
                                  - VIOL_PARAMETER_DATA_TYPE
                                  - VIOL_PARAMETER_EMPTY_VALUE
                                  - VIOL_PARAMETER_LOCATION
                                  - VIOL_PARAMETER_MULTIPART_NULL_VALUE
                                  - VIOL_PARAMETER_NAME_METACHAR
                                  - VIOL_PARAMETER_NUMERIC_VALUE
                                  - VIOL_PARAMETER_REPEATED
                                  - VIOL_PARAMETER_STATIC_VALUE
                                  - VIOL_PARAMETER_VALUE_LENGTH
                                  - VIOL_PARAMETER_VALUE_METACHAR
                                  - VIOL_POST_DATA_LENGTH
                                  - VIOL_QUERY_STRING_LENGTH
                                  - VIOL_RATING_THREAT
                                  - VIOL_RATING_NEED_EXAMINATION
                                  - VIOL_REQUEST_MAX_LENGTH
                                  - VIOL_REQUEST_LENGTH
                                  - VIOL_THREAT_CAMPAIGN
                                  - VIOL_URL
                                  - VIOL_URL_CONTENT_TYPE
                                  - VIOL_URL_LENGTH
                                  - VIOL_URL_METACHAR
                                  - VIOL_XML_FORMAT
                                  - VIOL_XML_MALFORMED
                                type: string
                            type: object
                          type: array
                      type: object
                    blockingSettingReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    bot-defense:
                      properties:
                        mitigations:
                          properties:
                            anomalies:
                              items:
                                properties:
                                  $action:
                                    enum:
                                      - delete
                                    type: string
                                  action:
                                    enum:
                                      - alarm
                                      - block
                                      - default
                                      - detect
                                      - ignore
                                    type: string
                                  name:
                                    type: string
                                  scoreThreshold:
                                    pattern: '[0-9]|[1-9][0-9]|1[0-4][0-9]|150|default'
                                    type: string
                                type: object
                              type: array
                            browsers:
                              items:
                                properties:
                                  $action:
                                    enum:
                                      - delete
                                    type: string
                                  action:
                                    enum:
                                      - alarm
                                      - block
                                      - detect
                                    type: string
                                  browserDefinition:
                                    properties:
                                      $action:
                                        enum:
                                          - delete
                                        type: string
                                      isUserDefined:
                                        type: boolean
                                      matchRegex:
                                        type: string
                                      matchString:
                                        type: string
                                      name:
                                        type: string
                                    type: object
                                  maxVersion:
                                    maximum: 2147483647
                                    minimum: 0
                                    type: integer
                                  minVersion:
                                    maximum: 2147483647
                                    minimum: 0
                                    type: integer
                                  name:
                                    type: string
                                type: object
                              type: array
                            classes:
                              items:
                                properties:
                                  action:
                                    enum:
                                      - alarm
                                      - block
                                      - detect
                                      - ignore
                                    type: string
                                  name:
                                    enum:
                                      - browser
                                      - malicious-bot
                                      - suspicious-browser
                                      - trusted-bot
                                      - unknown
                                      - untrusted-bot
                                    type: string
                                type: object
                              type: array
                            signatures:
                              items:
                                properties:
                                  $action:
                                    enum:
                                      - delete
                                    type: string
                                  action:
                                    enum:
                                      - alarm
                                      - block
                                      - detect
                                      - ignore
                                    type: string
                                  name:
                                    type: string
                                type: object
                              type: array
                          type: object
                        settings:
                          properties:
                            isEnabled:
                              type: boolean
                          type: object
                      type: object
                    browser-definitions:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          isUserDefined:
                            type: boolean
                          matchRegex:
                            type: string
                          matchString:
                            type: string
                          name:
                            type: string
                        type: object
                      type: array
                    caseInsensitive:
                      type: boolean
                    character-sets:
                      items:
                        properties:
                          characterSet:
                            items:
                              properties:
                                isAllowed:
                                  type: boolean
                                metachar:
                                  type: string
                              type: object
                            type: array
                          characterSetType:
                            enum:
                              - gwt-content
                              - header
                              - json-content
                              - parameter-name
                              - parameter-value
                              - plain-text-content
                              - url
                              - xml-content
                            type: string
                        type: object
                      type: array
                    characterSetReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    cookie-settings:
                      properties:
                        maximumCookieHeaderLength:
                          pattern: any|\d+
                          type: string
                      type: object
                    cookieReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    cookieSettingsReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    cookies:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          accessibleOnlyThroughTheHttpProtocol:
                            type: boolean
                          attackSignaturesCheck:
                            type: boolean
                          decodeValueAsBase64:
                            enum:
                              - enabled
                              - disabled
                              - required
                            type: string
                          enforcementType:
                            type: string
                          insertSameSiteAttribute:
                            enum:
                              - lax
                              - none
                              - none-value
                              - strict
                            type: string
                          name:
                            type: string
                          securedOverHttpsConnection:
                            type: boolean
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                          type:
                            enum:
                              - explicit
                              - wildcard
                            type: string
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    csrf-protection:
                      properties:
                        enabled:
                          type: boolean
                        expirationTimeInSeconds:
                          pattern: disabled|\d+
                          type: string
                        sslOnly:
                          type: boolean
                      type: object
                    csrf-urls:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          enforcementAction:
                            enum:
                              - verify-origin
                              - none
                            type: string
                          method:
                            enum:
                              - GET
                              - POST
                              - any
                            type: string
                          url:
                            type: string
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    data-guard:
                      properties:
                        creditCardNumbers:
                          type: boolean
                        enabled:
                          type: boolean
                        enforcementMode:
                          enum:
                            - ignore-urls-in-list
                            - enforce-urls-in-list
                          type: string
                        enforcementUrls:
                          items:
                            type: string
                          type: array
                        lastCcnDigitsToExpose:
                          type: integer
                        lastSsnDigitsToExpose:
                          type: integer
                        maskData:
                          type: boolean
                        usSocialSecurityNumbers:
                          type: boolean
                      type: object
                    dataGuardReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    description:
                      type: string
                    enablePassiveMode:
                      type: boolean
                    enforcementMode:
                      enum:
                        - transparent
                        - blocking
                      type: string
                    enforcer-settings:
                      properties:
                        enforcerStateCookies:
                          properties:
                            httpOnlyAttribute:
                              type: boolean
                            sameSiteAttribute:
                              enum:
                                - lax
                                - none
                                - none-value
                                - strict
                              type: string
                            secureAttribute:
                              enum:
                                - always
                                - never
                              type: string
                          type: object
                      type: object
                    filetypeReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    filetypes:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          allowed:
                            type: boolean
                          checkPostDataLength:
                            type: boolean
                          checkQueryStringLength:
                            type: boolean
                          checkRequestLength:
                            type: boolean
                          checkUrlLength:
                            type: boolean
                          name:
                            type: string
                          postDataLength:
                            type: integer
                          queryStringLength:
                            type: integer
                          requestLength:
                            type: integer
                          responseCheck:
                            type: boolean
                          type:
                            enum:
                              - explicit
                              - wildcard
                            type: string
                          urlLength:
                            type: integer
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    fullPath:
                      type: string
                    general:
                      properties:
                        allowedResponseCodes:
                          items:
                            format: int32
                            maximum: 999
                            minimum: 100
                            type: integer
                          type: array
                        customXffHeaders:
                          items:
                            type: string
                          type: array
                        maskCreditCardNumbersInRequest:
                          type: boolean
                        trustXff:
                          type: boolean
                      type: object
                    generalReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    grpc-profiles:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          associateUrls:
                            type: boolean
                          attackSignaturesCheck:
                            type: boolean
                          defenseAttributes:
                            properties:
                              allowUnknownFields:
                                type: boolean
                              maximumDataLength:
                                pattern: any|\d+
                                type: string
                            type: object
                          description:
                            type: string
                          hasIdlFiles:
                            type: boolean
                          idlFiles:
                            items:
                              properties:
                                idlFile:
                                  properties:
                                    contents:
                                      type: string
                                    fileName:
                                      type: string
                                    isBase64:
                                      type: boolean
                                  type: object
                                importUrl:
                                  type: string
                                isPrimary:
                                  type: boolean
                                primaryIdlFileName:
                                  type: string
                              type: object
                            type: array
                          metacharElementCheck:
                            type: boolean
                          name:
                            type: string
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                        type: object
                      type: array
                    header-settings:
                      properties:
                        maximumHttpHeaderLength:
                          pattern: any|\d+
                          type: string
                      type: object
                    headerReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    headerSettingsReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    headers:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          allowRepeatedOccurrences:
                            type: boolean
                          base64Decoding:
                            type: boolean
                          checkSignatures:
                            type: boolean
                          decodeValueAsBase64:
                            enum:
                              - enabled
                              - disabled
                              - required
                            type: string
                          htmlNormalization:
                            type: boolean
                          mandatory:
                            type: boolean
                          maskValueInLogs:
                            type: boolean
                          name:
                            type: string
                          normalizationViolations:
                            type: boolean
                          percentDecoding:
                            type: boolean
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                          type:
                            enum:
                              - explicit
                              - wildcard
                            type: string
                          urlNormalization:
                            type: boolean
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    host-names:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          includeSubdomains:
                            type: boolean
                          name:
                            type: string
                        type: object
                      type: array
                    idl-files:
                      items:
                        properties:
                          contents:
                            type: string
                          fileName:
                            type: string
                          isBase64:
                            type: boolean
                        type: object
                      type: array
                    json-profiles:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          attackSignaturesCheck:
                            type: boolean
                          defenseAttributes:
                            properties:
                              maximumArrayLength:
                                pattern: any|\d+
                                type: string
                              maximumStructureDepth:
                                pattern: any|\d+
                                type: string
                              maximumTotalLengthOfJSONData:
                                pattern: any|\d+
                                type: string
                              maximumValueLength:
                                pattern: any|\d+
                                type: string
                              tolerateJSONParsingWarnings:
                                type: boolean
                            type: object
                          description:
                            type: string
                          handleJsonValuesAsParameters:
                            type: boolean
                          hasValidationFiles:
                            type: boolean
                          metacharOverrides:
                            items:
                              properties:
                                isAllowed:
                                  type: boolean
                                metachar:
                                  type: string
                              type: object
                            type: array
                          name:
                            type: string
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                          validationFiles:
                            items:
                              properties:
                                importUrl:
                                  type: string
                                isPrimary:
                                  type: boolean
                                jsonValidationFile:
                                  properties:
                                    $action:
                                      enum:
                                        - delete
                                      type: string
                                    contents:
                                      type: string
                                    fileName:
                                      type: string
                                    isBase64:
                                      type: boolean
                                  type: object
                              type: object
                            type: array
                        type: object
                      type: array
                    json-validation-files:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          contents:
                            type: string
                          fileName:
                            type: string
                          isBase64:
                            type: boolean
                        type: object
                      type: array
                    jsonProfileReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    jsonValidationFileReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    methodReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    methods:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          name:
                            type: string
                        type: object
                      type: array
                    name:
                      type: string
                    open-api-files:
                      items:
                        properties:
                          link:
                            pattern: ^http
                            type: string
                        type: object
                      type: array
                    parameterReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    parameters:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          allowEmptyValue:
                            type: boolean
                          allowRepeatedParameterName:
                            type: boolean
                          arraySerializationFormat:
                            enum:
                              - csv
                              - form
                              - label
                              - matrix
                              - multi
                              - multipart
                              - pipe
                              - ssv
                              - tsv
                            type: string
                          attackSignaturesCheck:
                            type: boolean
                          checkMaxValue:
                            type: boolean
                          checkMaxValueLength:
                            type: boolean
                          checkMetachars:
                            type: boolean
                          checkMinValue:
                            type: boolean
                          checkMinValueLength:
                            type: boolean
                          checkMultipleOfValue:
                            type: boolean
                          contentProfile:
                            properties:
                              name:
                                type: string
                            type: object
                          dataType:
                            enum:
                              - alpha-numeric
                              - binary
                              - boolean
                              - decimal
                              - email
                              - integer
                              - none
                              - phone
                            type: string
                          decodeValueAsBase64:
                            enum:
                              - enabled
                              - disabled
                              - required
                            type: string
                          disallowFileUploadOfExecutables:
                            type: boolean
                          enableRegularExpression:
                            type: boolean
                          exclusiveMax:
                            type: boolean
                          exclusiveMin:
                            type: boolean
                          isBase64:
                            type: boolean
                          isCookie:
                            type: boolean
                          isHeader:
                            type: boolean
                          level:
                            enum:
                              - global
                              - url
                            type: string
                          mandatory:
                            type: boolean
                          maximumLength:
                            type: integer
                          maximumValue:
                            type: integer
                          metacharsOnParameterValueCheck:
                            type: boolean
                          minimumLength:
                            type: integer
                          minimumValue:
                            type: integer
                          multipleOf:
                            type: integer
                          name:
                            type: string
                          nameMetacharOverrides:
                            items:
                              properties:
                                isAllowed:
                                  type: boolean
                                metachar:
                                  type: string
                              type: object
                            type: array
                          objectSerializationStyle:
                            type: string
                          parameterEnumValues:
                            items:
                              type: string
                            type: array
                          parameterLocation:
                            enum:
                              - any
                              - cookie
                              - form-data
                              - header
                              - path
                              - query
                            type: string
                          regularExpression:
                            type: string
                          sensitiveParameter:
                            type: boolean
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                          staticValues:
                            type: string
                          type:
                            enum:
                              - explicit
                              - wildcard
                            type: string
                          url:
                            type: object
                          valueMetacharOverrides:
                            items:
                              properties:
                                isAllowed:
                                  type: boolean
                                metachar:
                                  type: string
                              type: object
                            type: array
                          valueType:
                            enum:
                              - array
                              - auto-detect
                              - dynamic-content
                              - dynamic-parameter-name
                              - ignore
                              - json
                              - object
                              - openapi-array
                              - static-content
                              - user-input
                              - xml
                            type: string
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    response-pages:
                      items:
                        properties:
                          ajaxActionType:
                            enum:
                              - alert-popup
                              - custom
                              - redirect
                            type: string
                          ajaxCustomContent:
                            type: string
                          ajaxEnabled:
                            type: boolean
                          ajaxPopupMessage:
                            type: string
                          ajaxRedirectUrl:
                            type: string
                          grpcStatusCode:
                            pattern: ABORTED|ALREADY_EXISTS|CANCELLED|DATA_LOSS|DEADLINE_EXCEEDED|FAILED_PRECONDITION|INTERNAL|INVALID_ARGUMENT|NOT_FOUND|OK|OUT_OF_RANGE|PERMISSION_DENIED|RESOURCE_EXHAUSTED|UNAUTHENTICATED|UNAVAILABLE|UNIMPLEMENTED|UNKNOWN|d+
                            type: string
                          grpcStatusMessage:
                            type: string
                          responseActionType:
                            enum:
                              - custom
                              - default
                              - erase-cookies
                              - redirect
                              - soap-fault
                            type: string
                          responseContent:
                            type: string
                          responseHeader:
                            type: string
                          responsePageType:
                            enum:
                              - ajax
                              - ajax-login
                              - captcha
                              - captcha-fail
                              - default
                              - failed-login-honeypot
                              - failed-login-honeypot-ajax
                              - hijack
                              - leaked-credentials
                              - leaked-credentials-ajax
                              - mobile
                              - persistent-flow
                              - xml
                              - grpc
                            type: string
                          responseRedirectUrl:
                            type: string
                        type: object
                      type: array
                    responsePageReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    sensitive-parameters:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          name:
                            type: string
                        type: object
                      type: array
                    sensitiveParameterReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    server-technologies:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          serverTechnologyName:
                            enum:
                              - Jenkins
                              - SharePoint
                              - Oracle Application Server
                              - Python
                              - Oracle Identity Manager
                              - Spring Boot
                              - CouchDB
                              - SQLite
                              - Handlebars
                              - Mustache
                              - Prototype
                              - Zend
                              - Redis
                              - Underscore.js
                              - Ember.js
                              - ZURB Foundation
                              - ef.js
                              - Vue.js
                              - UIKit
                              - TYPO3 CMS
                              - RequireJS
                              - React
                              - MooTools
                              - Laravel
                              - GraphQL
                              - Google Web Toolkit
                              - Express.js
                              - CodeIgniter
                              - Backbone.js
                              - AngularJS
                              - JavaScript
                              - Nginx
                              - Jetty
                              - Joomla
                              - JavaServer Faces (JSF)
                              - Ruby
                              - MongoDB
                              - Django
                              - Node.js
                              - Citrix
                              - JBoss
                              - Elasticsearch
                              - Apache Struts
                              - XML
                              - PostgreSQL
                              - IBM DB2
                              - Sybase/ASE
                              - CGI
                              - Proxy Servers
                              - SSI (Server Side Includes)
                              - Cisco
                              - Novell
                              - Macromedia JRun
                              - BEA Systems WebLogic Server
                              - Lotus Domino
                              - MySQL
                              - Oracle
                              - Microsoft SQL Server
                              - PHP
                              - Outlook Web Access
                              - Apache/NCSA HTTP Server
                              - Apache Tomcat
                              - WordPress
                              - Macromedia ColdFusion
                              - Unix/Linux
                              - Microsoft Windows
                              - ASP.NET
                              - Front Page Server Extensions (FPSE)
                              - IIS
                              - WebDAV
                              - ASP
                              - Java Servlets/JSP
                              - jQuery
                            type: string
                        type: object
                      type: array
                    serverTechnologyReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    signature-requirements:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          tag:
                            type: string
                        type: object
                      type: array
                    signature-sets:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          alarm:
                            type: boolean
                          block:
                            type: boolean
                          name:
                            type: string
                        type: object
                        x-kubernetes-preserve-unknown-fields: true
                      type: array
                    signature-settings:
                      properties:
                        attackSignatureFalsePositiveMode:
                          enum:
                            - detect
                            - detect-and-allow
                            - disabled
                          type: string
                        minimumAccuracyForAutoAddedSignatures:
                          enum:
                            - high
                            - low
                            - medium
                          type: string
                      type: object
                    signatureReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    signatureSetReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    signatureSettingReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    signatures:
                      items:
                        properties:
                          enabled:
                            type: boolean
                          name:
                            type: string
                          signatureId:
                            type: integer
                          tag:
                            type: string
                        type: object
                      type: array
                    softwareVersion:
                      type: string
                    template:
                      properties:
                        name:
                          type: string
                      type: object
                    threat-campaigns:
                      items:
                        properties:
                          isEnabled:
                            type: boolean
                          name:
                            type: string
                        type: object
                      type: array
                    threatCampaignReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    urlReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    urls:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          allowRenderingInFrames:
                            enum:
                              - never
                              - only-same
                            type: string
                          allowRenderingInFramesOnlyFrom:
                            type: string
                          attackSignaturesCheck:
                            type: boolean
                          clickjackingProtection:
                            type: boolean
                          description:
                            type: string
                          disallowFileUploadOfExecutables:
                            type: boolean
                          html5CrossOriginRequestsEnforcement:
                            properties:
                              allowOriginsEnforcementMode:
                                enum:
                                  - replace-with
                                  - unmodified
                                type: string
                              checkAllowedMethods:
                                type: boolean
                              crossDomainAllowedOrigin:
                                items:
                                  properties:
                                    includeSubDomains:
                                      type: boolean
                                    originName:
                                      type: string
                                    originPort:
                                      pattern: any|\d+
                                      type: string
                                    originProtocol:
                                      enum:
                                        - http
                                        - http/https
                                        - https
                                      type: string
                                  type: object
                                type: array
                              enforcementMode:
                                enum:
                                  - disabled
                                  - enforce
                                type: string
                            type: object
                          isAllowed:
                            type: boolean
                          mandatoryBody:
                            type: boolean
                          metacharOverrides:
                            items:
                              properties:
                                isAllowed:
                                  type: boolean
                                metachar:
                                  type: string
                              type: object
                            type: array
                          metacharsOnUrlCheck:
                            type: boolean
                          method:
                            enum:
                              - ACL
                              - BCOPY
                              - BDELETE
                              - BMOVE
                              - BPROPFIND
                              - BPROPPATCH
                              - CHECKIN
                              - CHECKOUT
                              - CONNECT
                              - COPY
                              - DELETE
                              - GET
                              - HEAD
                              - LINK
                              - LOCK
                              - MERGE
                              - MKCOL
                              - MKWORKSPACE
                              - MOVE
                              - NOTIFY
                              - OPTIONS
                              - PATCH
                              - POLL
                              - POST
                              - PROPFIND
                              - PROPPATCH
                              - PUT
                              - REPORT
                              - RPC_IN_DATA
                              - RPC_OUT_DATA
                              - SEARCH
                              - SUBSCRIBE
                              - TRACE
                              - TRACK
                              - UNLINK
                              - UNLOCK
                              - UNSUBSCRIBE
                              - VERSION_CONTROL
                              - X-MS-ENUMATTS
                              - '*'
                            type: string
                          methodOverrides:
                            items:
                              properties:
                                allowed:
                                  type: boolean
                                method:
                                  enum:
                                    - ACL
                                    - BCOPY
                                    - BDELETE
                                    - BMOVE
                                    - BPROPFIND
                                    - BPROPPATCH
                                    - CHECKIN
                                    - CHECKOUT
                                    - CONNECT
                                    - COPY
                                    - DELETE
                                    - GET
                                    - HEAD
                                    - LINK
                                    - LOCK
                                    - MERGE
                                    - MKCOL
                                    - MKWORKSPACE
                                    - MOVE
                                    - NOTIFY
                                    - OPTIONS
                                    - PATCH
                                    - POLL
                                    - POST
                                    - PROPFIND
                                    - PROPPATCH
                                    - PUT
                                    - REPORT
                                    - RPC_IN_DATA
                                    - RPC_OUT_DATA
                                    - SEARCH
                                    - SUBSCRIBE
                                    - TRACE
                                    - TRACK
                                    - UNLINK
                                    - UNLOCK
                                    - UNSUBSCRIBE
                                    - VERSION_CONTROL
                                    - X-MS-ENUMATTS
                                  type: string
                              type: object
                            type: array
                          methodsOverrideOnUrlCheck:
                            type: boolean
                          name:
                            type: string
                          operationId:
                            type: string
                          positionalParameters:
                            items:
                              properties:
                                parameter:
                                  properties:
                                    $action:
                                      enum:
                                        - delete
                                      type: string
                                    allowEmptyValue:
                                      type: boolean
                                    allowRepeatedParameterName:
                                      type: boolean
                                    arraySerializationFormat:
                                      enum:
                                        - csv
                                        - form
                                        - label
                                        - matrix
                                        - multi
                                        - multipart
                                        - pipe
                                        - ssv
                                        - tsv
                                      type: string
                                    attackSignaturesCheck:
                                      type: boolean
                                    checkMaxValue:
                                      type: boolean
                                    checkMaxValueLength:
                                      type: boolean
                                    checkMetachars:
                                      type: boolean
                                    checkMinValue:
                                      type: boolean
                                    checkMinValueLength:
                                      type: boolean
                                    checkMultipleOfValue:
                                      type: boolean
                                    contentProfile:
                                      properties:
                                        name:
                                          type: string
                                      type: object
                                    dataType:
                                      enum:
                                        - alpha-numeric
                                        - binary
                                        - boolean
                                        - decimal
                                        - email
                                        - integer
                                        - none
                                        - phone
                                      type: string
                                    decodeValueAsBase64:
                                      enum:
                                        - enabled
                                        - disabled
                                        - required
                                      type: string
                                    disallowFileUploadOfExecutables:
                                      type: boolean
                                    enableRegularExpression:
                                      type: boolean
                                    exclusiveMax:
                                      type: boolean
                                    exclusiveMin:
                                      type: boolean
                                    isBase64:
                                      type: boolean
                                    isCookie:
                                      type: boolean
                                    isHeader:
                                      type: boolean
                                    level:
                                      enum:
                                        - global
                                        - url
                                      type: string
                                    mandatory:
                                      type: boolean
                                    maximumLength:
                                      type: integer
                                    maximumValue:
                                      type: integer
                                    metacharsOnParameterValueCheck:
                                      type: boolean
                                    minimumLength:
                                      type: integer
                                    minimumValue:
                                      type: integer
                                    multipleOf:
                                      type: integer
                                    name:
                                      type: string
                                    nameMetacharOverrides:
                                      items:
                                        properties:
                                          isAllowed:
                                            type: boolean
                                          metachar:
                                            type: string
                                        type: object
                                      type: array
                                    objectSerializationStyle:
                                      type: string
                                    parameterEnumValues:
                                      items:
                                        type: string
                                      type: array
                                    parameterLocation:
                                      enum:
                                        - any
                                        - cookie
                                        - form-data
                                        - header
                                        - path
                                        - query
                                      type: string
                                    regularExpression:
                                      type: string
                                    sensitiveParameter:
                                      type: boolean
                                    signatureOverrides:
                                      items:
                                        properties:
                                          enabled:
                                            type: boolean
                                          name:
                                            type: string
                                          signatureId:
                                            type: integer
                                          tag:
                                            type: string
                                        type: object
                                      type: array
                                    staticValues:
                                      type: string
                                    type:
                                      enum:
                                        - explicit
                                        - wildcard
                                      type: string
                                    url:
                                      type: object
                                    valueMetacharOverrides:
                                      items:
                                        properties:
                                          isAllowed:
                                            type: boolean
                                          metachar:
                                            type: string
                                        type: object
                                      type: array
                                    valueType:
                                      enum:
                                        - array
                                        - auto-detect
                                        - dynamic-content
                                        - dynamic-parameter-name
                                        - ignore
                                        - json
                                        - object
                                        - openapi-array
                                        - static-content
                                        - user-input
                                        - xml
                                      type: string
                                    wildcardOrder:
                                      type: integer
                                  type: object
                                urlSegmentIndex:
                                  type: integer
                              type: object
                            type: array
                          protocol:
                            enum:
                              - http
                              - https
                            type: string
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                          type:
                            enum:
                              - explicit
                              - wildcard
                            type: string
                          urlContentProfiles:
                            items:
                              properties:
                                contentProfile:
                                  properties:
                                    name:
                                      type: string
                                  type: object
                                headerName:
                                  type: string
                                headerOrder:
                                  type: string
                                headerValue:
                                  type: string
                                name:
                                  type: string
                                type:
                                  enum:
                                    - apply-content-signatures
                                    - apply-value-and-content-signatures
                                    - disallow
                                    - do-nothing
                                    - form-data
                                    - gwt
                                    - json
                                    - xml
                                    - grpc
                                  type: string
                              type: object
                            type: array
                          wildcardOrder:
                            type: integer
                        type: object
                      type: array
                    whitelist-ips:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          blockRequests:
                            enum:
                              - always
                              - never
                              - policy-default
                            type: string
                          ipAddress:
                            pattern: '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
                            type: string
                          ipMask:
                            pattern: '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
                            type: string
                          neverLogRequests:
                            type: boolean
                        type: object
                      type: array
                    whitelistIpReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    xml-profiles:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          attackSignaturesCheck:
                            type: boolean
                          defenseAttributes:
                            properties:
                              allowCDATA:
                                type: boolean
                              allowDTDs:
                                type: boolean
                              allowExternalReferences:
                                type: boolean
                              allowProcessingInstructions:
                                type: boolean
                              maximumAttributeValueLength:
                                pattern: any|\d+
                                type: string
                              maximumAttributesPerElement:
                                pattern: any|\d+
                                type: string
                              maximumChildrenPerElement:
                                pattern: any|\d+
                                type: string
                              maximumDocumentDepth:
                                pattern: any|\d+
                                type: string
                              maximumDocumentSize:
                                pattern: any|\d+
                                type: string
                              maximumElements:
                                pattern: any|\d+
                                type: string
                              maximumNSDeclarations:
                                pattern: any|\d+
                                type: string
                              maximumNameLength:
                                pattern: any|\d+
                                type: string
                              maximumNamespaceLength:
                                pattern: any|\d+
                                type: string
                              tolerateCloseTagShorthand:
                                type: boolean
                              tolerateLeadingWhiteSpace:
                                type: boolean
                              tolerateNumericNames:
                                type: boolean
                            type: object
                          description:
                            type: string
                          enableWss:
                            type: boolean
                          followSchemaLinks:
                            type: boolean
                          name:
                            type: string
                          signatureOverrides:
                            items:
                              properties:
                                enabled:
                                  type: boolean
                                name:
                                  type: string
                                signatureId:
                                  type: integer
                                tag:
                                  type: string
                              type: object
                            type: array
                        type: object
                      type: array
                    xml-validation-files:
                      items:
                        properties:
                          $action:
                            enum:
                              - delete
                            type: string
                          contents:
                            type: string
                          fileName:
                            type: string
                          isBase64:
                            type: boolean
                        type: object
                      type: array
                    xmlProfileReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                    xmlValidationFileReference:
                      properties:
                        link:
                          pattern: ^http
                          type: string
                      type: object
                  type: object
              type: object
          type: object
      served: true
      storage: true
    YAML
}

resource "kubectl_manifest" "com_aplogconfs" {
    yaml_body = <<YAML
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.4.0
  creationTimestamp: null
  name: aplogconfs.appprotect.f5.com
spec:
  group: appprotect.f5.com
  names:
    kind: APLogConf
    listKind: APLogConfList
    plural: aplogconfs
    singular: aplogconf
  preserveUnknownFields: false
  scope: Namespaced
  versions:
    - name: v1beta1
      schema:
        openAPIV3Schema:
          description: APLogConf is the Schema for the APLogConfs API
          properties:
            apiVersion:
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
              type: string
            kind:
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
              type: string
            metadata:
              type: object
            spec:
              description: APLogConfSpec defines the desired state of APLogConf
              properties:
                content:
                  properties:
                    escaping_characters:
                      items:
                        properties:
                          from:
                            type: string
                          to:
                            type: string
                        type: object
                      type: array
                    format:
                      enum:
                        - splunk
                        - arcsight
                        - default
                        - user-defined
                        - grpc
                      type: string
                    format_string:
                      type: string
                    list_delimiter:
                      type: string
                    list_prefix:
                      type: string
                    list_suffix:
                      type: string
                    max_message_size:
                      pattern: ^([1-9]|[1-5][0-9]|6[0-4])k$
                      type: string
                    max_request_size:
                      pattern: ^([1-9]|[1-9][0-9]|[1-9][0-9]{2}|1[0-9]{3}|20[1-3][0-9]|204[1-8]|any)$
                      type: string
                  type: object
                filter:
                  properties:
                    request_type:
                      enum:
                        - all
                        - illegal
                        - blocked
                      type: string
                  type: object
              type: object
          type: object
      served: true
      storage: true
    YAML
}