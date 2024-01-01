// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//

const { execSync } = require('child_process');

function get_repo_details() {
  // git remote get-url origin
  url = execSync("git remote get-url origin", { encoding: 'utf8' }).trim()
  return {
    repo_owner: url.split("/")[3],
    repo_name: url.split("/")[4].split(".")[0]
  }
}

function random_vipc_cidr_block() {
  v = Math.floor(Math.random() * 240) + 10;
  return `10.${v}.0.0/16`
}

var repo_details = get_repo_details()

module.exports = [
  {
    type: 'input',
    name: 'platform_name',
    message: "What is the name of the Company or Platform (dash format) for example my-company?",
    default: 'my-company'
  },
  {
    type: 'input',
    name: 'aws_vpc_cidr',
    message: "Input a unique CIDR bock for this VPC eg (10.220.0.0/16, or 10.221.0.0/16, 10.222.0.0/16)?",
    default: random_vipc_cidr_block()
  },
  {
    type: 'input',
    name: 'aws_region',
    message: "What AWS Region do you want to deploy to? (e.g. '<%=aws_region%>')",
    default: '<%=aws_region%>'
  },
  {
    type: 'input',
    name: 'github_owner',
    message: "What is your Github Owner?",
    default: repo_details.repo_owner
  },
  {
    type: 'input',
    name: 'github_repo_name',
    message: "What is your Github Repo Name?",
    default: repo_details.repo_name
  }
]
