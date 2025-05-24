const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying DocumentVerificationSystem contract with account:", deployer.address);

  const DocumentVerificationSystem = await hre.ethers.getContractFactory("DocumentVerificationSystem");
  const documentVerificationSystem = await DocumentVerificationSystem.deploy();

  await documentVerificationSystem.deployed();

  console.log("DocumentVerificationSystem deployed to:", documentVerificationSystem.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
