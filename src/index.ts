import { ActivityType, Client, GatewayIntentBits } from "discord.js";

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

console.log("Starting bot...");

client.once("clientReady", () => {
  console.log(`Logged in as ${client.user?.tag}!`);
  client.user?.setActivity("with TypeScript", {
    type: ActivityType.Custom,
    state: "Sweet and Freshy!",
  });
});

client.login(process.env.DISCORD_TOKEN);
