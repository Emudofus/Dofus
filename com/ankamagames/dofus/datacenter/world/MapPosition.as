package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.ambientSounds.AmbientSound;
   import com.ankamagames.jerakine.data.I18n;
   
   public class MapPosition extends Object implements IDataCenter
   {
      
      public function MapPosition() {
         super();
      }
      
      public static const MODULE:String = "MapPositions";
      
      private static const DST:DataStoreType;
      
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
      
      protected static const _log:Logger;
      
      private static var _mapPositions:Dictionary;
      
      public static function getMapPositionById(id:int) : MapPosition {
         var mapPositions:Array = null;
         var mapPos:MapPosition = null;
         if(!_mapPositions)
         {
            _mapPositions = new Dictionary();
            mapPositions = getMapPositions();
            for each(_mapPositions[mapPos.id] in mapPositions)
            {
            }
         }
         return _mapPositions[id];
      }
      
      public static function getMapPositions() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public static function getMapIdByCoord(x:int, y:int) : Vector.<int> {
         var mc:MapCoordinates = MapCoordinates.getMapCoordinatesByCoords(x,y);
         if(mc)
         {
            return mc.mapIds;
         }
         return null;
      }
      
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
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get subArea() : SubArea {
         if(!this._subArea)
         {
            this._subArea = SubArea.getSubAreaById(this.subAreaId);
         }
         return this._subArea;
      }
      
      public function get allowChallenge() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_CHALLENGE) == 0);
      }
      
      public function get allowAggression() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_AGGRESSION) == 0);
      }
      
      public function get allowTeleportTo() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_TELEPORT_TO) == 0);
      }
      
      public function get allowTeleportFrom() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_TELEPORT_FROM) == 0);
      }
      
      public function get allowExchanges() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_EXCHANGES_BETWEEN_PLAYERS) == 0);
      }
      
      public function get allowHumanVendor() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_HUMAN_VENDOR) == 0);
      }
      
      public function get allowTaxCollector() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_COLLECTOR) == 0);
      }
      
      public function get allowSoulCapture() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_SOUL_CAPTURE) == 0);
      }
      
      public function get allowSoulSummon() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_SOUL_SUMMON) == 0);
      }
      
      public function get allowTavernRegen() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_TAVERN_REGEN) == 0);
      }
      
      public function get allowTombMode() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_TOMB_MODE) == 0);
      }
      
      public function get allowTeleportEverywhere() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_TELEPORT_EVERYWHERE) == 0);
      }
      
      public function get allowFightChallenges() : Boolean {
         return !((this.capabilities & CAPABILITY_ALLOW_FIGHT_CHALLENGES) == 0);
      }
   }
}
