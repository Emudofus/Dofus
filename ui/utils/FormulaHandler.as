package utils
{
   public class FormulaHandler extends Object
   {
      
      public function FormulaHandler() {
         super();
         this.clearData();
      }
      
      private static var _self:FormulaHandler;
      
      private static const XP_GROUP:Array;
      
      public static function getInstance() : FormulaHandler {
         if(_self == null)
         {
            _self = new FormulaHandler();
         }
         return _self;
      }
      
      public static function createMonsterData(pLevel:int, pXp:int) : MonsterData {
         return new MonsterData(pLevel,pXp);
      }
      
      public static function createGroupMember(pLevel:int, pIsCompanion:Boolean = false) : GroupMemberData {
         return new GroupMemberData(pLevel,pIsCompanion);
      }
      
      public static function createPlayerData(pLevel:int, pWisdom:int = 0, pXpBonus:Number = 0, pXpMount:Number = 0, pXpGuild:Number = 0, pXpAlliancePrismBonus:Number = 0) : PlayerData {
         return new PlayerData(pLevel,pWisdom,pXpBonus,pXpMount,pXpGuild,pXpAlliancePrismBonus);
      }
      
      public static function getArenaMalusDrop(pLootShare:int, pMembers:int) : int {
         var malus:int = Math.round(100 - pLootShare / pMembers * 100);
         return malus < 0?0:malus;
      }
      
      private var _xpSolo:Number;
      
      private var _xpGroup:Number;
      
      private function clearData() : void {
         this._xpSolo = 0;
         this._xpGroup = 0;
      }
      
      public function initXpFormula(pPlayerData:PlayerData, pMonstersList:Array, pMembersList:Array, pStartBonus:int = 0) : void {
         var mob:MonsterData = null;
         var lvlPlayers:uint = 0;
         var lvlMaxGroup:uint = 0;
         var totalPlayerForBonusGroup:uint = 0;
         var member:GroupMemberData = null;
         var coeffDiffLvlGroup:* = NaN;
         var ratioXpMontureSolo:* = NaN;
         var ratioXpMontureGroup:* = NaN;
         var ratioXpGuildSolo:* = NaN;
         var ratioXpGuildGroup:* = NaN;
         var xpAlliancePrismBonus:* = NaN;
         this.clearData();
         var xpBase:uint = 0;
         var maxLvlMonster:uint = 0;
         var lvlMonsters:uint = 0;
         for each(mob in pMonstersList)
         {
            xpBase = xpBase + mob.xp;
            lvlMonsters = lvlMonsters + mob.level;
            if(mob.level > maxLvlMonster)
            {
               maxLvlMonster = mob.level;
            }
         }
         lvlPlayers = 0;
         lvlMaxGroup = 0;
         totalPlayerForBonusGroup = 0;
         for each(member in pMembersList)
         {
            lvlPlayers = lvlPlayers + member.level;
            if(member.level > lvlMaxGroup)
            {
               lvlMaxGroup = member.level;
            }
         }
         for each(member in pMembersList)
         {
            if((!member.companion) && (member.level >= lvlMaxGroup / 3))
            {
               totalPlayerForBonusGroup++;
            }
         }
         coeffDiffLvlGroup = 1;
         if(lvlPlayers - 5 > lvlMonsters)
         {
            coeffDiffLvlGroup = lvlMonsters / lvlPlayers;
         }
         else if(lvlPlayers + 10 < lvlMonsters)
         {
            coeffDiffLvlGroup = (lvlPlayers + 10) / lvlMonsters;
         }
         
         var coeffDiffLvlSolo:Number = 1;
         if(pPlayerData.level - 5 > lvlMonsters)
         {
            coeffDiffLvlSolo = lvlMonsters / pPlayerData.level;
         }
         else if(pPlayerData.level + 10 < lvlMonsters)
         {
            coeffDiffLvlSolo = (pPlayerData.level + 10) / lvlMonsters;
         }
         
         var v:uint = Math.min(pPlayerData.level,this.truncate(2.5 * maxLvlMonster));
         var xpLimitMaxLvlSolo:Number = v / pPlayerData.level * 100;
         var xpLimitMaxLvlGroup:Number = v / lvlPlayers * 100;
         var xpGroupAlone:uint = this.truncate(xpBase * XP_GROUP[0] * coeffDiffLvlSolo);
         if(totalPlayerForBonusGroup == 0)
         {
            totalPlayerForBonusGroup = 1;
         }
         var xpGroup:uint = this.truncate(xpBase * XP_GROUP[totalPlayerForBonusGroup - 1] * coeffDiffLvlGroup);
         var xpNoSagesseAlone:uint = this.truncate(xpLimitMaxLvlSolo / 100 * xpGroupAlone);
         var xpNoSagesseGroup:uint = this.truncate(xpLimitMaxLvlGroup / 100 * xpGroup);
         var reelStarBonus:Number = pStartBonus <= 0?1:1 + pStartBonus / 100;
         var xpTotalOnePlayer:uint = this.truncate(this.truncate(xpNoSagesseAlone * (100 + pPlayerData.wisdom) / 100) * reelStarBonus);
         var xpTotalGroup:uint = this.truncate(this.truncate(xpNoSagesseGroup * (100 + pPlayerData.wisdom) / 100) * reelStarBonus);
         var xpBonus:Number = 1 + pPlayerData.xpBonusPercent / 100;
         var tmpSolo:Number = xpTotalOnePlayer;
         var tmpGroup:Number = xpTotalGroup;
         if(pPlayerData.xpRatioMount > 0)
         {
            ratioXpMontureSolo = tmpSolo * pPlayerData.xpRatioMount / 100;
            ratioXpMontureGroup = tmpGroup * pPlayerData.xpRatioMount / 100;
            tmpSolo = this.truncate(tmpSolo - ratioXpMontureSolo);
            tmpGroup = this.truncate(tmpGroup - ratioXpMontureGroup);
         }
         tmpSolo = tmpSolo * xpBonus;
         tmpGroup = tmpGroup * xpBonus;
         if(pPlayerData.xpGuildGivenPercent > 0)
         {
            ratioXpGuildSolo = tmpSolo * pPlayerData.xpGuildGivenPercent / 100;
            ratioXpGuildGroup = tmpGroup * pPlayerData.xpGuildGivenPercent / 100;
            tmpSolo = tmpSolo - ratioXpGuildSolo;
            tmpGroup = tmpGroup - ratioXpGuildGroup;
         }
         if(pPlayerData.xpAlliancePrismBonusPercent > 0)
         {
            xpAlliancePrismBonus = 1 + pPlayerData.xpAlliancePrismBonusPercent / 100;
            tmpSolo = tmpSolo * xpAlliancePrismBonus;
            tmpGroup = tmpGroup * xpAlliancePrismBonus;
         }
         xpTotalOnePlayer = this.truncate(tmpSolo);
         xpTotalGroup = this.truncate(tmpGroup);
         this._xpSolo = xpTotalOnePlayer;
         this._xpGroup = xpTotalGroup;
      }
      
      private function truncate(val:Number) : int {
         var multiplier:uint = Math.pow(10,0);
         var truncatedVal:Number = val * multiplier;
         return int(truncatedVal) / multiplier;
      }
      
      public function get xpSolo() : Number {
         return this._xpSolo;
      }
      
      public function get xpGroup() : Number {
         return this._xpGroup;
      }
   }
}
class MonsterData extends Object
{
   
