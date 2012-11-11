package com.ankamagames.dofus.internalDatacenter.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.houses.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class GuildHouseWrapper extends Object implements IDataCenter
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildHouseWrapper));

        public function GuildHouseWrapper()
        {
            this._arrayShareParams = new Array();
            return;
        }// end function

        public function get visibleGuildBrief() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 0);
        }// end function

        public function get doorSignGuild() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 1);
        }// end function

        public function get doorSignOthers() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 2);
        }// end function

        public function get allowDoorGuild() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 3);
        }// end function

        public function get forbiDoorOthers() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 4);
        }// end function

        public function get allowChestOthers() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 5);
        }// end function

        public function get forbidChestOthers() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 6);
        }// end function

        public function get teleport() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 7);
        }// end function

        public function get respawn() : Boolean
        {
            return Boolean(1 & this.guildshareParams >> 8);
        }// end function

        public function get skillListString() : Vector.<String>
        {
            var _loc_2:* = 0;
            var _loc_1:* = new Vector.<String>;
            for each (_loc_2 in this.skillListIds)
            {
                
                _loc_1.push(Skill.getSkillById(_loc_2).name);
            }
            return _loc_1;
        }// end function

        public function get guildshareString() : Vector.<String>
        {
            this._arrayShareParams = [this.visibleGuildBrief, this.doorSignGuild, this.doorSignOthers, this.allowDoorGuild, this.forbiDoorOthers, this.allowChestOthers, this.forbidChestOthers, this.teleport, this.respawn];
            var _loc_1:* = new Vector.<String>;
            var _loc_2:* = 1;
            var _loc_3:* = 0;
            while (_loc_3 <= 8)
            {
                
                if (this._arrayShareParams[_loc_3])
                {
                    _loc_1.push(I18n.getUiText("ui.guildHouse.Right" + _loc_2));
                }
                _loc_2 = _loc_2 * 2;
                _loc_3 = _loc_3 + 1;
            }
            return _loc_1;
        }// end function

        public function update(param1:HouseInformationsForGuild) : void
        {
            var _loc_2:* = House.getGuildHouseById(param1.modelId);
            this.houseId = param1.houseId;
            this.houseName = _loc_2.name;
            this.description = _loc_2.description;
            this.gfxId = _loc_2.gfxId;
            this.ownerName = param1.ownerName;
            this.skillListIds = param1.skillListIds;
            this.worldX = param1.worldX;
            this.worldY = param1.worldY;
            this.subareaId = param1.subAreaId;
            this.guildshareParams = param1.guildshareParams;
            return;
        }// end function

        public static function create(param1:HouseInformationsForGuild) : GuildHouseWrapper
        {
            var _loc_2:* = new GuildHouseWrapper;
            var _loc_3:* = House.getGuildHouseById(param1.modelId);
            _loc_2.houseId = param1.houseId;
            _loc_2.houseName = _loc_3.name;
            _loc_2.description = _loc_3.description;
            _loc_2.ownerName = param1.ownerName;
            _loc_2.gfxId = _loc_3.gfxId;
            _loc_2.skillListIds = param1.skillListIds;
            _loc_2.worldX = param1.worldX;
            _loc_2.worldY = param1.worldY;
            _loc_2.subareaId = param1.subAreaId;
            _loc_2.guildshareParams = param1.guildshareParams;
            return _loc_2;
        }// end function

    }
}
