package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Area extends Object implements IDataCenter
   {
      
      public function Area()
      {
         super();
      }
      
      public static const MODULE:String = "Areas";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Area));
      
      private static var _allAreas:Array;
      
      public static function getAreaById(param1:int) : Area
      {
         var _loc2_:Area = GameData.getObject(MODULE,param1) as Area;
         if(!_loc2_ || !_loc2_.superArea || !_loc2_.hasVisibleSubAreas)
         {
            return null;
         }
         return _loc2_;
      }
      
      public static function getAllArea() : Array
      {
         if(_allAreas)
         {
            return _allAreas;
         }
         _allAreas = GameData.getObjects(MODULE) as Array;
         return _allAreas;
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var superAreaId:int;
      
      public var containHouses:Boolean;
      
      public var containPaddocks:Boolean;
      
      public var bounds:Rectangle;
      
      public var worldmapId:uint;
      
      public var hasWorldMap:Boolean;
      
      private var _name:String;
      
      private var _superArea:SuperArea;
      
      private var _hasVisibleSubAreas:Boolean;
      
      private var _hasVisibleSubAreasInitialized:Boolean;
      
      private var _worldMap:WorldMap;
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get superArea() : SuperArea
      {
         if(!this._superArea)
         {
            this._superArea = SuperArea.getSuperAreaById(this.superAreaId);
         }
         return this._superArea;
      }
      
      public function get hasVisibleSubAreas() : Boolean
      {
         if(!this._hasVisibleSubAreasInitialized)
         {
            this._hasVisibleSubAreas = true;
            this._hasVisibleSubAreasInitialized = true;
         }
         return this._hasVisibleSubAreas;
      }
      
      public function get worldmap() : WorldMap
      {
         if(!this._worldMap)
         {
            if(!this.hasWorldMap)
            {
               this._worldMap = this.superArea.worldmap;
            }
            else
            {
               this._worldMap = WorldMap.getWorldMapById(this.worldmapId);
            }
         }
         return this._worldMap;
      }
   }
}
