const hre = require('hardhat');
async function main() {

  const Klayzilla = await hre.ethers.deployContract("KlayZilla", );

  await Klayzilla.waitForDeployment();

  console.log('deploy Klayzilla contract to', Klayzilla.target);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
