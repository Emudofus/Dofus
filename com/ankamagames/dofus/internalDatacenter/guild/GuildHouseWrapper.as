package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.jerakine.data.I18n;
   
   public class GuildHouseWrapper extends Object implements IDataCenter
   {
      
      public function GuildHouseWrapper() {
         this._arrayShareParams = new Array();
         super();
      }
      
      protected static const _log:Logger;
      
      public static function create(pHouseInformationsForGuild:HouseInformationsForGuild) : GuildHouseWrapper {
         var item:GuildHouseWrapper = new GuildHouseWrapper();
         var houseInfo:House = House.getGuildHouseById(pHouseInformationsForGuild.modelId);
         item.houseId = pHouseInformationsForGuild.houseId;
         item.houseName = houseInfo.name;
         item.description = houseInfo.description;
         item.ownerName = pHouseInformationsForGuild.ownerName;
         item.gfxId = houseInfo.gfxId;
         item.skillListIds = pHouseInformationsForGuild.skillListIds;
         item.worldX = pHouseInformationsForGuild.worldX;
         item.worldY = pHouseInformationsForGuild.worldY;
         item.subareaId = pHouseInformationsForGuild.subAreaId;
         item.guildshareParams = pHouseInformationsForGuild.guildshareParams;
         return item;
      }
      
      public var houseId:int;
      
      public var gfxId:int;
      
      public var houseName:String;
      
      public var description:String;
      
      public var ownerName:String;
      
      public var skillListIds:Vector.<int>;
      
      public var worldX:int;
      
      public var worldY:int;
      
      public var subareaId:int;
      
      public var guildshareParams:uint;
      
      private var _arrayShareParams:Array;
      
      public function get visibleGuildBrief() : Boolean {
         return Boolean(1 & this.guildshareParams >> 0);
      }
      
      public function get doorSignGuild() : Boolean {
         return Boolean(1 & this.guildshareParams >> 1);
      }
      
      public function get doorSignOthers() : Boolean {
         return Boolean(1 & this.guildshareParams >> 2);
      }
      
      public function get allowDoorGuild() : Boolean {
         return Boolean(1 & this.guildshareParams >> 3);
      }
      
      public function get forbiDoorOthers() : Boolean {
         return Boolean(1 & this.guildshareParams >> 4);
      }
      
      public function get allowChestOthers() : Boolean {
         return Boolean(1 & this.guildshareParams >> 5);
      }
      
      public function get forbidChestOthers() : Boolean {
         return Boolean(1 & this.guildshareParams >> 6);
      }
      
      public function get teleport() : Boolean {
         return Boolean(1 & this.guildshareParams >> 7);
      }
      
      public function get respawn() : Boolean {
         return Boolean(1 & this.guildshareParams >> 8);
      }
      
      public function get skillListString() : Vector.<String> {
         var id:* = 0;
         var sls:Vector.<String> = new Vector.<String>();
         for each(id in this.skillListIds)
         {
            sls.push(Skill.getSkillById(id).name);
         }
         return sls;
      }
      
      public function get guildshareString() : Vector.<String> {
         this._arrayShareParams = [this.visibleGuildBrief,this.doorSignGuild,this.doorSignOthers,this.allowDoorGuild,this.forbiDoorOthers,this.allowChestOthers,this.forbidChestOthers,this.teleport,this.respawn];
         var gss:Vector.<String> = new Vector.<String>();
         var bit:uint = 1;
         var id:uint = 0;
         while(id <= 8)
         {
            if(this._arrayShareParams[id])
            {
               gss.push(I18n.getUiText("ui.guildHouse.Right" + bit));
            }
            bit = bit * 2;
            id++;
         }
         return gss;
      }
      
      public function update(pHouseInformationsForGuild:HouseInformationsForGuild) : void {
         var houseInfo:House = House.getGuildHouseById(pHouseInformationsForGuild.modelId);
         this.houseId = pHouseInformationsForGuild.houseId;
         this.houseName = houseInfo.name;
         this.description = houseInfo.description;
         this.gfxId = houseInfo.gfxId;
         this.ownerName = pHouseInformationsForGuild.ownerName;
         this.skillListIds = pHouseInformationsForGuild.skillListIds;
         this.worldX = pHouseInformationsForGuild.worldX;
         this.worldY = pHouseInformationsForGuild.worldY;
         this.subareaId = pHouseInformationsForGuild.subAreaId;
         this.guildshareParams = pHouseInformationsForGuild.guildshareParams;
      }
   }
}
