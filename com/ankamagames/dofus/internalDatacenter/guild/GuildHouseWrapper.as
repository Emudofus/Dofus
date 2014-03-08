package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.dofus.datacenter.houses.House;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.jerakine.data.I18n;
   
   public class GuildHouseWrapper extends Object implements IDataCenter
   {
      
      public function GuildHouseWrapper() {
         this._arrayShareParams = new Array();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildHouseWrapper));
      
      public static function create(param1:HouseInformationsForGuild) : GuildHouseWrapper {
         var _loc2_:GuildHouseWrapper = new GuildHouseWrapper();
         var _loc3_:House = House.getGuildHouseById(param1.modelId);
         _loc2_.houseId = param1.houseId;
         _loc2_.houseName = _loc3_.name;
         _loc2_.description = _loc3_.description;
         _loc2_.ownerName = param1.ownerName;
         _loc2_.gfxId = _loc3_.gfxId;
         _loc2_.skillListIds = param1.skillListIds;
         _loc2_.worldX = param1.worldX;
         _loc2_.worldY = param1.worldY;
         _loc2_.subareaId = param1.subAreaId;
         _loc2_.guildshareParams = param1.guildshareParams;
         return _loc2_;
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
         var _loc2_:* = 0;
         var _loc1_:Vector.<String> = new Vector.<String>();
         for each (_loc2_ in this.skillListIds)
         {
            _loc1_.push(Skill.getSkillById(_loc2_).name);
         }
         return _loc1_;
      }
      
      public function get guildshareString() : Vector.<String> {
         this._arrayShareParams = [this.visibleGuildBrief,this.doorSignGuild,this.doorSignOthers,this.allowDoorGuild,this.forbiDoorOthers,this.allowChestOthers,this.forbidChestOthers,this.teleport,this.respawn];
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc2_:uint = 1;
         var _loc3_:uint = 0;
         while(_loc3_ <= 8)
         {
            if(this._arrayShareParams[_loc3_])
            {
               _loc1_.push(I18n.getUiText("ui.guildHouse.Right" + _loc2_));
            }
            _loc2_ = _loc2_ * 2;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function update(param1:HouseInformationsForGuild) : void {
         var _loc2_:House = House.getGuildHouseById(param1.modelId);
         this.houseId = param1.houseId;
         this.houseName = _loc2_.name;
         this.description = _loc2_.description;
         this.gfxId = _loc2_.gfxId;
         this.ownerName = param1.ownerName;
         this.skillListIds = param1.skillListIds;
         this.worldX = param1.worldX;
         this.worldY = param1.worldY;
         this.subareaId = param1.subAreaId;
         this.guildshareParams = param1.guildshareParams;
      }
   }
}
