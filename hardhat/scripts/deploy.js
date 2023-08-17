const hre = require('hardhat');
async function main() {

  const Magical = await hre.ethers.deployContract("MagicalNfts", );

  await Magical.waitForDeployment();

  console.log('deploy MagicalNfts contract to', Magical.target);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
