provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
    labels = {
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/name"     = "ingress-nginx"
    }
  }
}

resource "kubernetes_service_account" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
  }
}

resource "kubernetes_service_account" "ingress_nginx_admission" {
  metadata {
    name      = "ingress-nginx-admission"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
  }
}

resource "kubernetes_role" "ingress_nginx" {
  metadata {
    name      = "ingress-nginx"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get"]
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "pods", "secrets", "endpoints"]
    verbs      = ["get", "list", "watch"]
  }

  # Adicione outras regras aqui conforme necessário
}

resource "kubernetes_role" "ingress_nginx_admission" {
  metadata {
    name      = "ingress-nginx-admission"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "create"]
  }
}

resource "kubernetes_cluster_role" "ingress_nginx" {
  metadata {
    labels = {
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/name"     = "ingress-nginx"
      "app.kubernetes.io/part-of"  = "ingress-nginx"
      "app.kubernetes.io/version"  = "1.10.1"
    }
    name = "ingress-nginx"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "endpoints", "nodes", "pods", "secrets", "namespaces"]
    verbs      = ["list", "watch"]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["list", "watch"]
  }

  # Adicione outras regras aqui conforme necessário
}

resource "kubernetes_cluster_role" "ingress_nginx_admission" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
    name = "ingress-nginx-admission"
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources  = ["validatingwebhookconfigurations"]
    verbs      = ["get", "update"]
  }
}

resource "kubernetes_role_binding" "ingress_nginx" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
    name      = "ingress-nginx"
    namespace = "ingress-nginx"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_cluster_role.ingress_nginx.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ingress_nginx.metadata[0].name
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }
}

resource "kubernetes_role_binding" "ingress_nginx_admission" {
  metadata {
    labels = {
      "app.kubernetes.io/component" = "admission-webhook"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
      "app.kubernetes.io/part-of"   = "ingress-nginx"
      "app.kubernetes.io/version"   = "1.10.1"
    }
    name      = "ingress-nginx-admission"
    namespace = "ingress-nginx"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_cluster_role.ingress_nginx_admission.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ingress_nginx_admission.metadata[0].name
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }
}
