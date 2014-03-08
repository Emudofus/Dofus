package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.world.SuperArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import flash.geom.Point;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.datacenter.world.MapReference;
   import com.ankamagames.dofus.logic.game.common.managers.FlagManager;
   
   public class MapApi extends Object implements IApi
   {
      
      public function MapApi() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapApi));
      
      public function getCurrentSubArea() : SubArea {
         var _loc1_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(_loc1_)
         {
            return SubArea.getSubAreaById(_loc1_.currentSubAreaId);
         }
         return null;
      }
      
      public function getCurrentWorldMap() : WorldMap {
         return PlayedCharacterManager.getInstance().currentWorldMap;
      }
      
      public function getAllSuperArea() : Array {
         return SuperArea.getAllSuperArea();
      }
      
      public function getAllArea() : Array {
         return Area.getAllArea();
      }
      
      public function getAllSubArea() : Array {
         return SubArea.getAllSubArea();
      }
      
      public function getSubArea(param1:uint) : SubArea {
         return SubArea.getSubAreaById(param1);
      }
      
      public function getSubAreaMapIds(param1:uint) : Vector.<uint> {
         return SubArea.getSubAreaById(param1).mapIds;
      }
      
      public function getWorldPoint(param1:uint) : WorldPoint {
         return WorldPoint.fromMapId(param1);
      }
      
      public function getMapCoords(param1:uint) : Point {
         var _loc2_:MapPosition = MapPosition.getMapPositionById(param1);
         return new Point(_loc2_.posX,_loc2_.posY);
      }
      
      public function getSubAreaShape(param1:uint) : Vector.<int> {
         var _loc2_:SubArea = SubArea.getSubAreaById(param1);
         if(_loc2_)
         {
            return _loc2_.shape;
         }
         return null;
      }
      
      public function getHintIds() : Array {
         var _loc4_:Hint = null;
         var _loc5_:Object = null;
         var _loc6_:MapPosition = null;
         var _loc1_:Array = Hint.getHints() as Array;
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         for each (_loc4_ in _loc1_)
         {
            if(_loc4_)
            {
               _loc3_++;
               _loc5_ = new Object();
               _loc5_.id = _loc4_.id;
               _loc5_.category = _loc4_.categoryId;
               _loc5_.name = _loc4_.name;
               _loc5_.mapId = _loc4_.mapId;
               _loc5_.realMapId = _loc4_.realMapId;
               _loc5_.gfx = _loc4_.gfx;
               _loc5_.subarea = SubArea.getSubAreaByMapId(_loc4_.mapId);
               if(_loc5_.subarea)
               {
                  _loc6_ = MapPosition.getMapPositionById(_loc4_.mapId);
                  if(_loc6_)
                  {
                     _loc5_.x = _loc6_.posX;
                     _loc5_.y = _loc6_.posY;
                     _loc5_.outdoor = _loc6_.outdoor;
                     _loc5_.worldMapId = _loc4_.worldMapId;
                     _loc2_.push(_loc5_);
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function subAreaByMapId(param1:uint) : SubArea {
         return SubArea.getSubAreaByMapId(param1);
      }
      
      public function getMapIdByCoord(param1:int, param2:int) : Vector.<int> {
         return MapPosition.getMapIdByCoord(param1,param2);
      }
      
      public function getMapPositionById(param1:uint) : MapPosition {
         return MapPosition.getMapPositionById(param1);
      }
      
      public function intersects(param1:Object, param2:Object) : Boolean {
         if(!param1 || !param2)
         {
            return false;
         }
         var _loc3_:Rectangle = Rectangle(SecureCenter.unsecure(param1));
         var _loc4_:Rectangle = Rectangle(SecureCenter.unsecure(param2));
         if((_loc3_) && (_loc4_))
         {
            return _loc3_.intersects(_loc4_);
         }
         return false;
      }
      
      public function movePlayer(param1:int, param2:int, param3:int=-1) : void {
         var _loc6_:WorldPoint = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:* = false;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:MapPosition = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:* = 0;
         var _loc18_:UiRootContainer = null;
         if(!PlayerManager.getInstance().hasRights)
         {
            return;
         }
         var _loc4_:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         var _loc5_:Vector.<int> = MapPosition.getMapIdByCoord(param1,param2);
         if(_loc5_)
         {
            _loc7_ = param3 == -1?PlayedCharacterManager.getInstance().currentMap.worldId:param3;
            _loc8_ = PlayedCharacterManager.getInstance().currentSubArea.area.superArea.id;
            _loc9_ = PlayedCharacterManager.getInstance().currentSubArea.area.id;
            _loc10_ = PlayedCharacterManager.getInstance().currentSubArea.id;
            _loc11_ = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId).outdoor;
            _loc12_ = [];
            for each (_loc13_ in _loc5_)
            {
               _loc14_ = MapPosition.getMapPositionById(_loc13_);
               _loc15_ = 0;
               _loc16_ = WorldPoint.fromMapId(_loc14_.id).worldId;
               switch(_loc16_)
               {
                  case 0:
                     _loc15_ = 40;
                     break;
                  case 3:
                     _loc15_ = 30;
                     break;
                  case 2:
                     _loc15_ = 20;
                     break;
                  case 1:
                     _loc15_ = 10;
                     break;
               }
               _loc17_ = this.getCurrentWorldMap().id;
               _loc18_ = Berilia.getInstance().getUi("cartographyUi");
               if(!_loc18_)
               {
                  _loc18_ = Berilia.getInstance().getUi("cartographyPopup");
               }
               if(_loc18_)
               {
                  _loc17_ = _loc18_.uiClass.currentWorldId;
               }
               if((_loc14_.subArea) && (_loc14_.subArea.worldmap) && _loc14_.subArea.worldmap.id == _loc17_)
               {
                  _loc15_ = _loc15_ + 100000;
               }
               if(_loc14_.hasPriorityOnWorldmap)
               {
                  _loc15_ = _loc15_ + 10000;
               }
               if(_loc14_.outdoor == _loc11_)
               {
                  _loc15_++;
               }
               if((_loc14_.subArea) && _loc14_.subArea.id == _loc10_)
               {
                  _loc15_ = _loc15_ + 100;
               }
               if((_loc14_.subArea) && (_loc14_.subArea.area) && _loc14_.subArea.area.id == _loc9_)
               {
                  _loc15_ = _loc15_ + 50;
               }
               if(((_loc14_.subArea) && (_loc14_.subArea.area)) && (_loc14_.subArea.area.superArea) && _loc14_.subArea.area.superArea.id == _loc8_)
               {
                  _loc15_ = _loc15_ + 25;
               }
               if(_loc16_ == _loc7_)
               {
                  _loc15_ = _loc15_ + 100;
               }
               _loc12_.push(
                  {
                     "id":_loc13_,
                     "order":_loc15_
                  });
            }
            if(_loc12_.length)
            {
               _loc12_.sortOn(["order","id"],[Array.NUMERIC,Array.NUMERIC | Array.DESCENDING]);
               _loc4_.initAdminQuietCommandMessage("moveto " + _loc12_.pop().id);
            }
            else
            {
               _loc4_.initAdminQuietCommandMessage("moveto " + param1 + "," + param2);
            }
         }
         else
         {
            _loc4_.initAdminQuietCommandMessage("moveto " + param1 + "," + param2);
         }
         ConnectionsHandler.getConnection().send(_loc4_);
      }
      
      public function movePlayerOnMapId(param1:uint) : void {
         var _loc2_:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         _loc2_.initAdminQuietCommandMessage("moveto " + param1);
         if(PlayerManager.getInstance().hasRights)
         {
            ConnectionsHandler.getConnection().send(_loc2_);
         }
      }
      
      public function getMapReference(param1:uint) : Object {
         return MapReference.getMapReferenceById(param1);
      }
      
      public function getPhoenixsMaps() : Array {
         return FlagManager.getInstance().phoenixs;
      }
      
      public function getClosestPhoenixMap() : uint {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MapPosition = null;
         var _loc4_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc5_:* = -1;
         for each (_loc1_ in FlagManager.getInstance().phoenixs)
         {
            _loc3_ = MapPosition.getMapPositionById(_loc1_);
            if(_loc3_.worldMap == PlayedCharacterManager.getInstance().currentWorldMap.id)
            {
               _loc6_ = _loc3_.posX - PlayedCharacterManager.getInstance().currentMap.outdoorX;
               _loc7_ = _loc3_.posY - PlayedCharacterManager.getInstance().currentMap.outdoorY;
               _loc4_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
               if(_loc5_ == -1)
               {
                  _loc5_ = _loc4_;
                  _loc2_ = _loc1_;
               }
               else
               {
                  if(_loc4_ < _loc5_ || _loc4_ == 0)
                  {
                     _loc5_ = _loc4_;
                     _loc2_ = _loc1_;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function isInIncarnam() : Boolean {
         return this.getCurrentSubArea().areaId == 45;
      }
   }
}
