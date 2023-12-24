// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//

const config = require('../../../.mops.js')
const app = require('../../../.mops_app.js')
const { execSync } = require('child_process');

function ssl_cert_arn() {
  const cmd = "cd terraform && terraform output acm_arn_" + app.sub_domain_underscored;
  const output = execSync(cmd, { encoding: 'utf8' }).trim();
  const ssl_cert_arn = output.replace(/^"(.*)"$/, '$1');
  return {
    ssl_cert_arn
  };
}


module.exports = {
  params: () => {
    params = ({ ...config, ...app, ...ssl_cert_arn() })
    return params
  }
};


