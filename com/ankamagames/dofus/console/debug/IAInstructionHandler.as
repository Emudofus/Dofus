package com.ankamagames.dofus.console.debug
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.map.*;
    import com.ankamagames.jerakine.pathfinding.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.display.*;

    public class IAInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function IAInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_5:uint = 0;
            var _loc_6:MapPoint = null;
            var _loc_7:uint = 0;
            var _loc_8:Selection = null;
            var _loc_9:Lozenge = null;
            var _loc_10:Vector.<uint> = null;
            var _loc_11:uint = 0;
            var _loc_12:uint = 0;
            var _loc_13:MapPoint = null;
            var _loc_14:MapPoint = null;
            var _loc_15:Vector.<uint> = null;
            var _loc_16:Selection = null;
            var _loc_17:uint = 0;
            var _loc_18:MapPoint = null;
            var _loc_19:uint = 0;
            var _loc_20:MapPoint = null;
            var _loc_21:Array = null;
            var _loc_22:int = 0;
            var _loc_4:* = DataMapProvider.getInstance();
            switch(param2)
            {
                case "debuglos":
                {
                    if (param3.length != 2)
                    {
                        param1.output("Arguments needed : cell and range");
                    }
                    else if (param3.length == 2)
                    {
                        _loc_5 = uint(param3[0]);
                        _loc_6 = MapPoint.fromCellId(_loc_5);
                        _loc_7 = uint(param3[1]);
                        _loc_8 = new Selection();
                        _loc_9 = new Lozenge(0, _loc_7, _loc_4);
                        _loc_10 = _loc_9.getCells(_loc_5);
                        _loc_8.renderer = new ZoneDARenderer();
                        _loc_8.color = new Color(26112);
                        _loc_8.zone = new Custom(LosDetector.getCell(_loc_4, _loc_10, _loc_6));
                        SelectionManager.getInstance().addSelection(_loc_8, "CellsFreeForLOS");
                        SelectionManager.getInstance().update("CellsFreeForLOS");
                    }
                    break;
                }
                case "tracepath":
                {
                    if (param3.length != 2)
                    {
                        param1.output("Arguments needed : start and end of the path");
                    }
                    else if (param3.length == 2)
                    {
                        _loc_11 = uint(param3[0]);
                        _loc_12 = uint(param3[1]);
                        _loc_13 = MapPoint.fromCellId(_loc_12);
                        if (_loc_4.height == 0 || _loc_4.width == 0 || !_loc_4.pointMov(_loc_13.x, _loc_13.y, true))
                        {
                            param1.output("Problem with the map or the end.");
                        }
                        else
                        {
                            _loc_14 = MapPoint.fromCellId(_loc_11);
                            _loc_15 = Pathfinding.findPath(_loc_4, _loc_14, _loc_13).getCells();
                            _loc_16 = new Selection();
                            _loc_16.renderer = new ZoneDARenderer();
                            _loc_16.color = new Color(26112);
                            _loc_16.zone = new Custom(_loc_15);
                            SelectionManager.getInstance().addSelection(_loc_16, "CellsForPath");
                            SelectionManager.getInstance().update("CellsForPath");
                        }
                    }
                    break;
                }
                case "debugcellsinline":
                {
                    if (param3.length != 2)
                    {
                        param1.output("Arguments needed : cell and cell");
                    }
                    else if (param3.length == 2)
                    {
                        _loc_17 = uint(param3[0]);
                        _loc_18 = MapPoint.fromCellId(_loc_17);
                        _loc_19 = uint(param3[1]);
                        _loc_20 = MapPoint.fromCellId(_loc_19);
                        _loc_21 = Dofus1Line.getLine(_loc_18.x, _loc_18.y, 0, _loc_20.x, _loc_20.y, 0);
                        _loc_8 = new Selection();
                        _loc_10 = new Vector.<uint>;
                        _loc_22 = 0;
                        while (_loc_22 < _loc_21.length)
                        {
                            
                            _loc_10.push(MapPoint.fromCoords(_loc_21[_loc_22].x, _loc_21[_loc_22].y).cellId);
                            _loc_22++;
                        }
                        _loc_8.renderer = new ZoneDARenderer();
                        _loc_8.color = new Color(26112);
                        _loc_8.zone = new Custom(_loc_10);
                        SelectionManager.getInstance().addSelection(_loc_8, "CellsFreeForLOS");
                        SelectionManager.getInstance().update("CellsFreeForLOS");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "debuglos":
                {
                    return "Display all cells which have LOS with the given cell.";
                }
                case "tracepath":
                {
                    return "Display all cells of the path between the start and the end.";
                }
                case "debugcellsinline":
                {
                    return "Display all cells of line between the start and the end.";
                }
                default:
                {
                    break;
                }
            }
            return "Unknown command";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
