package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceVersatileInformations;
   import com.ankamagames.dofus.network.messages.game.alliance.AllianceFactsMessage;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.network.enums.AllianceRightsBitEnum;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AllianceWrapper extends Object implements IDataCenter
   {
      
      public function AllianceWrapper() {
         this.guilds = new Vector.<GuildFactSheetWrapper>();
         this.prismIds = new Vector.<uint>();
         super();
      }
      
      public static const IS_BOSS:String = "isBoss";
      
      public static const allianceRights:Array;
      
      public static var _rightDictionnary:Dictionary;
      
      private static var _ref:Dictionary;
      
      public static function getAllianceById(id:int) : AllianceWrapper {
         return _ref[id];
      }
      
      public static function clearCache() : void {
         _ref = new Dictionary();
         GuildWrapper.clearCache();
      }
      
      public static function getFromNetwork(o:*) : AllianceWrapper {
         if(o is BasicAllianceInformations)
         {
            return getFromBasicAllianceInformations(BasicAllianceInformations(o));
         }
         if(o is AllianceVersatileInformations)
         {
            return getFromAllianceVersatileInformations(AllianceVersatileInformations(o));
         }
         if(o is AllianceFactsMessage)
         {
            return getFromAllianceFactsMessage(AllianceFactsMessage(o));
         }
         return null;
      }
      
      public static function updateRef(pAllianceId:uint, pAllianceWrapper:AllianceWrapper) : void {
         _ref[pAllianceId] = pAllianceWrapper;
      }
      
      private static function getFromAllianceFactsMessage(o:AllianceFactsMessage) : AllianceWrapper {
         var aw:AllianceWrapper = getFromBasicAllianceInformations(o.infos);
         if((o.guilds) && (o.guilds.length > 0))
         {
            aw.leaderGuildId = o.guilds[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && (SocialFrame.getInstance().guild.guildId == o.guilds[0].guildId) && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               aw._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         aw.nbGuilds = o.guilds.length;
         aw.nbMembers = 0;
         aw.enabled = false;
         aw.guilds.length = 0;
         var i:uint = 0;
         while(i < o.guilds.length)
         {
            aw.nbMembers = aw.nbMembers + o.guilds[i].nbMembers;
            aw.enabled = (aw.enabled) || (o.guilds[i].enabled);
            i++;
         }
         return aw;
      }
      
      private static function getFromAllianceVersatileInformations(o:AllianceVersatileInformations) : AllianceWrapper {
         var aw:AllianceWrapper = null;
         if(_ref[o.allianceId])
         {
            aw = _ref[o.allianceId];
         }
         else
         {
            aw = new AllianceWrapper();
            _ref[o.allianceId] = aw;
         }
         aw.allianceId = o.allianceId;
         aw.nbMembers = o.nbMembers;
         aw.nbGuilds = o.nbGuilds;
         aw.nbSubareas = o.nbSubarea;
         return aw;
      }
      
      private static function getFromBasicAllianceInformations(o:BasicAllianceInformations) : AllianceWrapper {
         var aw:AllianceWrapper = null;
         var emblem:GuildEmblem = null;
         if(_ref[o.allianceId])
         {
            aw = _ref[o.allianceId];
         }
         else
         {
            aw = new AllianceWrapper();
            _ref[o.allianceId] = aw;
         }
         aw.allianceId = o.allianceId;
         aw._allianceTag = o.allianceTag;
         if(o is BasicNamedAllianceInformations)
         {
            aw._allianceName = BasicNamedAllianceInformations(o).allianceName;
         }
         if(o is AllianceInformations)
         {
            emblem = AllianceInformations(o).allianceEmblem;
            aw.upEmblem = EmblemWrapper.fromNetwork(emblem,false);
            aw.backEmblem = EmblemWrapper.fromNetwork(emblem,true);
         }
         if(o is AllianceFactSheetInformations)
         {
            aw.creationDate = AllianceFactSheetInformations(o).creationDate;
         }
         return aw;
      }
      
      public static function create(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, creationDate:Number = 0, nbGuilds:uint = 0, nbMembers:uint = 0, guilds:Vector.<GuildFactSheetWrapper> = null, prismIds:Vector.<uint> = null) : AllianceWrapper {
         var item:AllianceWrapper = null;
         var g:GuildFactSheetWrapper = null;
         item = new AllianceWrapper();
         item.allianceId = pAllianceId;
         item._allianceTag = pAllianceTag;
         item._allianceName = pAllianceName;
         if(pAllianceEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         }
         item.creationDate = creationDate;
         item.nbGuilds = nbGuilds;
         item.nbMembers = nbMembers;
         item.guilds = guilds;
         if((guilds) && (guilds.length > 0))
         {
            item.leaderGuildId = guilds[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && (SocialFrame.getInstance().guild.guildId == guilds[0].guildId) && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               item._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(prismIds)
         {
            item.prismIds = prismIds;
         }
         item.enabled = false;
         for each(g in guilds)
         {
            if(g.enabled)
            {
               item.enabled = true;
               break;
            }
         }
         return item;
      }
      
      public static function getRightsNumber(pRightsIDs:Array) : Number {
         var right:String = null;
         var wantToSet:* = false;
         var pRight:String = null;
         var rightNumber:Number = 0;
         for each(right in allianceRights)
         {
            wantToSet = false;
            for each(pRight in pRightsIDs)
            {
               if(pRight == right)
               {
                  rightNumber = rightNumber | 1 << _rightDictionnary[pRight];
               }
            }
         }
         return rightNumber;
      }
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var allianceId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var enabled:Boolean;
      
      public var creationDate:uint;
      
      public var nbGuilds:uint = 0;
      
      public var nbMembers:uint = 0;
      
      public var nbSubareas:uint = 0;
      
      public var leaderGuildId:uint = 0;
      
      public var guilds:Vector.<GuildFactSheetWrapper>;
      
      public var prismIds:Vector.<uint>;
      
      private var _memberRightsNumber:uint;
      
      public function get allianceTag() : String {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get realAllianceTag() : String {
         return this._allianceTag;
      }
      
      public function get allianceName() : String {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get realAllianceName() : String {
         return this._allianceName;
      }
      
      public function set memberRightsNumber(value:uint) : void {
         this._memberRightsNumber = value;
      }
      
      public function get memberRightsNumber() : uint {
         return this._memberRightsNumber;
      }
      
      public function get memberRights() : Vector.<Boolean> {
         var rights:Vector.<Boolean> = new Vector.<Boolean>();
         rights.push(this.isBoss);
         return rights;
      }
      
      public function get isBoss() : Boolean {
         return (1 & this._memberRightsNumber) > 0;
      }
      
      public function clone() : AllianceWrapper {
         var wrapper:AllianceWrapper = create(this.allianceId,this.allianceTag,this.allianceName,null,this.creationDate,this.nbGuilds,this.nbMembers,this.guilds,this.prismIds);
         wrapper.upEmblem = this.upEmblem;
         wrapper.backEmblem = this.backEmblem;
         return wrapper;
      }
      
      public function update(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, creationDate:Number = 0, nbGuilds:uint = 0, nbMembers:uint = 0, guilds:Vector.<GuildFactSheetWrapper> = null, prismIds:Vector.<uint> = null) : void {
         var g:GuildFactSheetWrapper = null;
         this.allianceId = pAllianceId;
         this._allianceTag = pAllianceTag;
         this._allianceName = pAllianceName;
         this.upEmblem.update(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
         this.backEmblem.update(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         this.creationDate = creationDate;
         this.nbGuilds = nbGuilds;
         this.nbMembers = nbMembers;
         this.guilds = guilds;
         if((guilds) && (guilds.length > 0))
         {
            this.leaderGuildId = guilds[0].guildId;
            if((SocialFrame.getInstance().hasGuild) && (SocialFrame.getInstance().guild.guildId == guilds[0].guildId) && (SocialFrame.getInstance().guild.hasRight("isBoss")))
            {
               this._memberRightsNumber = AllianceRightsBitEnum.ALLIANCE_RIGHT_BOSS;
            }
         }
         if(prismIds)
         {
            this.prismIds = prismIds;
         }
         this.enabled = false;
         for each(g in guilds)
         {
            if(g.enabled)
            {
               this.enabled = true;
               break;
            }
         }
      }
      
      public function hasRight(pRightId:String) : Boolean {
         var returnValue:Boolean = false;
         switch(pRightId)
         {
            case IS_BOSS:
               returnValue = this.isBoss;
               break;
         }
         return returnValue;
      }
      
      private function initDictionary() : void {
         _rightDictionnary[IS_BOSS] = 0;
      }
   }
}
