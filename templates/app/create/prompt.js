// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//

const config = require('../../../.mops.js')
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


const getConfig = () => {
  return new Promise((resolve) => {
    rl.question('Enter app-name (dasherized): ', (appName) => {
      config.app_name = appName;
      config.app_name_underscored = config.app_name.replace(/-/g, '_')
      config.platform_name_underscored = config.platform_name.replace(/-/g, '_')
      config.repo_dasherized = `${config.app_name}-repo`
      config.repo_underscored = config.repo_dasherized.replace(/-/g, '_')
      rl.close();
      const r2 = readline.createInterface({
        input: process.stdin,
        output: process.stdout
      });
      r2.question('Enter app-name (www): ', (subDomain) => {
        config.sub_domain = subDomain;
        config.sub_domain_underscored = config.sub_domain.replace(/-/g, '_');
        r2.close();
        const r3 = readline.createInterface({
          input: process.stdin,
          output: process.stdout
        });
        r3.question('Enter Rails Env (production/staging): ', (rails_env) => {
          config.rails_env = rails_env;
          r3.close();
          console.log(config)
          resolve(config);
        });
      });
    });
  });
};

// Use an async function to handle the Promise
const getConfigsAsync = async () => {
  const config = await getConfig();
  return config
};

module.exports = {
  params: getConfigsAsync,
}
