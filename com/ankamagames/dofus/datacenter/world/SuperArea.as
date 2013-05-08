package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;


   public class SuperArea extends Object implements IDataCenter
   {
         

      public function SuperArea() {
         super();
      }

      public static const MODULE:String = "SuperAreas";

      private static var _allSuperAreas:Array;

      public static function getSuperAreaById(id:int) : SuperArea {
         var superArea:SuperArea = GameData.getObject(MODULE,id) as SuperArea;
         if(!superArea)
         {
            return null;
         }
         return superArea;
      }

      public static function getAllSuperArea() : Array {
         if(_allSuperAreas)
         {
            return _allSuperAreas;
         }
         _allSuperAreas=GameData.getObjects(MODULE) as Array;
         return _allSuperAreas;
      }

      public var id:int;

      public var nameId:uint;

      public var worldmapId:uint;

      private var _name:String;

      private var _worldmap:WorldMap;

      public function get name() : String {
         if(!this._name)
         {
            this._name=I18n.getText(this.nameId);
         }
         return this._name;
      }

      public function get worldmap() : WorldMap {
         if(!this._worldmap)
         {
            this._worldmap=WorldMap.getWorldMapById(this.worldmapId);
         }
         return this._worldmap;
      }
   }

}