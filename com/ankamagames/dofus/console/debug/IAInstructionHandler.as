﻿package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.types.zones.Lozenge;
    import __AS3__.vec.Vector;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.map.IDataMapProvider;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.jerakine.map.LosDetector;
    import com.ankamagames.jerakine.pathfinding.Pathfinding;
    import com.ankamagames.jerakine.utils.display.Dofus1Line;
    import com.ankamagames.jerakine.utils.display.Dofus2Line;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import __AS3__.vec.*;

    public class IAInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var s:Selection;
            var cell:uint;
            var cellPoint:MapPoint;
            var range:uint;
            var cellsSelection:Selection;
            var lozenge:Lozenge;
            var cells:Vector.<uint>;
            var start:uint;
            var end:uint;
            var endPoint:MapPoint;
            var _local_15:MapPoint;
            var _local_16:Vector.<uint>;
            var _local_17:Selection;
            var fromCell:uint;
            var fromPoint:MapPoint;
            var toCell:uint;
            var toPoint:MapPoint;
            var cellsInLine:*;
            var i:int;
            var map:IDataMapProvider = DataMapProvider.getInstance();
            switch (cmd)
            {
                case "debuglos":
                    if (args.length != 2)
                    {
                        s = SelectionManager.getInstance().getSelection("CellsFreeForLOS");
                        if (s)
                        {
                            s.remove();
                            console.output("Selection cleared");
                        }
                        else
                        {
                            console.output("Arguments needed : cell and range");
                        };
                    }
                    else
                    {
                        if (args.length == 2)
                        {
                            cell = uint(args[0]);
                            cellPoint = MapPoint.fromCellId(cell);
                            range = uint(args[1]);
                            cellsSelection = new Selection();
                            lozenge = new Lozenge(0, range, map);
                            cells = lozenge.getCells(cell);
                            cellsSelection.renderer = new ZoneDARenderer();
                            cellsSelection.color = new Color(0x6600);
                            cellsSelection.zone = new Custom(LosDetector.getCell(map, cells, cellPoint));
                            SelectionManager.getInstance().addSelection(cellsSelection, "CellsFreeForLOS");
                            SelectionManager.getInstance().update("CellsFreeForLOS");
                        };
                    };
                    return;
                case "calculatepath":
                case "tracepath":
                    if (args.length != 2)
                    {
                        s = SelectionManager.getInstance().getSelection("CellsForPath");
                        if (s)
                        {
                            s.remove();
                            console.output("Selection cleared");
                        }
                        else
                        {
                            console.output("Arguments needed : start and end of the path");
                        };
                    }
                    else
                    {
                        if (args.length == 2)
                        {
                            start = uint(args[0]);
                            end = uint(args[1]);
                            endPoint = MapPoint.fromCellId(end);
                            if ((((((map.height == 0)) || ((map.width == 0)))) || (!(map.pointMov(endPoint.x, endPoint.y, true)))))
                            {
                                console.output("Problem with the map or the end.");
                            }
                            else
                            {
                                _local_15 = MapPoint.fromCellId(start);
                                _local_16 = Pathfinding.findPath(map, _local_15, endPoint).getCells();
                                if (cmd == "calculatepath")
                                {
                                    console.output(("Path: " + _local_16.join(",")));
                                    return;
                                };
                                _local_17 = new Selection();
                                _local_17.renderer = new ZoneDARenderer();
                                _local_17.color = new Color(0x6600);
                                _local_17.zone = new Custom(_local_16);
                                SelectionManager.getInstance().addSelection(_local_17, "CellsForPath");
                                SelectionManager.getInstance().update("CellsForPath");
                            };
                        };
                    };
                    return;
                case "debugcellsinline":
                    if (args.length != 2)
                    {
                        s = SelectionManager.getInstance().getSelection("CellsFreeForLOS");
                        if (s)
                        {
                            s.remove();
                            console.output("Selection cleared");
                        }
                        else
                        {
                            console.output("Arguments needed : cell and cell");
                        };
                    }
                    else
                    {
                        if (args.length == 2)
                        {
                            fromCell = uint(args[0]);
                            fromPoint = MapPoint.fromCellId(fromCell);
                            toCell = uint(args[1]);
                            toPoint = MapPoint.fromCellId(toCell);
                            cellsInLine = ((Dofus1Line.useDofus2Line) ? Dofus2Line.getLine(fromPoint.cellId, toPoint.cellId) : Dofus1Line.getLine(fromPoint.x, fromPoint.y, 0, toPoint.x, toPoint.y, 0));
                            cellsSelection = new Selection();
                            cells = new Vector.<uint>();
                            i = 0;
                            while (i < cellsInLine.length)
                            {
                                cells.push(MapPoint.fromCoords(cellsInLine[i].x, cellsInLine[i].y).cellId);
                                i++;
                            };
                            cellsSelection.renderer = new ZoneDARenderer();
                            cellsSelection.color = new Color(0x6600);
                            cellsSelection.zone = new Custom(cells);
                            SelectionManager.getInstance().addSelection(cellsSelection, "CellsFreeForLOS");
                            SelectionManager.getInstance().update("CellsFreeForLOS");
                        };
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "debuglos":
                    return ("Display all cells which have LOS with the given cell. No argument will clear the selection if any.");
                case "calculatepath":
                    return ("List all cells of the path between two cellIds.");
                case "tracepath":
                    return ("Display all cells of the path between two cellIds. No argument will clear the selection if any.");
                case "debugcellsinline":
                    return ("Display all cells of line between two cellIds. No argument will clear the selection if any.");
            };
            return ("Unknown command");
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

