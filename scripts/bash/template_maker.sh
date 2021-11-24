#! /bin/bash
# script to auto-generate html templates.
# create alias and link to this script.

name=("$@")

# HTML boiler function
htmlPage() {
cat << EOF >> index.html
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>${name}</title>
		<link href="style.css" rel="stylesheet">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="script.js" defer></script>
	</head>
	<body>
	</body>
</html>
EOF
}

cssPage() {
cat << EOF >> style.scss
@use 'nord' as *;
body {
	background: \$nord0;
}
EOF
}

nordPage() {
cat << EOF >> _nord.scss
\$nord0: black; 
EOF
}

# Create Files and Directories
mkdir ${name}
cd ${name}
touch index.html style.scss _nord.scss script.js package.json
htmlPage
cssPage
nordPage