   function MonsterData(pLevel:int, pXp:int) {
      super();
      this.xp = pXp;
      this.level = pLevel;
   }
   
   public var xp:int;
   
   public var level:int;
}
class GroupMemberData extends Object
{
   
   function GroupMemberData(pLevel:int, pIsCompanion:Boolean) {
      super();
      this.level = pLevel;
      this.companion = pIsCompanion;
   }
   
   public var level:int;
   
   public var companion:Boolean;
}
class PlayerData extends Object
{
   
   function PlayerData(pLevel:int, pWisdom:int = 0, pXpBonus:Number = 0, pXpMount:Number = 0, pXpGuild:Number = 0, pXpAlliancePrismBonus:Number = 0) {
      super();
      this.level = pLevel;
      this.wisdom = pWisdom;
      this.xpBonusPercent = pXpBonus;
      this.xpRatioMount = pXpMount;
      this.xpGuildGivenPercent = pXpGuild;
      this.xpAlliancePrismBonusPercent = pXpAlliancePrismBonus;
   }
   
   public var level:int;
   
   public var wisdom:int;
   
   public var xpBonusPercent:Number;
   
   public var xpRatioMount:Number;
   
   public var xpGuildGivenPercent:Number;
   
   public var xpAlliancePrismBonusPercent:Number;
}
