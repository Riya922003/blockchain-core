import { Contract } from "ethers";
import hre from "hardhat";
async function main(): Promise<void> {
  const LandRegistry = await hre.ethers.getContractFactory("LandRegistry");
  const landRegistry: Contract = await LandRegistry.deploy();
  await landRegistry.waitForDeployment();
  const contractAddress: string = await landRegistry.getAddress();
  console.log("LandRegistry deployed to:", contractAddress);
}
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
