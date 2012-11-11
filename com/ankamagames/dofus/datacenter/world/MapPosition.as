package com.ankamagames.dofus.datacenter.world
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class MapPosition extends Object implements IDataCenter
    {
        public var id:int;
        public var posX:int;
        public var posY:int;
        public var outdoor:Boolean;
        public var capabilities:int;
        public var nameId:int;
        public var sounds:Vector.<AmbientSound>;
        public var subAreaId:int;
        public var worldMap:int;
        public var hasPriorityOnWorldmap:Boolean;
        private var _name:String;
        private var _subArea:SubArea;
        private static const MODULE:String = "MapPositions";
        private static const DST:DataStoreType = new DataStoreType(MODULE, true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        private static const CAPABILITY_ALLOW_CHALLENGE:int = 1;
        private static const CAPABILITY_ALLOW_AGGRESSION:int = 2;
        private static const CAPABILITY_ALLOW_TELEPORT_TO:int = 4;
        private static const CAPABILITY_ALLOW_TELEPORT_FROM:int = 8;
        private static const CAPABILITY_ALLOW_EXCHANGES_BETWEEN_PLAYERS:int = 16;
        private static const CAPABILITY_ALLOW_HUMAN_VENDOR:int = 32;
        private static const CAPABILITY_ALLOW_COLLECTOR:int = 64;
        private static const CAPABILITY_ALLOW_SOUL_CAPTURE:int = 128;
        private static const CAPABILITY_ALLOW_SOUL_SUMMON:int = 256;
        private static const CAPABILITY_ALLOW_TAVERN_REGEN:int = 512;
        private static const CAPABILITY_ALLOW_TOMB_MODE:int = 1024;
        private static const CAPABILITY_ALLOW_TELEPORT_EVERYWHERE:int = 2048;
        private static const CAPABILITY_ALLOW_FIGHT_CHALLENGES:int = 4096;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(MapPosition));

        public function MapPosition()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get subArea() : SubArea
        {
            if (!this._subArea)
            {
                this._subArea = SubArea.getSubAreaById(this.subAreaId);
            }
            return this._subArea;
        }// end function

        public function get allowChallenge() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_CHALLENGE) != 0;
        }// end function

        public function get allowAggression() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_AGGRESSION) != 0;
        }// end function

        public function get allowTeleportTo() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_TO) != 0;
        }// end function

        public function get allowTeleportFrom() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_FROM) != 0;
        }// end function

        public function get allowExchanges() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_EXCHANGES_BETWEEN_PLAYERS) != 0;
        }// end function

        public function get allowHumanVendor() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_HUMAN_VENDOR) != 0;
        }// end function

        public function get allowTaxCollector() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_COLLECTOR) != 0;
        }// end function

        public function get allowSoulCapture() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_SOUL_CAPTURE) != 0;
        }// end function

        public function get allowSoulSummon() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_SOUL_SUMMON) != 0;
        }// end function

        public function get allowTavernRegen() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_TAVERN_REGEN) != 0;
        }// end function

        public function get allowTombMode() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_TOMB_MODE) != 0;
        }// end function

        public function get allowTeleportEverywhere() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_TELEPORT_EVERYWHERE) != 0;
        }// end function

        public function get allowFightChallenges() : Boolean
        {
            return (this.capabilities & CAPABILITY_ALLOW_FIGHT_CHALLENGES) != 0;
        }// end function

        public static function getMapPositionById(param1:int) : MapPosition
        {
            return GameData.getObject(MODULE, param1) as MapPosition;
        }// end function

        public static function getMapPositions() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

        public static function getMapIdByCoord(param1:int, param2:int) : Vector.<int>
        {
            var _loc_3:* = MapCoordinates.getMapCoordinatesByCoords(param1, param2);
            if (_loc_3)
            {
                return _loc_3.mapIds;
            }
            return null;
        }// end function

    }
}
