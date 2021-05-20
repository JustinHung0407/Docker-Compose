## GitOps
* GitOps including Gitea, Drone, argocd and SonarQube which producing CICD workflow for projects
* Steps
  * Prerequisite
    1. Clone this project or prepare a full project with tests
  * Gitea
    * git add; git commit; git push 
  * Drone
    1. Create drone pipeline file for building your project, e.g., [.drone.yml]()
    2. On Drone main page you'll need to
       1. activate project (admin only)
       2. tick the checkbox of "Trusted" and save
       3. configure secrets
       4. gitea push to trigger build
  * Argocd
    1. Create folder to add k8s deploy files, e.g., [deploy]()
    2. On Argocd main page you'll need to
       1. add repository (setting=>repositories=>connect repo using https or ssh)
       2. add project (setting=>projects=>new projects)
       3. New app
       4. gitea push to trigger deployment
  * SonarQube
    1. add sonar-project.properties and config
    2. trigger using package manager(gradle) or drone (see .drone.yml=>step name: Code-Analysis)