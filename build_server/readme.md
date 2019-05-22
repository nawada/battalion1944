# サーバーの建て方

※正式リリース前の2019年5月22日の内容を翻訳しています。原文より古い場合があり、本文書と齟齬が発生している可能性があります。その場合は原文を参照してください。  
[原文](http://wiki.battaliongame.com/)

## 前置き

Server configuration is currently very early in development and as such you may encounter issues whilst setting everything up. We're also aware of features that are currently missing (such as an rcon-like remote admin tool). Please bear with us as we continue to develop the game as well as the community servers/tools. Currently you NEED to have the server exposed to the internet in order to connect to it. We are working on getting the LAN support up and running asap.

## ダウンロード

Updated **16/03/2018**

We now distribute our community servers via Steam. Please use the following command in `steamcmd` to download (includes both Windows + Linux builds):

`app_install 805140`

Alternatively, you can subscribe to the tool on the tools section of your Steam Library.

## セットアップ

### Linux

We have been testing our build on a machine running Ubuntu 17.04. Just copying the server files, make sure the server binary has the correct permissions and run the following with the launch parameters defined in the Launching section:

`LinuxServer\Battalion\Binaries\Linux\BattalionServer`

### Windows

Just unpack/copy the server files to your desired location and run the following with the launch parameters defined in the Launching section:

`WindowsServer\Battalion\Binaries\Win64\BattalionServer-Win64-Shipping.exe`

## ファイアウォール / ポートフォワーディング

At the moment the server will need four ports opened. As we develop new and interesting features over time it might be an idea to make sure that 5 ports from the base port are free.

When you specify `-PORT` on the server command line (see below) you are telling the server it is okay to listen on ports:

|ポート番号|使用目的|
|----|---------|
|`PORT` (デフォルト:`7777`)|ゲーム使用ポート|
|`PORT+1` (デフォルト:`7778`)|Steam接続ポート|
|`PORT+2` (デフォルト:`7779`)|RCon|
|`PORT+3` (デフォルト:`7780`)|クエリポート|

## 起動

Launching the server is currently not as intuitive as we'd like, however we would like to fix it up asap. We've included a script in both the Linux and Windows packages called **Run.sh** and **Run.bat** respectively. **You should only need to edit the IP and port information in those scripts before running them to get your server up and running.** For more advanced admins / integration engineers, below is an example of how we run our Linux version at the studio:

`./Battalion/Binaries/Linux/BattalionServer /Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen -broadcastip="<EXTERNAL_IP>" -PORT=<DESIRED_PORT> -QueryPort=<DESIRED_PORT + 3> -log -logfilesloc="/home/bulkbuild/logs" -userdir="/home/bulkbuild/userdir" -defgameini="/home/bulkbuild/DefaultGame.ini"`

|構文|説明|
|----|----|
|`/Game/Maps/Final_Maps/Derailed?Game=/Script/ShooterGame.BombGameMode?listen`|You are required to add a map & mode to launch the server with, but this is NOT USED to determine what map and mode list your server runs.|
|`-broadcastip="<EXTERNAL_IP>"`|This is your internet facing address. This is used by others to connect to your server.|
|`-PORT=<DESIRED_PORT>`|This is the "base port" of the server. Specifically, this is the one players use to connect to the game.|
|`-QueryPort=<DESIRED_PORT + 3>`|This is the "Query port" which helps steam and other services query your server for its current state.|
|`-log`|This can be used to allow messages to be printed to the system console. Right now there is only one or two messages regarding the anti-cheat initialization.|
|`-logfilesloc="/home/bulkbuild/logs"`|This tells the server where to print out some logs to. Not required.|
|`-userdir="/home/bulkbuild/userdir"`|This tells the server where to save out some files to. This is useful as this is where crash logs will be saved out to.|
|`-defgameini="/home/bulkbuild/DefaultGame.ini"`|This is the key command for most admins as the file referenced here will configure all of the game and map/mode behavior of the server.|

## RCon

Documentation for developing JSON based RCon tools is included in the folder structure of the the download. This also includes an example tool we developer along with the RCon API.

The documentation includes and email address you can send requests for added functionality to.

## マップ・マップローテーション

Under the heading `[/Script/ShooterGame.BattalionGameMode]` in the DefaultGame.ini supplied you will see the following:

|構文|
|----|
|`+ModeRotation=/Script/ShooterGame.TDMGameMode`|
|`+ModeRotation=/Script/ShooterGame.DOMGameMode`|
|`+ModeRotation=/Script/ShooterGame.CTFGameMode`|
|`+ModeRotation=/Script/ShooterGame.WartideGameMode`|
|`+MapRotation=Coastal`|
|`+MapRotation=Derailed`|
|`+MapRotation=Liberation`|
|`+MapRotation=Manorhouse_V1`|
|`+MapRotation=Manorhouse_V2`|
|`+MapRotation=Battery`|
|`+MapRotation=Outpost`|
|`+MapRotation=Invasion`|
|`+MapRotation=Savoia`|

Add or remove maps/modes in this list to control your rotations. To have a random mix of maps and modes set the following variable to True: RandomMapRotationEnabled and it will choose a random mode every map change.

### I Want the Aim Map!

Cool! Just add the following to the MapRotation:

|構文|
|----|
|`+MapRotation=AimMap_01`|

## Server + Game Configuration

Below is a list of all config variables that can be changed, along with their category and a description of what they do.

|構文|設定項目|説明|
|----|:------:|----|
|`UseDecideTeamRound`|Wartide|Initial round of the game that doesn't count towards score. The winning team will receive a vote to decide which team they want to start on.|
|`DecideTeamRoundIsKnifeOnly`|Wartide|If the decide team round (see: UseDecideTeamRound) is active, only melee attacks will be available.|
|`DecideRoundTime`|Wartide|The length of time that the decide team round (see: UseDecideTeamRound) will last.|
|`UseOvertime`|Wartide|If set to true, when the match results in a draw, overtime will start using|
|`NumOvertimeRounds`|Wartide|The total number of rounds in overtime. The first team to reach half the total plus one will win. If the total is reached without one team hitting this number, it will be a draw or overtime (if enabled).|
|`PlantTime`|Wartide|The time that it takes to plant the bomb.|
|`DefuseTime`|Wartide|The time that it takes to defuse the bomb.|
|`FuseTime`|Wartide|The time that is takes for the bomb to explode after it has been planted.|
|`DistanceToPlant`|Wartide|The distance there needs to be between the player with the bomb and the bomb site until they can plant.|
|`DistanceToDefuse`|Wartide|The distance there needs to be between the player and the bomb until they can defuse.|
|`DistanceToPickupBomb`|Wartide|The distance there needs to be between the player and the bomb until they can pick it up.|
|`DefuseEndsRound`|Wartide|Whether or not defusing the bomb instantly ends the round.|
|`AttackingTeam`|Wartide|Changes which team attacks first. 0 = Allies attack, 1 = Axis attack|
|`EnableCoinDrop`|Wartide|If a coin is dropped at the location of a killed player or if the killer is immediately credited with a coin.|
|`NumInitialTokensPlayer`|Wartide|The number of tokens players start the match with.|
|`NumTokensForKill`|Wartide|The worth of the coin dropped by a dead player is killed regularly.|
|`NumTokensForKnifeKill`|Wartide|The worth of the coin dropped by a dead player is killed with a melee attack.|
|`NumTokensForPistolKill`|Wartide|The worth of the coin dropped by a dead player is killed with a pistol.|
|`NumTokensForHeadshotKill`|Wartide|The worth of the coin dropped by a dead player is killed with a headshot.|
|`NumTokensForGrenadeKill`|Wartide|The worth of the coin dropped by a dead player is killed with a grenade.|
|`NumTokensForWallbangKill`|Wartide|The worth of the coin dropped by a dead player is killed with a wallbang.|
|`NumTokensForPlant`|Wartide|Number of tokens a player receives when they plant the bomb.|
|`NumTokensForDefuse`|Wartide|Number of tokens a player receives when they defuse the bomb.|
|`NumTokensForRoundWin`|Wartide|Number of tokens a player receives if the team they're on wins the round.|
|`MaxPlayerTokens`|Wartide|Max number of tokens a player can have in their wallet.|
|`RoundComebackTokens`|Wartide|Number of tokens a player receives if they're on the losing team.|
|`DistanceToFlagTouch`|Capture The Flag|The distance there needs to be between the player and the flag until they can interact with it.|
|`DistanceToFlagZone`|Capture The Flag|The distance there needs to be between the player and the flag site base until they can interact with it.|
|`DropFlagDisablePickupCounter`|Capture The Flag|The length of time that you cannot pick up the flag again after dropping it.|
|`DistanceToZone`|Domination|The distance there needs to be between the player and the domination point until they can start capturing it.|
|`CaptureTime`|Domination|The time that it takes to capture a domination zone from start to finish.|
|`CooldownTime`|Domination|The time that it takes for the zone capture progress to reset when no players are present.|
|`ScoreInterval`|Domination|The time that it takes for 1 point to be added to the team that control the point.|
|`CaptureScore`|Domination|The score a team receives for capturing a point.|
|`WeaponSelectGracePeriod`|Team Deathmatch|The time from a player's first spawn where they can select a weapon. Select a weapon after this time will spawn you with it on your next respawn.|
|`EndOnMatchPointWin`|Team Deathmatch|If set to true, the match will end when a team reaches match point. If false, it will play out all rounds (see: NumRounds).|
|`ServerName`|Server|The name of the server that will appear on the server browser and the in-game scoreboard.|
|`PlayMode`|Server|Use 'Arcade' for arcade game modes and 'Unranked' for Wartide.|
|`ShouldTryBalanceTeamsOnJoin`|Server|If true, the server will attempt to balance the teams when starting a new game. Note that this does not take score into account.|
|`Password`|Server|The password for the server.|
|`RandomMapRotationEnabled`|Server|If true, the game will ignore the order of the maps in rotation (see: MapRotation).|
|`MapRotation`|Server|The maps that will rotate when each game finishes. Example: ("Liberation","Derailed","Manorhouse_V1").|
|`ModeRotation`|Server|The modes that will be rotated when each game finished. Example: .|
|`AdminSteamIDs`|Server|Steam IDs of all players that can access console commands.|
|`DedServerMaxTickRate`|Server|This the maximum tick rate of the server.|
|`bAllowGlobalVoiceChat`|Server|Whether or not to allow voice chat in the server.|
|`bCheatAdminCmdsEnabled`|Server|Whether or not admins (see: AdminSteamIDs) are allows to use cheat commands.|
|`StratMode`|Server|Enabling StratMode allows for various training abilities to become available such as the ability to follow the path of grenades/smokes that you throw.|
|`loggingEnabled`|Server|If enabled, the game will log various events to a file.|
|`logLocation`|Server|The file path that the game will log events to (see LoggingEnabled).|
|`MarketPath`|Server|File path to the JSON weapon market.|
|`PlayerKillScore`|Score|The score value of a standard kill.|
|`PlayerAssistScore`|Score|The score value of an assist.|
|`TeamKillScore`|Score|The score value of a teamkill.|
|`TeamAssistScore`|Score|The score value of assisting a teamkill.|
|`DeathScore`|Score|The score value of dying.|
|`RoundWinScore`|Score|The score value of winning a round.|
|`RoundDrawScore`|Score|The score value of drawing a round.|
|`RoundLossScore`|Score|The score value of losing a round.|
|`GameWinScore`|Score|The score value of winning the game.|
|`GameDrawScore`|Score|The score value of drawing the game.|
|`GameLossScore`|Score|The score value of losing the game.|
|`AttackObjectiveScore`|Score|The score value of attacking an objective. For example: Planting the bomb or capturing the flag.|
|`DefendObjectiveScore`|Score|The score value of defending an objective. For example: Defusing the bomb or returning the flag.|
|`ScoreToWinRound`|Game|The score required to win the round, this would be 1 in wartide and any chosen amount in arcade modes.|
|`NumRounds`|Game|The total number of rounds in the match.|
|`SwapSidesRound`|Game|The round number at which the half time side swap occurs.|
|`NumTeams`|Game|The number of teams in the match.|
|`StartType`|Game|The requirement for starting the match. 'ReadyUp' to enforce every player needing to ready up before starting the game. 'PlayerCount' to start the game when the number of players reached the required amount (see: RequiredPlayers).|
|`MaxPlayersPerTeam`|Game|The maximum amount of players allowed in a team.|
|`NumNations`|Game|The number of nations in the match.|
|`FriendlyFire`|Game|Enable to be able to deal damage to friendly players.|
|`MaxGunsOnGround`|Game|Maximum number of guns that can exist on the floor before they begin to get despawned.|
|`MaxGrenadesOnGround`|Game|Maximum number of grenades/smokes that can exist on the floor before they begin to get despawned.|
|`RequiredPlayers`|Game|Required number of players needed to start the match during the 'PlayerCount' start type (see: StartType).|
|`RespawnDelay`|Game|Time between dying and respawning.|
|`AutoBalanceEnabled`|Game|If enabled, when starting a new game the server attempts to balance the teams according to player scores.|
|`CountdownToStartTime`|Timing|Time it takes to start the match after the start requirements have been met (see: StartType).|
|`SetupRoundTime`|Timing|Time allowed for purchasing weapons in the buy phase of rounds in Wartide.|
|`StratTime`|Timing|Time allowed between purchasing weapons and starting the round.|
|`RoundTime`|Timing|The length of time that each round lasts.|
|`PostRoundTime`|Timing|The length of time between the result of that round and the next start, whether that is the start of the next round or the end of the match.|
|`WarmupRespawnTime`|Timing|Sets the respawn time for the warmup phase.|
|`PostMatchTime`|Timing|The length of time for the post match state. This state being the one when the scoreboard shows at the end of the match.|
|`TimeUntilTravel`|Timing|The length of time between the post match scoreboard state and traveling to the next game.|
|`WaitingToStartTimer`|Timing|If StartType is set to 'PlayerCount' and the play mode is 'Competitive', the server will kick all players and travel to a new game when the game time reaches this value.|
|`VoteTime`|Timing|The length of time that in-game votes last.|
|`VoteKickEnabled`|Timing|Whether or not players are able to vote kick other players.|
|`IdleCasualServerTime`|Timing|The time that players are able to stay idle before getting kicked.|
|`CharacterDestroyTime`|Timing|The length of time that characters stay in game after dying until they are cleaned up.|
|`OutlineAllowed`|Spectator|If enabled, spectators can toggle xray mode, allowing them to see outlines around players at all times.|
|`GrenadeLinesAllowed`|Spectator|If enabled, spectators can toggle an option to see line trails that follow the trajectory or thrown grenades / smokes.|
|`LockedToFirstPerson`|Spectator|Whether players are locked in first person mode when the spectate their team after dying.|
|`SpectatorTransferTime`|Spectator|Time it takes to move into spectator mode after dying. As long as this time is less than the respawn time (see: RespawnDelay), the player will be made to spectate their team after this time.|
|`SpectatorTeamEnabled`|Spectator|Whether or not players are allowed to transfer on to the spectator team.|
|`SelfGrenadeDamageScale`|Damage Scales|How much damage a thrown grenade does to the player that threw it. 0 = None, 1 = Normal, 2 = Double|
|`SelfOtherDamageScale`|Damage Scales|How much damage you take from fall damage an other methods of causing damage to yourself. 0 = None, 1 = Normal, 2 = Double|
|`FriendlyBulletDamageScale`|Damage Scales|How much damage bullets do to friendly players if friendly fire (see: FriendlyFire) is enabled. 0 = None, 1 = Normal, 2 = Double|
|`FriendlyGrenadeDamageScale`|Damage Scales|How much damage grenades do to friendly players if friendly fire (see: FriendlyFire) is enabled. 0 = None, 1 = Normal, 2 = Double|
|`DisableWeaponDrop`|Misc|If this is enabled, players do not drop weapon when they die.|
|`AllPlayersInvulnerable`|Misc|If enabled, all players take no damage.|
|`NumBots`|Bots|The number of bots that spawn in at the start of the game. The game will distribute the bots evenly to each team.|
|`FillEmptySlotsWithBots`|Bots|If true, the game will fill empty slots with bots (see: MaxPlayersPerTeam).|

## ロードアウト変更

Locate the Loadouts directory inside the server package. Here you can create your own loadout json file (we would recommend duplicating one of the existing ones) and then reference the name inside the DefaultGame.ini.

This Loadout controls which weapons are assigned to which Nation, how much the weapon costs in Wartide, the number of grenades and specials a weapon comes with, what the default primary is and what the default secondary is.

## サーバー管理者コマンド

First you need to add your steam guid to the AdminSteamIDs array variable. This could look like:

`+AdminSteamIDs="76561197976577178"`

See below for a mix of official and dev/debug commands. Not all commands are listed and those that are may or may not exist in future versions.

All start with **"Server."**

**Note:** If confused about the references to team 0 and team 1: a quick way to find out which is which is by checking the team select menu. The team on the left is always team 0 and the team on the right is always team 1.

| | | |
|-|-|-|
|Server.Config.<Config Name> <Desired Value>|Edit the value of any config variable. Note that some changes will not take effect immediately.|Server.Config.RoundTime 120|
|Server.Restart|Restarts the server with its current settings.||
|Server.Shutdown|Closes down the server.||
|Server.State <Desired State>|Transfers the server directly into the desired state.|Server.State SetupRound|
|Server.Pause|Pauses the server's timer. Players are still allowed to move and interact in this time. Purely used to stop the game timer.||
|Server.EndRound|Ends the current round in a draw.||
|Server.WinRound|Wins the round for the player's team that typed the command. Note: Do not use when on the spectating team.||
|Server.LoseRound|Loses the round for the player's team that typed the command. Note: Do not use when on the spectating team.||
|Server.LoadNextGame|Loads the next game. The next game is defined in the Map and Mode rotation configs.||
|Server.ChangeMap.<Map Name> <Mode Name>|Loads the server into the selected map and mode.|Server.ChangeMap Liberation WRT|
|Server.AutoBalance|This command instantly calls the server's autobalance function that is usually called between games. The server will attempt to balance the teams bases on players' current score.||
|Server.Announce <Message>|Gives every player in the game an on-screen message.|Server.Announce The server will be closing in 5 minutes.|
|Server.Invulnerable|Makes the player that typed the command invulnerable.||
|Server.GiveWeapon <Weapon Name> <Skin ID> <Weapon Slot>|Give yourself a weapon with a specfic skin in a specific weapon slot.|Server.GiveWeapon Kar_98k -1 0|
|Server.GiveWeaponToPlayer <Weapon Name> <Skin ID> <Weapon Slot> <Steam ID>|Use another player's steam ID to give them a weapon in a specific weapon slot.|Server.GiveWeapon Kar_98k -1 0 12345678901234567|
|Server.GiveGrenade <Amount>|Give yourself an amount of frag grenades.|Server.GiveGrenade 50.|
|Server.GiveSmokeGrenade <Amount>|Give yourself an amount of smoke grenades.|Server.GiveSmokeGrenade 50|
|Server.GiveGrenadeToPlayer <Steam ID> <Amount>|Use another player's steam ID to give them an amount of frag grenades.|Server.GiveGrenadeToPlayer 12345678901234567 1|
|Server.GiveSmokeGrenadeToPlayer <Steam ID> <Amount>|Use another player's steam ID to give them an amount of smoke grenades.|Server.GiveSmokeGrenadeToPlayer 12345678901234567 2|
|Server.GiveAmmo <Amount>|Give yourself an Amount of ammo. Note that this can only fill the ammo to the max ammo for that weapon.|Server.GiveAmmo 999|
|Server.DisconnectAll|Kick all connected clients from the server.||
|Server.AddBot <Amount>|Add an amount of bots to the server. The server will split the added bots 50/50 starting from the axis side.|Server.AddBot 10|
|Server.AddBot <Amount> <Team>|Add an amount of bots to a specific team.|Server.AddBots 5 0|
|Server.KillBots|Remove all bots from the server. Note that if the config variable FillEmptySlotsWithBots is true, this command will not remove the bots that are filling the empty slots on each team.||
|Server.KickPlayerByName <Name>|Kicks any players with the given name from the server,|Server.KickPlayerByName JohnSmith123|
|Server.KickPlayerBySteamID <Steam ID>|Kicks the player with the given steam ID from the server.|Server.KickPlayerBySteamID 12345678901234567|
|Server.ListPartyMembers|Lists your current party members in the console.||
|Server.ChangeToTeam <Team>|Changes you to a specific team.|Server.ChangeToTeam 0|
|Server.SwapSides|Swap the sides just like it would do at half time.||
|Server.SetTeamOneScore <Score>|Sets the score of team one.|Server.SetTeamOneScore 8|
|Server.SetTeamTwoScore <Score>|Sets the score of team two.|Server.SetTeamTwoScore 10|

**Cmd.GetPlayerStats** will dump out the entire session player info.

## ブラックリスト

Blacklisting is currently an option through use of the RCon tool. This generates a file that you can manually add to if you so desire.

## 接続

You can search the server browser for games (filters coming soon!) or you type the following:

`connect <IP>:<PORT>`

and if you have a password:

`connect <IP>:<PORT> password <PASSWORD>`

## Tips + トラブルシューティング

**Your server will take at least one minute to appear in the list.** Please make sure you wait for this period when troubleshooting issues.

## 既知の問題

Your server may disappear from the server list when it is transitioning to a new map. This is a known issue and will be fixed asap.

## 競技ルール

The competitive ruleset for Battalion 1944's Wartide game mode is included in the dedicated server files you can download from steam. However, you can also get it from the following PasteBin link:

https://pastebin.com/S8ee1FgD
