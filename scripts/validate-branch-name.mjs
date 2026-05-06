const branchName = process.argv[2] ?? process.env.BRANCH_NAME;
const branchPattern = /^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert|release)(\/[a-z0-9]+(?:-[a-z0-9]+)*)+$/;

if (!branchName) {
  console.error('Missing branch name. Pass it as an argument or set BRANCH_NAME.');
  process.exit(1);
}

if (!branchPattern.test(branchName)) {
  console.error(`Invalid branch name: ${branchName}`);
  console.error('Expected format: <type>/<description> or <type>/<scope>/<description>');
  process.exit(1);
}

console.log(`Branch name is valid: ${branchName}`);
