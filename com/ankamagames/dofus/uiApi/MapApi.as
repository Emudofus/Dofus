package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.datacenter.world.SubArea;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.dofus.datacenter.world.WorldMap;
    import com.ankamagames.dofus.datacenter.world.SuperArea;
    import com.ankamagames.dofus.datacenter.world.Area;
    import __AS3__.vec.Vector;
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

    [InstanciedApi]
    public class MapApi implements IApi 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapApi));


        [Untrusted]
        public function getCurrentSubArea():SubArea
        {
            var frame:RoleplayEntitiesFrame = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame);
            if (frame)
            {
                return (SubArea.getSubAreaById(frame.currentSubAreaId));
            };
            return (null);
        }

        [Untrusted]
        public function getCurrentWorldMap():WorldMap
        {
            return (PlayedCharacterManager.getInstance().currentWorldMap);
        }

        [Untrusted]
        public function getAllSuperArea():Array
        {
            return (SuperArea.getAllSuperArea());
        }

        [Untrusted]
        public function getAllArea():Array
        {
            return (Area.getAllArea());
        }

        [Untrusted]
        public function getAllSubArea():Array
        {
            return (SubArea.getAllSubArea());
        }

        [Untrusted]
        public function getSubArea(subAreaId:uint):SubArea
        {
            return (SubArea.getSubAreaById(subAreaId));
        }

        [Untrusted]
        public function getSubAreaMapIds(subAreaId:uint):Vector.<uint>
        {
            return (SubArea.getSubAreaById(subAreaId).mapIds);
        }

        [Untrusted]
        public function getSubAreaCenter(subAreaId:uint):Point
        {
            return (SubArea.getSubAreaById(subAreaId).center);
        }

        [Untrusted]
        public function getWorldPoint(mapId:uint):WorldPoint
        {
            return (WorldPoint.fromMapId(mapId));
        }

        [Untrusted]
        public function getMapCoords(mapId:uint):Point
        {
            var mapPosition:MapPosition = MapPosition.getMapPositionById(mapId);
            return (new Point(mapPosition.posX, mapPosition.posY));
        }

        [Untrusted]
        public function getSubAreaShape(subAreaId:uint):Vector.<int>
        {
            var subArea:SubArea = SubArea.getSubAreaById(subAreaId);
            if (subArea)
            {
                return (subArea.shape);
            };
            return (null);
        }

        [Untrusted]
        public function getHintIds():Array
        {
            var hint:Hint;
            var h:Object;
            var mp:MapPosition;
            var hints:Array = (Hint.getHints() as Array);
            var res:Array = new Array();
            var i:int;
            for each (hint in hints)
            {
                if (!!(hint))
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
                    if (!(h.subarea))
                    {
                        trace(((("No subarea found for mapId " + hint.mapId) + ", skipping the hint ") + hint.id));
                    }
                    else
                    {
                        mp = MapPosition.getMapPositionById(hint.mapId);
                        if (!(mp))
                        {
                            trace(((("No coordinates found for mapId " + hint.mapId) + ", skipping the hint ") + hint.id));
                        }
                        else
                        {
                            h.x = mp.posX;
                            h.y = mp.posY;
                            h.outdoor = mp.outdoor;
                            h.worldMapId = hint.worldMapId;
                            res.push(h);
                        };
                    };
                };
            };
            return (res);
        }

        [Untrusted]
        public function subAreaByMapId(mapId:uint):SubArea
        {
            return (SubArea.getSubAreaByMapId(mapId));
        }

        [Untrusted]
        public function getMapIdByCoord(x:int, y:int):Vector.<int>
        {
            return (MapPosition.getMapIdByCoord(x, y));
        }

        [Untrusted]
        public function getMapPositionById(mapId:uint):MapPosition
        {
            return (MapPosition.getMapPositionById(mapId));
        }

        [Untrusted]
        public function intersects(rect1:Object, rect2:Object):Boolean
        {
            if (((!(rect1)) || (!(rect2))))
            {
                return (false);
            };
            var r1:Rectangle = Rectangle(SecureCenter.unsecure(rect1));
            var r2:Rectangle = Rectangle(SecureCenter.unsecure(rect2));
            if (((r1) && (r2)))
            {
                return (r1.intersects(r2));
            };
            return (false);
        }

        [Trusted]
        public function movePlayer(x:int, y:int, world:int=-1):void
        {
            var wp:WorldPoint;
            var currentWorldId:uint;
            var superAreaId:uint;
            var areaId:uint;
            var subAreaId:uint;
            var currentMapIsOutDoor:Boolean;
            var maps:Array;
            var mapId:uint;
            var mapPosition:MapPosition;
            var order:uint;
            var worldId:uint;
            var worldMapId:int;
            var mapUi:UiRootContainer;
            if (!(PlayerManager.getInstance().hasRights))
            {
                return;
            };
            var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
            var mapIds:Vector.<int> = MapPosition.getMapIdByCoord(x, y);
            if (mapIds)
            {
                currentWorldId = (((world == -1)) ? PlayedCharacterManager.getInstance().currentMap.worldId : world);
                superAreaId = PlayedCharacterManager.getInstance().currentSubArea.area.superArea.id;
                areaId = PlayedCharacterManager.getInstance().currentSubArea.area.id;
                subAreaId = PlayedCharacterManager.getInstance().currentSubArea.id;
                currentMapIsOutDoor = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId).outdoor;
                maps = [];
                for each (mapId in mapIds)
                {
                    mapPosition = MapPosition.getMapPositionById(mapId);
                    trace(((mapPosition.id + " : ") + mapPosition.hasPriorityOnWorldmap));
                    order = 0;
                    worldId = WorldPoint.fromMapId(mapPosition.id).worldId;
                    switch (worldId)
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
                    };
                    worldMapId = this.getCurrentWorldMap().id;
                    mapUi = Berilia.getInstance().getUi("cartographyUi");
                    if (!(mapUi))
                    {
                        mapUi = Berilia.getInstance().getUi("cartographyPopup");
                    };
                    if (mapUi)
                    {
                        worldMapId = mapUi.uiClass.currentWorldId;
                    };
                    if (((((mapPosition.subArea) && (mapPosition.subArea.worldmap))) && ((mapPosition.subArea.worldmap.id == worldMapId))))
                    {
                        order = (order + 100000);
                    };
                    if (mapPosition.hasPriorityOnWorldmap)
                    {
                        order = (order + 10000);
                    };
                    if (mapPosition.outdoor == currentMapIsOutDoor)
                    {
                        order++;
                    };
                    if (((mapPosition.subArea) && ((mapPosition.subArea.id == subAreaId))))
                    {
                        order = (order + 100);
                    };
                    if (((((mapPosition.subArea) && (mapPosition.subArea.area))) && ((mapPosition.subArea.area.id == areaId))))
                    {
                        order = (order + 50);
                    };
                    if (((((((mapPosition.subArea) && (mapPosition.subArea.area))) && (mapPosition.subArea.area.superArea))) && ((mapPosition.subArea.area.superArea.id == superAreaId))))
                    {
                        order = (order + 25);
                    };
                    if (worldId == currentWorldId)
                    {
                        order = (order + 100);
                    };
                    maps.push({
                        "id":mapId,
                        "order":order
                    });
                };
                if (maps.length)
                {
                    maps.sortOn(["order", "id"], [Array.NUMERIC, (Array.NUMERIC | Array.DESCENDING)]);
                    aqcmsg.initAdminQuietCommandMessage(("moveto " + maps.pop().id));
                }
                else
                {
                    aqcmsg.initAdminQuietCommandMessage(((("moveto " + x) + ",") + y));
                };
            }
            else
            {
                aqcmsg.initAdminQuietCommandMessage(((("moveto " + x) + ",") + y));
            };
            ConnectionsHandler.getConnection().send(aqcmsg);
        }

        [Trusted]
        public function movePlayerOnMapId(mapId:uint):void
        {
            var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
            aqcmsg.initAdminQuietCommandMessage(("moveto " + mapId));
            if (PlayerManager.getInstance().hasRights)
            {
                ConnectionsHandler.getConnection().send(aqcmsg);
            };
        }

        [Untrusted]
        public function getMapReference(refId:uint):Object
        {
            return (MapReference.getMapReferenceById(refId));
        }

        [Untrusted]
        public function getPhoenixsMaps():Array
        {
            return (FlagManager.getInstance().phoenixs);
        }

        [Untrusted]
        public function getClosestPhoenixMap():uint
        {
            var mapId:uint;
            var closestPhoenixMapId:uint;
            var mapPos:MapPosition;
            var dist:int;
            var dx:int;
            var dy:int;
            var minDist:int = -1;
            for each (mapId in FlagManager.getInstance().phoenixs)
            {
                mapPos = MapPosition.getMapPositionById(mapId);
                if (mapPos.worldMap == PlayedCharacterManager.getInstance().currentWorldMap.id)
                {
                    dx = (mapPos.posX - PlayedCharacterManager.getInstance().currentMap.outdoorX);
                    dy = (mapPos.posY - PlayedCharacterManager.getInstance().currentMap.outdoorY);
                    dist = ((dx * dx) + (dy * dy));
                    if (minDist == -1)
                    {
                        minDist = dist;
                        closestPhoenixMapId = mapId;
                    }
                    else
                    {
                        if ((((dist < minDist)) || ((dist == 0))))
                        {
                            minDist = dist;
                            closestPhoenixMapId = mapId;
                        };
                    };
                };
            };
            return (closestPhoenixMapId);
        }

        [Trusted]
        public function isInIncarnam():Boolean
        {
            return ((this.getCurrentSubArea().areaId == 45));
        }


    }
}//package com.ankamagames.dofus.uiApi

