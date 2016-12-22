#!/bin/sh

oldVersion=$1
newVersion=$2

pomFiles="beheer/product/cintia/cintia.product beheer/presentatie/presentatie/plugin.xml cintia/plugin/updateberekendewaarden/pom.xml cintia/plugin/updatenuttigespoorlengte/pom.xml"
manifestFiles="cintia/plugin/updateberekendewaarden/META-INF/MANIFEST.MF cintia/plugin/updatenuttigespoorlengte/META-INF/MANIFEST.MF"

if printf '%s' "$oldVersion" | grep -q SNAPSHOT; then
	echo "Releasing $newVersion."
	escapedOldPomVersion=$(printf '%s' "$oldVersion" | sed 's/[.[\*^$]/\\&/g')
	escapedOldManifestVersion=$(printf '%s' "$oldVersion" | sed 's/-SNAPSHOT/\.qualifier/g' | sed 's/[.[\*^$]/\\&/g')
	escapedNewVersion=$(printf '%s' "$newVersion" | sed 's/[.[\*^$]/\\&/g')
	echo "$escapedOldPomVersion $escapedOldManifestVersion wordt $escapedNewVersion"
	for FILE in $pomFiles
    do
    	sed -i -b "s/$escapedOldPomVersion/$escapedNewVersion/g" $FILE
    done
	for FILE in $manifestFiles
    do
    	sed -i -b "s/$escapedOldManifestVersion/$escapedNewVersion/g" $FILE
    done
else
    echo "Updating release $oldVersion to new snapshot version $newVersion."
	
	escapedOldVersion=$(printf '%s' "$oldVersion" | sed 's/[.[\*^$]/\\&/g')
	escapedNewPomVersion=$(printf '%s' "$newVersion" | sed 's/[.[\*^$]/\\&/g')
	escapedNewManifestVersion=$(printf '%s' "$newVersion" | sed 's/-SNAPSHOT/\.qualifier/g' | sed 's/[.[\*^$]/\\&/g')
	echo "$escapedOldVersion wordt $escapedNewPomVersion en $escapedNewManifestVersion"
	for FILE in $pomFiles
    do
    	sed -i -b "s/$escapedOldVersion/$escapedNewPomVersion/g" $FILE
    done
	for FILE in $manifestFiles
    do
    	sed -i -b "s/$escapedOldVersion/$escapedNewManifestVersion/g" $FILE
    done
fi
