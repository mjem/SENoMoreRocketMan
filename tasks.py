#!/usr/bin/env python3

"""Project tools. Run `invoke` to execute."""

from pathlib import Path

from invoke import task


@task(help={
	'lua': 'Run lua lint over script',
	'language': 'Check for spelling and grammar in documentation, comments and l18n files',
	'files': 'General purpose filesystem checker',
	'git': 'Repository checker',
	'mod': 'Run custom factorio mod lint script',  # find a 3rd party one
	# or write on that just checks for l18n strings
})
def lint(c,
		 all=False,  # pylint: disable=redefined-builtin
		 language=False,
		 lua=False,
		 files=False,
		 git=False,
		 json=False,
		 locale=False,
		 markdown=False,
		 python=False,
		 mod=False,
		 ):
	"""Check files."""
	if all:
		language = True
		lua = True
		files = True
		git = True
		json = True
		locale = True
		markdown = True
		mod = True
		python = True

	if files:
		print("General file lint:\n")
		# c.run("docker pull cytopia/file-lint")
		file_lint = "docker run --rm -v $(pwd):/data cytopia/file-lint"
		# file_lints = [{"cmd": "file-empty"}, {"cmd": "file-crlf", "ignore": "*.diff"}]
		c.run("{cmd} file-empty --path .".format(cmd=file_lint))
		c.run("{cmd} file-cr --path .".format(cmd=file_lint))
		c.run("{cmd} file-crlf --ignore \"*.diff\" --path .".format(cmd=file_lint))
		c.run("{cmd} file-nullbyte --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		c.run("{cmd} file-trailing-newline --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		c.run("{cmd} file-trailing-space --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		c.run("{cmd} file-utf8 --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		c.run("{cmd} file-utf8-bom --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		c.run("{cmd} git-conflicts --ignore \".git,*.png\" --path .".format(cmd=file_lint))
		# whitespace
		# https://github.com/camsaul/whitespace-linter
		# filenames
		# https://ls-lint.org
		print()

	if markdown:
		print("Linting Markdown files:\n")
		files = [Path("README.md")]
		c.run("mdl -c .mdlrc {files} | grep -v MD003 | grep -v MD013 | grep -v MD046 "
			  "| grep -v 'these failures'".format(
			files=" ".join(str(f) for f in files)))
		print()

	if mod:
		# https://github.com/winkbrace/factorio-mod-checker
		pass

	if json:
		print("Linting JSON files:\n")
		files = [Path("*.json")]
		c.run("jsonlint-php {files}".format(files=" ".join(str(f) for f in files)))
		# factorio mod.info schema
		# https://github.com/justarandomgeek/vscode-factoriomod-debug/blob/current/schema/modinfo.json
		print()

	if locale:
		# https://github.com/WeblateOrg/locale_lint
		pass

	if python:
		print("Linting python files:\n")
		files = [Path("*.py")]
		c.run("pylint --rcfile .pylintrc {files}".format(files=" ".join(str(f) for f in files)))
		c.run("pycodestyle {files}".format(files=" ".join(str(f) for f in files)))
		c.run("pydocstyle {files}".format(files=" ".join(str(f) for f in files)))
		print()

	if lua:
		print("Linting lua files:\n")
		files = [Path("*.lua")]
		c.run("luacheck {files}".format(files=" ".join(str(f) for f in files)))
		print()

	if language:
		# vale?
		pass

	if git:
		# https://github.com/bkuhlmann/git-lint
		pass


@task
def dist(c,
		 versions=False,
		 zip=False,  # pylint: disable=redefined-builtin
		 license=False,  # pylint: disable=redefined-builtin
		 png=False,
):
	"""Show versions and make release zipfile."""
	if versions:
		# show versions from last git tag, info.json, changelog
		print("Most recent tag:")
		c.run("git describe --tags --abbrev=0")
		print("Tag of last comit:")
		c.run("git tag --points-at HEAD")
		version_file = Path("info.json")
		print("Version from {version_file}".format(version_file=version_file))

	if zip:
		# make distribution zipfile including version
		target = Path("SENoMoreRocketMan_0.3.1.zip")
		subdir = Path("SENoMoreRocketMan")
		files = [Path("*.md"),
				 Path("changelog.txt"),
				 Path("info.json"),
				 Path("*.lua"),
				 Path("thumbnail.png"),
				 Path("locale"),
				 ]
		with c.cd(".."):
			c.run("rm -f {target}".format(target=target))
			c.run("zip -vr9 {target} {files}".format(
				target=target, files=" ".join((str(subdir.joinpath(f)) for f in files))))

		print("Wrote {target}".format(target=target))

	if license:
		# Rebuild license file by download and convert
		pass

	if png:
		# optipng pngcrush pngnq pngquant trimage
		pass
