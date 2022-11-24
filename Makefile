.PHONY: prep demo-quickstart demo-multiserver demo-configfile demo-helm demo-kustomize

demo-quickstart:
	scripts/quickstart.sh

demo-multiserver:
	scripts/multiserver.sh

demo-configfile:
	scripts/configfile.sh

demo-helm:
	scripts/lifecycle-helm.sh

demo-kustomize:
	scripts/lifecycle-kustomize.sh

prep:
	scripts/prep.sh
