package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.internalDatacenter.people.FriendWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.EnemyWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.IgnoredWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildFactSheetWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TaxCollectorsManager;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialFightersWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SocialApi extends Object implements IApi
   {
      
      public function SocialApi() {
         this._log = Log.getLogger(getQualifiedClassName(SocialApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      public function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get allianceFrame() : AllianceFrame {
         return Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getFriendsList() : Array {
         var friend:FriendWrapper = null;
         var fl:Array = new Array();
         var friendsList:Array = this.socialFrame.friendsList;
         for each (friend in friendsList)
         {
            fl.push(friend);
         }
         fl.sortOn("name",Array.CASEINSENSITIVE);
         return fl;
      }
      
      public function isFriend(playerName:String) : Boolean {
         var friend:* = undefined;
         var friendsList:Array = this.socialFrame.friendsList;
         for each (friend in friendsList)
         {
            if(friend.playerName == playerName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getEnemiesList() : Array {
         var enemy:EnemyWrapper = null;
         var el:Array = new Array();
         for each (enemy in this.socialFrame.enemiesList)
         {
            el.push(enemy);
         }
         el.sortOn("name",Array.CASEINSENSITIVE);
         return el;
      }
      
      public function isEnemy(playerName:String) : Boolean {
         var enemy:* = undefined;
         for each (enemy in this.socialFrame.enemiesList)
         {
            if(enemy.playerName == playerName)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getIgnoredList() : Array {
         var ignored:IgnoredWrapper = null;
         var il:Array = new Array();
         for each (ignored in this.socialFrame.ignoredList)
         {
            il.push(ignored);
         }
         il.sortOn("name",Array.CASEINSENSITIVE);
         return il;
      }
      
      public function isIgnored(name:String, accountId:int=0) : Boolean {
         return this.socialFrame.isIgnored(name,accountId);
      }
      
      public function getAccountName(name:String) : String {
         return name;
      }
      
      public function getWarnOnFriendConnec() : Boolean {
         return this.socialFrame.warnFriendConnec;
      }
      
      public function getWarnOnMemberConnec() : Boolean {
         return this.socialFrame.warnMemberConnec;
      }
      
      public function getWarnWhenFriendOrGuildMemberLvlUp() : Boolean {
         return this.socialFrame.warnWhenFriendOrGuildMemberLvlUp;
      }
      
      public function getWarnWhenFriendOrGuildMemberAchieve() : Boolean {
         return this.socialFrame.warnWhenFriendOrGuildMemberAchieve;
      }
      
      public function getSpouse() : SpouseWrapper {
         return this.socialFrame.spouse;
      }
      
      public function hasSpouse() : Boolean {
         return this.socialFrame.hasSpouse;
      }
      
      public function getAllowedGuildEmblemSymbolCategories() : int {
         var playerFrame:PlayedCharacterUpdatesFrame = Kernel.getWorker().getFrame(PlayedCharacterUpdatesFrame) as PlayedCharacterUpdatesFrame;
         return playerFrame.guildEmblemSymbolCategories;
      }
      
      public function hasGuild() : Boolean {
         return this.socialFrame.hasGuild;
      }
      
      public function getGuild() : GuildWrapper {
         return this.socialFrame.guild;
      }
      
      public function getGuildMembers() : Vector.<GuildMember> {
         return this.socialFrame.guildmembers;
      }
      
      public function getGuildRights() : Array {
         return GuildWrapper.guildRights;
      }
      
      public function getGuildByid(id:int) : GuildFactSheetWrapper {
         return this.socialFrame.getGuildById(id);
      }
      
      public function hasGuildRight(pPlayerId:uint, pRightId:String) : Boolean {
         var member:GuildMember = null;
         var temporaryWrapper:GuildWrapper = null;
         if(!this.socialFrame.hasGuild)
         {
            return false;
         }
         if(pPlayerId == PlayedCharacterManager.getInstance().id)
         {
            return this.socialFrame.guild.hasRight(pRightId);
         }
         for each (member in this.socialFrame.guildmembers)
         {
            if(member.id == pPlayerId)
            {
               temporaryWrapper = GuildWrapper.create(0,"",null,member.rights,true);
               return temporaryWrapper.hasRight(pRightId);
            }
         }
         return false;
      }
      
      public function getGuildHouses() : Object {
         return this.socialFrame.guildHouses;
      }
      
      public function guildHousesUpdateNeeded() : Boolean {
         return this.socialFrame.guildHousesUpdateNeeded;
      }
      
      public function getGuildPaddocks() : Object {
         return this.socialFrame.guildPaddocks;
      }
      
      public function getMaxGuildPaddocks() : int {
         return this.socialFrame.maxGuildPaddocks;
      }
      
      public function isGuildNameInvalid() : Boolean {
         if(this.socialFrame.guild)
         {
            return this.socialFrame.guild.realGuildName == "#NONAME#";
         }
         return false;
      }
      
      public function getMaxCollectorCount() : uint {
         return TaxCollectorsManager.getInstance().maxTaxCollectorsCount;
      }
      
      public function getTaxCollectors() : Dictionary {
         return TaxCollectorsManager.getInstance().taxCollectors;
      }
      
      public function getTaxCollector(id:int) : TaxCollectorWrapper {
         return TaxCollectorsManager.getInstance().taxCollectors[id];
      }
      
      public function getGuildFightingTaxCollectors() : Dictionary {
         return TaxCollectorsManager.getInstance().guildTaxCollectorsFighters;
      }
      
      public function getGuildFightingTaxCollector(pFightId:uint) : SocialEntityInFightWrapper {
         return TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pFightId];
      }
      
      public function getAllFightingTaxCollectors() : Dictionary {
         return TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight;
      }
      
      public function getAllFightingTaxCollector(pFightId:uint) : SocialEntityInFightWrapper {
         return TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[pFightId];
      }
      
      public function isPlayerDefender(pType:int, pPlayerId:uint, pSocialFightId:int) : Boolean {
         var seifw:SocialEntityInFightWrapper = null;
         var defender:SocialFightersWrapper = null;
         if(pType == 0)
         {
            seifw = TaxCollectorsManager.getInstance().guildTaxCollectorsFighters[pSocialFightId];
            if(!seifw)
            {
               seifw = TaxCollectorsManager.getInstance().allTaxCollectorsInPreFight[pSocialFightId];
            }
         }
         else
         {
            if(pType == 1)
            {
               seifw = TaxCollectorsManager.getInstance().prismsFighters[pSocialFightId];
            }
         }
         if(seifw)
         {
            for each (defender in seifw.allyCharactersInformations)
            {
               if(defender.playerCharactersInformations.id == pPlayerId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function hasAlliance() : Boolean {
         return this.allianceFrame.hasAlliance;
      }
      
      public function getAlliance() : AllianceWrapper {
         return this.allianceFrame.alliance;
      }
      
      public function getAllianceById(id:int) : AllianceWrapper {
         return this.allianceFrame.getAllianceById(id);
      }
      
      public function getAllianceGuilds() : Vector.<GuildFactSheetWrapper> {
         return this.allianceFrame.alliance.guilds;
      }
      
      public function isAllianceNameInvalid() : Boolean {
         if(this.allianceFrame.alliance)
         {
            return this.allianceFrame.alliance.realAllianceName == "#NONAME#";
         }
         return false;
      }
      
      public function isAllianceTagInvalid() : Boolean {
         if(this.allianceFrame.alliance)
         {
            return this.allianceFrame.alliance.realAllianceTag == "#TAG#";
         }
         return false;
      }
      
      public function getPrismSubAreaById(id:int) : PrismSubAreaWrapper {
         return this.allianceFrame.getPrismSubAreaById(id);
      }
      
      public function getFightingPrisms() : Dictionary {
         return TaxCollectorsManager.getInstance().prismsFighters;
      }
      
      public function getFightingPrism(pFightId:uint) : SocialEntityInFightWrapper {
         return TaxCollectorsManager.getInstance().prismsFighters[pFightId];
      }
      
      public function isPlayerPrismDefender(pPlayerId:uint, pSubAreaId:int) : Boolean {
         var defender:SocialFightersWrapper = null;
         var p:SocialEntityInFightWrapper = TaxCollectorsManager.getInstance().prismsFighters[pSubAreaId];
         if(p)
         {
            for each (defender in p.allyCharactersInformations)
            {
               if(defender.playerCharactersInformations.id == pPlayerId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getChatSentence(timestamp:Number, fingerprint:String) : BasicChatSentence {
         var channel:Array = null;
         var sentence:BasicChatSentence = null;
         var found:Boolean = false;
         var se:BasicChatSentence = null;
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         for each (channel in chatFrame.getMessages())
         {
            for each (sentence in channel)
            {
               if((sentence.fingerprint == fingerprint) && (sentence.timestamp == timestamp))
               {
                  se = sentence;
                  found = true;
                  break;
               }
            }
            if(found)
            {
               break;
            }
         }
         return se;
      }
   }
}
