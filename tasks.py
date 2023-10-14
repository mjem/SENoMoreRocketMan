#!/usr/bin/env python3

import invoke

@task(help={
	'lua': 'Run lua lint over script',
	'language': 'Check for spelling and grammar in documentation, comments and l18n files',
	'rst': 'Check restructured text files',
	'files': 'General purpose filesystem checker',
	'git': 'Repository checker',
	'mod': 'Run custom factorio mod lint script',  # find a 3rd party one
	# or write on that just checks for l18n strings
})
def lint(lua=True,
		 language=True,
		 rst=True,
		 files=True,
		 git=True):
	"""Check files."""
	pass

@task
def package(
		versions=True,
		zip=True):
	"""Show versions and make release zipfile."""
	# Show version from last git tag
	# Show version from info.json
	# Show versions in changelog
	pass
