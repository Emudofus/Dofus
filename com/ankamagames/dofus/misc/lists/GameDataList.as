package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.datacenter.servers.ServerCommunity;
   import com.ankamagames.dofus.datacenter.servers.ServerGameType;
   import com.ankamagames.dofus.datacenter.servers.ServerPopulation;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterDrop;
   import com.ankamagames.dofus.datacenter.notifications.Notification;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.spells.SpellType;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.breeds.Head;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.HintCategory;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.MapReference;
   import com.ankamagames.dofus.datacenter.world.MapScrollAction;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.dofus.datacenter.items.Weapon;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.items.ItemSet;
   import com.ankamagames.dofus.datacenter.misc.Month;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.datacenter.npcs.NpcAction;
   import com.ankamagames.dofus.datacenter.npcs.NpcMessage;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentBalance;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentEffect;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentGift;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentOrder;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentRank;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentRankJntGift;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentTitle;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.dofus.datacenter.guild.RankName;
   import com.ankamagames.dofus.datacenter.guild.EmblemBackground;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbolCategory;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.QuestCategory;
   import com.ankamagames.dofus.datacenter.quest.QuestStep;
   import com.ankamagames.dofus.datacenter.quest.QuestStepRewards;
   import com.ankamagames.dofus.datacenter.quest.QuestObjective;
   import com.ankamagames.dofus.datacenter.quest.QuestObjectiveType;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveBringItemToNpc;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveBringSoulToNpc;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveDiscoverMap;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveDiscoverSubArea;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveDuelSpecificPlayer;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveFightMonster;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveFightMonstersOnMap;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveMultiFightMonster;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveFreeForm;
   import com.ankamagames.dofus.datacenter.quest.objectives.QuestObjectiveGoToNpc;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.datacenter.quest.AchievementObjective;
   import com.ankamagames.dofus.datacenter.quest.AchievementReward;
   import com.ankamagames.dofus.datacenter.quest.treasureHunt.PointOfInterest;
   import com.ankamagames.dofus.datacenter.quest.treasureHunt.PointOfInterestCategory;
   import com.ankamagames.dofus.datacenter.mounts.Mount;
   import com.ankamagames.dofus.datacenter.mounts.MountBone;
   import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
   import com.ankamagames.dofus.datacenter.mounts.RideFood;
   import com.ankamagames.dofus.datacenter.livingObjects.Pet;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.dofus.datacenter.appearance.Appearance;
   import com.ankamagames.dofus.datacenter.appearance.SkinMapping;
   import com.ankamagames.dofus.datacenter.livingObjects.SpeakingItemsTrigger;
   import com.ankamagames.dofus.datacenter.livingObjects.SpeakingItemText;
   import com.ankamagames.dofus.datacenter.livingObjects.LivingObjectSkinJntMood;
   import com.ankamagames.dofus.datacenter.abuse.AbuseReasons;
   import com.ankamagames.dofus.datacenter.misc.Tips;
   import com.ankamagames.dofus.datacenter.misc.Pack;
   import com.ankamagames.dofus.datacenter.misc.OptionalFeature;
   import com.ankamagames.dofus.datacenter.communication.CensoredWord;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.appearance.TitleCategory;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.datacenter.misc.Url;
   import com.ankamagames.dofus.datacenter.monsters.MonsterMiniBoss;
   import com.ankamagames.dofus.datacenter.sounds.SoundAnimation;
   import com.ankamagames.dofus.datacenter.sounds.SoundBones;
   import com.ankamagames.dofus.datacenter.interactives.StealthBones;
   import com.ankamagames.dofus.datacenter.misc.TypeAction;
   import com.ankamagames.dofus.datacenter.externalnotifications.ExternalNotification;
   import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
   import com.ankamagames.dofus.datacenter.sounds.SoundUi;
   import com.ankamagames.dofus.datacenter.sounds.SoundUiElement;
   import com.ankamagames.dofus.datacenter.sounds.SoundUiHook;
   import com.ankamagames.dofus.datacenter.appearance.SkinPosition;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.datacenter.monsters.CompanionCharacteristic;
   import com.ankamagames.dofus.datacenter.monsters.CompanionSpell;
   import com.ankamagames.dofus.datacenter.appearance.CreatureBoneOverride;
   import com.ankamagames.dofus.datacenter.appearance.CreatureBoneType;
   import com.ankamagames.dofus.datacenter.world.Phoenix;
   
   public class GameDataList extends Object
   {
      
      public function GameDataList() {
         super();
      }
      
      public static const server:Server = null;
      
      public static const serverCommunity:ServerCommunity = null;
      
      public static const serverGameType:ServerGameType = null;
      
      public static const serverPopulation:ServerPopulation = null;
      
      public static const monster:Monster = null;
      
      public static const monsterGrade:MonsterGrade = null;
      
      public static const monsterRace:MonsterRace = null;
      
      public static const monsterSuperRace:MonsterSuperRace = null;
      
      public static const monsterDrop:MonsterDrop = null;
      
      public static const notification:Notification = null;
      
      public static const spell:Spell = null;
      
      public static const effect:Effect = null;
      
      public static const effectInstance:EffectInstance = null;
      
      public static const spellLevel:SpellLevel = null;
      
      public static const spellType:SpellType = null;
      
      public static const spellState:SpellState = null;
      
      public static const breed:Breed = null;
      
      public static const head:Head = null;
      
      public static const superArea:SuperArea = null;
      
      public static const area:Area = null;
      
      public static const wolrdMap:WorldMap = null;
      
      public static const subArea:SubArea = null;
      
      public static const hint:Hint = null;
      
      public static const hintCategory:HintCategory = null;
      
      public static const mapPosition:MapPosition = null;
      
      public static const mapReference:MapReference = null;
      
      public static const mapScrollAction:MapScrollAction = null;
      
      public static const item:Item = null;
      
      public static const chatChannel:ChatChannel = null;
      
      public static const weapon:Weapon = null;
      
      public static const job:Job = null;
      
      public static const skill:Skill = null;
      
      public static const recipe:Recipe = null;
      
      public static const itemSet:ItemSet = null;
      
      public static const month:Month = null;
      
      public static const npc:Npc = null;
      
      public static const npcAction:NpcAction = null;
      
      public static const npcMessage:NpcMessage = null;
      
      public static const infoMessage:InfoMessage = null;
      
      public static const taxCollectorFirstname:TaxCollectorFirstname = null;
      
      public static const taxCollectorName:TaxCollectorName = null;
      
      public static const challenge:Challenge = null;
      
      public static const alignmentBalance:AlignmentBalance = null;
      
      public static const alignmentEffect:AlignmentEffect = null;
      
      public static const alignmentGift:AlignmentGift = null;
      
      public static const alignmentOrder:AlignmentOrder = null;
      
      public static const alignmentRank:AlignmentRank = null;
      
      public static const alignmentRankJntGift:AlignmentRankJntGift = null;
      
      public static const alignmentSide:AlignmentSide = null;
      
      public static const alignmentTitle:AlignmentTitle = null;
      
      public static const ambientSound:AmbientSound = null;
      
      public static const house:House = null;
      
      public static const rankName:RankName = null;
      
      public static const emblemBackground:EmblemBackground = null;
      
      public static const emblemSymbol:EmblemSymbol = null;
      
      public static const emblemSymbolCategory:EmblemSymbolCategory = null;
      
      public static const interactive:Interactive = null;
      
      public static const itemType:ItemType = null;
      
      public static const emoticon:Emoticon = null;
      
      public static const smiley:Smiley = null;
      
      public static const quest:Quest = null;
      
      public static const questCategory:QuestCategory = null;
      
      public static const questStep:QuestStep = null;
      
      public static const questStepRewards:QuestStepRewards = null;
      
      public static const questObjective:QuestObjective = null;
      
      public static const questObjectiveType:QuestObjectiveType = null;
      
      public static const questObjectiveBringItemToNpc:QuestObjectiveBringItemToNpc = null;
      
      public static const questObjectiveBringSoulToNpc:QuestObjectiveBringSoulToNpc = null;
      
      public static const questObjectiveDiscoverMap:QuestObjectiveDiscoverMap = null;
      
      public static const questObjectiveDiscoverSubArea:QuestObjectiveDiscoverSubArea = null;
      
      public static const questObjectiveDuelSpecificPlayer:QuestObjectiveDuelSpecificPlayer = null;
      
      public static const questObjectiveFightMonster:QuestObjectiveFightMonster = null;
      
      public static const questObjectiveFightMonstersOnMap:QuestObjectiveFightMonstersOnMap = null;
      
      public static const questObjectiveMultiFightMonster:QuestObjectiveMultiFightMonster = null;
      
      public static const questObjectiveFreeForm:QuestObjectiveFreeForm = null;
      
      public static const questObjectiveGoToNpc:QuestObjectiveGoToNpc = null;
      
      public static const achievement:Achievement = null;
      
      public static const achievementCategory:AchievementCategory = null;
      
      public static const achievementObjective:AchievementObjective = null;
      
      public static const achievementReward:AchievementReward = null;
      
      public static const pointOfInterest:PointOfInterest = null;
      
      public static const pointOfInterestCategory:PointOfInterestCategory = null;
      
      public static const mount:Mount = null;
      
      public static const mountBone:MountBone = null;
      
      public static const mountBehavior:MountBehavior = null;
      
      public static const mountRideFood:RideFood = null;
      
      public static const pet:Pet = null;
      
      public static const document:Document = null;
      
      public static const appearance:Appearance = null;
      
      public static const skinMapping:SkinMapping = null;
      
      public static const speakingItemsTrigger:SpeakingItemsTrigger = null;
      
      public static const speakingItemText:SpeakingItemText = null;
      
      public static const livingObjectSkinJntMood:LivingObjectSkinJntMood = null;
      
      public static const abuseReasons:AbuseReasons = null;
      
      public static const tips:Tips = null;
      
      public static const pack:Pack = null;
      
      public static const optionalFeature:OptionalFeature = null;
      
      public static const censoredWord:CensoredWord = null;
      
      public static const title:Title = null;
      
      public static const titleCategory:TitleCategory = null;
      
      public static const ornament:Ornament = null;
      
      public static const dungeon:Dungeon = null;
      
      public static const url:Url = null;
      
      public static const miniBoss:MonsterMiniBoss = null;
      
      public static const soundAnimation:SoundAnimation = null;
      
      public static const soundBones:SoundBones = null;
      
      public static const stealthBones:StealthBones = null;
      
      public static const typeAction:TypeAction = null;
      
      public static const externalNotification:ExternalNotification = null;
      
      public static const almanaxCalendar:AlmanaxCalendar = null;
      
      public static const soundUi:SoundUi = null;
      
      public static const soundUiElement:SoundUiElement = null;
      
      public static const soundUiHook:SoundUiHook = null;
      
      public static const skinPosition:SkinPosition = null;
      
      public static const companion:Companion = null;
      
      public static const companionCharacteristic:CompanionCharacteristic = null;
      
      public static const companionSpell:CompanionSpell = null;
      
      public static const creatureBoneOverride:CreatureBoneOverride = null;
      
      public static const creatureBoneType:CreatureBoneType = null;
      
      public static const phoenix:Phoenix = null;
   }
}
