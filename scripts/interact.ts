import hre from "hardhat";
async function main(): Promise<void> {
  const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  const LandRegistry = await hre.ethers.getContractFactory("LandRegistry");
  const landRegistry = await LandRegistry.attach(contractAddress);
  const tx = await landRegistry.registerLand("John Doe", "Farm Land", "123 Rural Road", 5000);
  const receipt = await tx.wait(); // Wait for mining
  console.log("Land registered. Transaction hash:", tx.hash);
  const landCount = await landRegistry.landCount();
  console.log("Current land count:", landCount.toString());
  const landDetails: [string, string, string, bigint, string] = await landRegistry.getLandDetails(1);
  console.log("Land Details:", landDetails);
}
main()
  .then(() => process.exit(0))
  .catch((error: Error) => {
    console.error(error);
    process.exit(1);
  });
