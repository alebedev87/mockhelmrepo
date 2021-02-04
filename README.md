# Mock of Helm Chart Repository
Aims at mocking a Helm Chart Repository server for testing purposes.   
Some details:
- Based on [chartmuseum](https://github.com/helm/chartmuseum)
- Exposes a service whose name can be customized [here](https://github.com/alebedev87/mockhelmrepo/blob/master/charts/mockhelmrepo/values.yaml#L31)
- Nginx reverse proxy is used in between the client and the chart museum
- Proxy is needed to add the name of the helm repository as Helm clients require: `http(s)://<repo-dns-name>/<helm-repo-name>`
- Helm repository name is customizable too: [here](https://github.com/alebedev87/mockhelmrepo/blob/master/charts/mockhelmrepo/values.yaml#L13)
- If the default values are used, the URL on which the mock will be available would look like: `http://museum/helm-repo`

## Usage
- Populate your chart museum:
```bash
$ ls -1
chartstorage/
Dockerfile
# package your charts using 'helm package' command
$ ls -1 chartstorage/
my-chart-0.0.4.tgz
$ cat Dockerfile
FROM docker.io/alebedev87/mockhelmrepo:0.0.1
# this will add the contents of './chartstorage'
$ docker build -t mymockhelmrepo:0.0.1 .
```
- Deploy the mock with your chart museum
```bash
$ helm install --set repo.image.repository=myhelmrepo --set repo.image.tag=0.0.1 mockhelmrepo ./charts/mockhelrepo
```
