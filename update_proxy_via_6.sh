#!/bin/bash

cp -p $0 /tmp/save.$$

set -eux
git reset --hard master
if ! git merge 'VRT_DirectorResolve' 'vtp_preamble'; then
	echo SHELL to resolve conflict
	bash
fi
commits=(
    # add an ipv6 bogo ip by the name b...
    27482fded156b5a668b01be01d08e17327af80e6
    # Basic "via" backends support
    30e92f353a6561612b87d036fde5176c64e51921
    # via backends in VCL
    23940eefd67dbda79d90777d51bf87687d9aebae
    # Add the .authority field to backend...
    f97d6b4e1c19cc663235dc492b93ba32f0c4f418
)
for c in "${commits[@]}" ; do
    if ! git cherry-pick "${c}" ; then
	echo SHELL to resolve conflict
	bash
    fi
done

cp -p /tmp/save.$$ $0
git add $0
git commit -m 'add the update script'
