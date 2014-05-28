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
   import flash.geom.Point;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
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
      
      protected static const _log:Logger;
      
      public function getCurrentSubArea() : SubArea {
         var frame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(frame)
         {
            return SubArea.getSubAreaById(frame.currentSubAreaId);
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
      
      public function getSubArea(subAreaId:uint) : SubArea {
         return SubArea.getSubAreaById(subAreaId);
      }
      
      public function getSubAreaMapIds(subAreaId:uint) : Vector.<uint> {
         return SubArea.getSubAreaById(subAreaId).mapIds;
      }
      
      public function getSubAreaCenter(subAreaId:uint) : Point {
         return SubArea.getSubAreaById(subAreaId).center;
      }
      
      public function getWorldPoint(mapId:uint) : WorldPoint {
         return WorldPoint.fromMapId(mapId);
      }
      
      public function getMapCoords(mapId:uint) : Point {
         var mapPosition:MapPosition = MapPosition.getMapPositionById(mapId);
         return new Point(mapPosition.posX,mapPosition.posY);
      }
      
      public function getSubAreaShape(subAreaId:uint) : Vector.<int> {
         var subArea:SubArea = SubArea.getSubAreaById(subAreaId);
         if(subArea)
         {
            return subArea.shape;
         }
         return null;
      }
      
      public function getHintIds() : Array {
         var hint:Hint = null;
         var h:Object = null;
         var mp:MapPosition = null;
         var hints:Array = Hint.getHints() as Array;
         var res:Array = new Array();
         var i:int = 0;
         for each(hint in hints)
         {
            if(hint)
            {
               i++;
               h = new Object();
               h.id = hint.id;
               h.category = hint.categoryId;
               h.name = hint.name;
               h.mapId = hint.mapId;
               h.realMapId = hint.realMapId;
               h.gfx = hint.gfx;
               h.subarea = SubArea.getSubAreaByMapId(hint.mapId);
               if(!h.subarea)
               {
                  trace("No subarea found for mapId " + hint.mapId + ", skipping the hint " + hint.id);
               }
               else
               {
                  mp = MapPosition.getMapPositionById(hint.mapId);
                  if(!mp)
                  {
                     trace("No coordinates found for mapId " + hint.mapId + ", skipping the hint " + hint.id);
                  }
                  else
                  {
                     h.x = mp.posX;
                     h.y = mp.posY;
                     h.outdoor = mp.outdoor;
                     h.worldMapId = hint.worldMapId;
                     res.push(h);
                  }
               }
            }
         }
         return res;
      }
      
      public function subAreaByMapId(mapId:uint) : SubArea {
         return SubArea.getSubAreaByMapId(mapId);
      }
      
      public function getMapIdByCoord(x:int, y:int) : Vector.<int> {
         return MapPosition.getMapIdByCoord(x,y);
      }
      
      public function getMapPositionById(mapId:uint) : MapPosition {
         return MapPosition.getMapPositionById(mapId);
      }
      
      public function intersects(rect1:Object, rect2:Object) : Boolean {
         if((!rect1) || (!rect2))
         {
            return false;
         }
         var r1:Rectangle = Rectangle(SecureCenter.unsecure(rect1));
         var r2:Rectangle = Rectangle(SecureCenter.unsecure(rect2));
         if((r1) && (r2))
         {
            return r1.intersects(r2);
         }
         return false;
      }
      
      public function movePlayer(x:int, y:int, world:int = -1) : void {
         var wp:WorldPoint = null;
         var currentWorldId:uint = 0;
         var superAreaId:uint = 0;
         var areaId:uint = 0;
         var subAreaId:uint = 0;
         var currentMapIsOutDoor:* = false;
         var maps:Array = null;
         var mapId:uint = 0;
         var mapPosition:MapPosition = null;
         var order:uint = 0;
         var worldId:uint = 0;
         var worldMapId:* = 0;
         var mapUi:UiRootContainer = null;
         if(!PlayerManager.getInstance().hasRights)
         {
            return;
         }
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         var mapIds:Vector.<int> = MapPosition.getMapIdByCoord(x,y);
         if(mapIds)
         {
            currentWorldId = world == -1?PlayedCharacterManager.getInstance().currentMap.worldId:world;
            superAreaId = PlayedCharacterManager.getInstance().currentSubArea.area.superArea.id;
            areaId = PlayedCharacterManager.getInstance().currentSubArea.area.id;
            subAreaId = PlayedCharacterManager.getInstance().currentSubArea.id;
            currentMapIsOutDoor = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId).outdoor;
            maps = [];
            for each(mapId in mapIds)
            {
               mapPosition = MapPosition.getMapPositionById(mapId);
               trace(mapPosition.id + " : " + mapPosition.hasPriorityOnWorldmap);
               order = 0;
               worldId = WorldPoint.fromMapId(mapPosition.id).worldId;
               switch(worldId)
               {
                  case 0:
                     order = 40;
                     break;
                  case 3:
                     order = 30;
                     break;
                  case 2:
                     order = 20;
                     break;
                  case 1:
                     order = 10;
                     break;
               }
               worldMapId = this.getCurrentWorldMap().id;
               mapUi = Berilia.getInstance().getUi("cartographyUi");
               if(!mapUi)
               {
                  mapUi = Berilia.getInstance().getUi("cartographyPopup");
               }
               if(mapUi)
               {
                  worldMapId = mapUi.uiClass.currentWorldId;
               }
               if((mapPosition.subArea) && (mapPosition.subArea.worldmap) && (mapPosition.subArea.worldmap.id == worldMapId))
               {
                  order = order + 100000;
               }
               if(mapPosition.hasPriorityOnWorldmap)
               {
                  order = order + 10000;
               }
               if(mapPosition.outdoor == currentMapIsOutDoor)
               {
                  order++;
               }
               if((mapPosition.subArea) && (mapPosition.subArea.id == subAreaId))
               {
                  order = order + 100;
               }
               if((mapPosition.subArea) && (mapPosition.subArea.area) && (mapPosition.subArea.area.id == areaId))
               {
                  order = order + 50;
               }
               if((mapPosition.subArea && mapPosition.subArea.area) && (mapPosition.subArea.area.superArea) && (mapPosition.subArea.area.superArea.id == superAreaId))
               {
                  order = order + 25;
               }
               if(worldId == currentWorldId)
               {
                  order = order + 100;
               }
               maps.push(
                  {
                     "id":mapId,
                     "order":order
                  });
            }
            if(maps.length)
            {
               maps.sortOn(["order","id"],[Array.NUMERIC,Array.NUMERIC | Array.DESCENDING]);
               aqcmsg.initAdminQuietCommandMessage("moveto " + maps.pop().id);
            }
            else
            {
               aqcmsg.initAdminQuietCommandMessage("moveto " + x + "," + y);
            }
         }
         else
         {
            aqcmsg.initAdminQuietCommandMessage("moveto " + x + "," + y);
         }
         ConnectionsHandler.getConnection().send(aqcmsg);
      }
      
      public function movePlayerOnMapId(mapId:uint) : void {
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("moveto " + mapId);
         if(PlayerManager.getInstance().hasRights)
         {
            ConnectionsHandler.getConnection().send(aqcmsg);
         }
      }
      
      public function getMapReference(refId:uint) : Object {
         return MapReference.getMapReferenceById(refId);
      }
      
      public function getPhoenixsMaps() : Array {
         return FlagManager.getInstance().phoenixs;
      }
      
      public function getClosestPhoenixMap() : uint {
         var mapId:uint = 0;
         var closestPhoenixMapId:uint = 0;
         var mapPos:MapPosition = null;
         var dist:* = 0;
         var dx:* = 0;
         var dy:* = 0;
         var minDist:int = -1;
         for each(mapId in FlagManager.getInstance().phoenixs)
         {
            mapPos = MapPosition.getMapPositionById(mapId);
            if(mapPos.worldMap == PlayedCharacterManager.getInstance().currentWorldMap.id)
            {
               dx = mapPos.posX - PlayedCharacterManager.getInstance().currentMap.outdoorX;
               dy = mapPos.posY - PlayedCharacterManager.getInstance().currentMap.outdoorY;
               dist = dx * dx + dy * dy;
               if(minDist == -1)
               {
                  minDist = dist;
                  closestPhoenixMapId = mapId;
               }
               else if((dist < minDist) || (dist == 0))
               {
                  minDist = dist;
                  closestPhoenixMapId = mapId;
               }
               
            }
         }
         return closestPhoenixMapId;
      }
      
      public function isInIncarnam() : Boolean {
         return this.getCurrentSubArea().areaId == 45;
      }
   }
}
