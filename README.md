<!-- markdownlint-disable first-line-h1 no-duplicate-heading no-inline-html -->
<div align="center">
  <h3>
    <b>
      Jsonic Charts
    </b>
  </h3>
  <b>
    Scalable Kubernetes Deployments for Jsonic
  </b>
  <p>

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen?logo=github)](CODE_OF_CONDUCT.md)
[![Website](https://avatars.githubusercontent.com/u/232531597)](https://jsonic.ir)
[![Tweet](https://img.shields.io/twitter/url?url=https%3A%2F%2Fjsonic.ir%2F)](https://twitter.com/share?text=%F0%9F%91%BD%20Jsonic%20%E2%80%A2%20Open%20source%20API%20development%20ecosystem%20-%20Helps%20you%20create%20requests%20faster,%20saving%20precious%20time%20on%20development.&url=https://jsonic.ir&hashtags=jsonic&via=jsonic_io)

  </p>
  <p>
    <sub>
      Built with ❤︎ by
      <a href="https://github.com/jsonic/helm-charts/graphs/contributors">
        contributors
      </a>
    </sub>
  </p>
</div>

#### **Support**

[![Chat on Discord](https://img.shields.io/badge/chat-Discord-7289DA?logo=discord)](https://jsonic.ir/discord)
[![Chat on Telegram](https://img.shields.io/badge/chat-Telegram-2CA5E0?logo=telegram)](https://jsonic.ir/telegram)

### **Features**

❤️ **Enterprise Ready:** Built for large-scale deployments with security in mind.

⚡️ **High Performance:** Optimized for speed and resource efficiency.

🔒 **Security First:** Built-in security features and compliance controls.

🌐 **Multi-Cloud:** Deploy anywhere with our cloud-agnostic architecture.

🚀 **Scalable:** Automatically scales based on your workload.

🔄 **High Availability:** Built-in redundancy and failover capabilities.

### **Installation Guides**

<details>
<summary><b>Digital Ocean Installation</b></summary>

## Prerequisites

- Digital Ocean account with administrative access
- kubectl CLI tool
- Helm 3.x installed
- doctl installed

## Quick Install

```bash
# Configure access
export KUBECONFIG=path/to/k8s-config.yaml

# (Optional) Install NGINX Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/do/deploy.yaml

# Add chart repository
helm repo add jsonic https://jsonic.github.io/helm-charts

# Deploy application
## Community
helm install [RELEASE_NAME] jsonic-co/jsonic-co-community -f [path-to-values-file]

## Enterprise
helm install [RELEASE_NAME] jsonic-co/jsonic-co-enterprise -f [path-to-values-file]
```

</details>

<details>
<summary><b>GCP Installation</b></summary>

## Prerequisites

- Google Cloud account with GKE access
- gcloud CLI configured
- kubectl CLI tool
- Helm 3.x installed

## Quick Install

```bash
# Configure cluster access
gcloud container clusters get-credentials cluster-name --zone zone --project project-id

# (Optional) Install NGINX Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# Add chart repository
helm repo add jsonic https://jsonic.github.io/helm-charts

# Deploy application
## Community
helm install [RELEASE_NAME] jsonic-co/jsonic-co-community -f [path-to-values-file]

## Enterprise
helm install [RELEASE_NAME] jsonic-co/jsonic-co-enterprise -f [path-to-values-file]
```

</details>

## **About Helm Charts**

Our application uses Helm for package management in Kubernetes. Helm Charts help you:

- 📦 Define, install, and upgrade Kubernetes applications
- 🔄 Share applications with others
- 🔧 Manage complex deployments with simple commands
- ⏪ Roll back to previous versions when needed

## **Contributing**

Please contribute using [GitHub Flow](https://guides.github.com/introduction/flow). Create a branch, add commits, and
[open a pull request](https://github.com/jsonic/helm-charts/compare).

Please read [`CONTRIBUTING`](CONTRIBUTING.md) for details on our [`CODE OF CONDUCT`](CODE_OF_CONDUCT.md), and the
process for submitting pull requests to us.

## **Continuous Integration**

We use [GitHub Actions](https://github.com/features/actions) for continuous integration.

## **Authors**

This project owes its existence to the collective efforts of all those who contribute —
[contribute now](CONTRIBUTING.md).

<div align="center">
  <a href="https://github.com/jsonic/helm-charts/graphs/contributors">
    <img src="https://opencollective.com/jsonic/contributors.svg?width=840&button=false"
      alt="Contributors"
      width="100%" />
  </a>
</div>

## **License**

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) — see the [`LICENSE`](LICENSE)
file for details.
