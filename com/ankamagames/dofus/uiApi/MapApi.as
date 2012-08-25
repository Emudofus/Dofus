package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.messages.authorized.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.geom.*;

    public class MapApi extends Object implements IApi
    {

        public function MapApi()
        {
            return;
        }// end function

        public function getCurrentSubArea() : SubArea
        {
            return SubArea.getSubAreaById((Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).currentSubAreaId);
        }// end function

        public function getAllSuperArea() : Array
        {
            return SuperArea.getAllSuperArea();
        }// end function

        public function getAllArea() : Array
        {
            return Area.getAllArea();
        }// end function

        public function getAllSubArea() : Array
        {
            return SubArea.getAllSubArea();
        }// end function

        public function getSubArea(param1:uint) : SubArea
        {
            return SubArea.getSubAreaById(param1);
        }// end function

        public function getSubAreaMapIds(param1:uint) : Vector.<uint>
        {
            return SubArea.getSubAreaById(param1).mapIds;
        }// end function

        public function getWorldPoint(param1:uint) : WorldPoint
        {
            return WorldPoint.fromMapId(param1);
        }// end function

        public function getMapCoords(param1:uint) : Point
        {
            var _loc_2:* = MapPosition.getMapPositionById(param1);
            return new Point(_loc_2.posX, _loc_2.posY);
        }// end function

        public function getSubAreaShape(param1:uint) : Vector.<int>
        {
            var _loc_2:* = SubArea.getSubAreaById(param1);
            if (_loc_2)
            {
                return _loc_2.shape;
            }
            return null;
        }// end function

        public function getHintIds() : Array
        {
            var _loc_4:Hint = null;
            var _loc_5:Object = null;
            var _loc_6:MapPosition = null;
            var _loc_1:* = Hint.getHints() as Array;
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            for each (_loc_4 in _loc_1)
            {
                
                if (!_loc_4)
                {
                    continue;
                }
                _loc_3++;
                _loc_5 = new Object();
                _loc_5.id = _loc_4.id;
                _loc_5.category = _loc_4.categoryId;
                _loc_5.name = _loc_4.name;
                _loc_5.mapId = _loc_4.mapId;
                _loc_5.realMapId = _loc_4.realMapId;
                _loc_5.gfx = _loc_4.gfx;
                _loc_5.subarea = SubArea.getSubAreaByMapId(_loc_4.mapId);
                if (!_loc_5.subarea)
                {
                    continue;
                }
                _loc_6 = MapPosition.getMapPositionById(_loc_4.mapId);
                if (!_loc_6)
                {
                    continue;
                }
                _loc_5.x = _loc_6.posX;
                _loc_5.y = _loc_6.posY;
                _loc_5.outdoor = _loc_6.outdoor;
                _loc_2.push(_loc_5);
            }
            return _loc_2;
        }// end function

        public function subAreaByMapId(param1:uint) : SubArea
        {
            return SubArea.getSubAreaByMapId(param1);
        }// end function

        public function getMapIdByCoord(param1:int, param2:int) : Vector.<int>
        {
            return MapPosition.getMapIdByCoord(param1, param2);
        }// end function

        public function getMapPositionById(param1:uint) : MapPosition
        {
            return MapPosition.getMapPositionById(param1);
        }// end function

        public function intersects(param1:Object, param2:Object) : Boolean
        {
            if (!param1 || !param2)
            {
                return false;
            }
            var _loc_3:* = Rectangle(SecureCenter.unsecure(param1));
            var _loc_4:* = Rectangle(SecureCenter.unsecure(param2));
            if (_loc_3 && _loc_4)
            {
                return _loc_3.intersects(_loc_4);
            }
            return false;
        }// end function

        public function movePlayer(param1:int, param2:int, param3:int = -1) : void
        {
            var _loc_6:WorldPoint = null;
            var _loc_7:uint = 0;
            var _loc_8:uint = 0;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_11:Boolean = false;
            var _loc_12:Array = null;
            var _loc_13:uint = 0;
            var _loc_14:MapPosition = null;
            var _loc_15:uint = 0;
            var _loc_16:uint = 0;
            if (!PlayerManager.getInstance().hasRights)
            {
                return;
            }
            var _loc_4:* = new AdminQuietCommandMessage();
            var _loc_5:* = MapPosition.getMapIdByCoord(param1, param2);
            if (MapPosition.getMapIdByCoord(param1, param2))
            {
                _loc_7 = param3 == -1 ? (PlayedCharacterManager.getInstance().currentMap.worldId) : (param3);
                _loc_8 = PlayedCharacterManager.getInstance().currentSubArea.area.superArea.id;
                _loc_9 = PlayedCharacterManager.getInstance().currentSubArea.area.id;
                _loc_10 = PlayedCharacterManager.getInstance().currentSubArea.id;
                _loc_11 = MapPosition.getMapPositionById(PlayedCharacterManager.getInstance().currentMap.mapId).outdoor;
                _loc_12 = [];
                for each (_loc_13 in _loc_5)
                {
                    
                    _loc_14 = MapPosition.getMapPositionById(_loc_13);
                    _loc_15 = 0;
                    _loc_16 = WorldPoint.fromMapId(_loc_14.id).worldId;
                    switch(_loc_16)
                    {
                        case 0:
                        {
                            _loc_15 = 40;
                            break;
                        }
                        case 3:
                        {
                            _loc_15 = 30;
                            break;
                        }
                        case 2:
                        {
                            _loc_15 = 20;
                            break;
                        }
                        case 1:
                        {
                            _loc_15 = 10;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_14.hasPriorityOnWorldmap)
                    {
                        _loc_15 = _loc_15 + 10000;
                    }
                    if (_loc_14.outdoor == _loc_11)
                    {
                        _loc_15 = _loc_15 + 1;
                    }
                    if (_loc_14.subArea && _loc_14.subArea.id == _loc_10)
                    {
                        _loc_15 = _loc_15 + 100;
                    }
                    if (_loc_14.subArea && _loc_14.subArea.area && _loc_14.subArea.area.id == _loc_9)
                    {
                        _loc_15 = _loc_15 + 50;
                    }
                    if (_loc_14.subArea && _loc_14.subArea.area && _loc_14.subArea.area.superArea && _loc_14.subArea.area.superArea.id == _loc_8)
                    {
                        _loc_15 = _loc_15 + 25;
                    }
                    if (_loc_16 == _loc_7)
                    {
                        _loc_15 = _loc_15 + 100;
                    }
                    _loc_12.push({id:_loc_13, order:_loc_15});
                }
                if (_loc_12.length)
                {
                    _loc_12.sortOn(["order", "id"], [Array.NUMERIC, Array.NUMERIC | Array.DESCENDING]);
                    _loc_4.initAdminQuietCommandMessage("moveto " + _loc_12.pop().id);
                }
                else
                {
                    _loc_4.initAdminQuietCommandMessage("moveto " + param1 + "," + param2);
                }
            }
            else
            {
                _loc_4.initAdminQuietCommandMessage("moveto " + param1 + "," + param2);
            }
            ConnectionsHandler.getConnection().send(_loc_4);
            return;
        }// end function

        public function movePlayerOnMapId(param1:uint) : void
        {
            var _loc_2:* = new AdminQuietCommandMessage();
            _loc_2.initAdminQuietCommandMessage("moveto " + param1);
            if (PlayerManager.getInstance().hasRights)
            {
                ConnectionsHandler.getConnection().send(_loc_2);
            }
            return;
        }// end function

        public function getMapReference(param1:uint) : Object
        {
            return MapReference.getMapReferenceById(param1);
        }// end function

        public function getPhoenixsMaps() : Array
        {
            return FlagManager.getInstance().phoenixs;
        }// end function

        public function isInIncarnam() : Boolean
        {
            return this.getCurrentSubArea().areaId == 45;
        }// end function

    }
}
