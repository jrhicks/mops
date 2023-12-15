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
    rl.question('Enter app-name (dasherized): ', (userInput) => {
      config.app_name = userInput;
      config.repo_dasherized = `${config.environment}-${config.app_name}-repo`
      config.repo_underscored = config.repo_dasherized.replace(/-/g, '_')
      rl.close();
      resolve(config);
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
