import { readFileSync, writeFileSync } from 'node:fs';

const nextVersion = process.argv[2];

if (!nextVersion) {
  console.error('Missing version argument.');
  process.exit(1);
}

const packageJsonPath = new URL('../package.json', import.meta.url);
const lipsumPath = new URL('../lipsum', import.meta.url);
const lipsumizePath = new URL('../lipsumize', import.meta.url);

const packageJson = JSON.parse(readFileSync(packageJsonPath, 'utf8'));
packageJson.version = nextVersion;
writeFileSync(packageJsonPath, `${JSON.stringify(packageJson, null, 2)}\n`);

const lipsumContents = readFileSync(lipsumPath, 'utf8');
const updatedLipsumContents = lipsumContents.replace(
  /typeset __version='[^']+'/,
  `typeset __version='${nextVersion}'`
);

if (updatedLipsumContents === lipsumContents) {
  console.error('Could not update lipsum version string.');
  process.exit(1);
}

writeFileSync(lipsumPath, updatedLipsumContents);

const lipsumizeContents = readFileSync(lipsumizePath, 'utf8');
const updatedLipsumizeContents = lipsumizeContents.replace(
  /typeset __version='[^']+'/,
  `typeset __version='${nextVersion}'`
);

if (updatedLipsumizeContents === lipsumizeContents) {
  console.error('Could not update lipsumize version string.');
  process.exit(1);
}

writeFileSync(lipsumizePath, updatedLipsumizeContents);
