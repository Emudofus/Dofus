package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.types.positions.WorldPoint;
    import com.hurlant.util.Hex;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.utils.map.getWorldPointFromMapId;
    import com.ankamagames.atouin.utils.map.getMapIdFromCoord;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
    import com.ankamagames.atouin.managers.InteractiveCellManager;

    public class DisplayMapInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayMapInstructionHandler));

        private var _console:ConsoleHandler;


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:ByteArray;
            var _local_5:WorldPoint;
            var _local_6:String;
            var _local_7:int;
            this._console = console;
            switch (cmd)
            {
                case "displaymapdebug":
                case "displaymap":
                    if (!(args[0]))
                    {
                        console.output("Error : need mapId or map location as first parameter");
                        return;
                    };
                    _local_4 = (((args.length > 1)) ? Hex.toArray(Hex.fromString(args[1])) : null);
                    if (_local_4)
                    {
                        _local_4.position = 0;
                    };
                    if (args[0].indexOf(",") == -1)
                    {
                        MapDisplayManager.getInstance().display(getWorldPointFromMapId(args[0]), false, _local_4);
                    }
                    else
                    {
                        MapDisplayManager.getInstance().display(WorldPoint.fromCoords(0, args[0].split(",")[0], args[0].split(",")[1]), false, _local_4);
                    };
                    return;
                case "getmapcoord":
                    console.output((((((((("Map world point for " + args[0]) + " : ") + getWorldPointFromMapId(int(args[0])).x) + "/") + getWorldPointFromMapId(int(args[0])).y) + " (world : ") + WorldPoint.fromMapId(int(args[0])).worldId) + ")"));
                    return;
                case "getmapid":
                    console.output(("Map id : " + getMapIdFromCoord(int(args[0]), parseInt(args[1]), parseInt(args[2]))));
                    return;
                case "testatouin":
                    Atouin.getInstance().display(new WorldPoint());
                    return;
                case "mapid":
                    _local_5 = MapDisplayManager.getInstance().currentMapPoint;
                    if ((_local_5 is WorldPointWrapper))
                    {
                        _local_6 = ((((((((("Current map : " + _local_5.x) + "/") + _local_5.y) + " (relative : ") + WorldPointWrapper(_local_5).outdoorX) + "/") + WorldPointWrapper(_local_5).outdoorY) + "), map id : ") + _local_5.mapId);
                    }
                    else
                    {
                        _local_6 = ((((("Current map : " + _local_5.x) + "/") + _local_5.y) + ", map id : ") + _local_5.mapId);
                    };
                    console.output(_local_6);
                    return;
                case "showcellid":
                    Atouin.getInstance().options.showCellIdOnOver = !(Atouin.getInstance().options.showCellIdOnOver);
                    console.output(("showCellIdOnOver : " + Atouin.getInstance().options.showCellIdOnOver));
                    InteractiveCellManager.getInstance().setInteraction(true, Atouin.getInstance().options.showCellIdOnOver, Atouin.getInstance().options.showCellIdOnOver);
                    return;
                case "playerjump":
                    Atouin.getInstance().options.virtualPlayerJump = !(Atouin.getInstance().options.virtualPlayerJump);
                    console.output(("playerJump : " + Atouin.getInstance().options.virtualPlayerJump));
                    return;
                case "showtransitions":
                    Atouin.getInstance().options.showTransitions = !(Atouin.getInstance().options.showTransitions);
                    return;
                case "groundcache":
                    if (args.length)
                    {
                        _local_7 = int(args[0]);
                        Atouin.getInstance().options.groundCacheMode = _local_7;
                    }
                    else
                    {
                        _local_7 = Atouin.getInstance().options.groundCacheMode;
                    };
                    if (_local_7 == 0)
                    {
                        console.output("Ground cache : disabled");
                    }
                    else
                    {
                        if (_local_7 == 1)
                        {
                            console.output("Ground cache : High");
                        }
                        else
                        {
                            if (_local_7 == 2)
                            {
                                console.output("Ground cache : Medium");
                            }
                            else
                            {
                                if (_local_7 == 3)
                                {
                                    console.output("Ground cache : Low");
                                };
                            };
                        };
                    };
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "displaymapdebug":
                    return ("Display a given map with debug filters activated. These filters apply a different color on every map layers.");
                case "displaymap":
                    return ("Display a given map.");
                case "getmapcoord":
                    return ("Get the world point for a given map id.");
                case "getmapid":
                    return ("Get the map id for a given world point.");
                case "showtransitions":
                    return ("Toggle map transitions highlighting");
                case "groundcache":
                    return ("Set ground cache.\n<li>0 --> Disabled</li><li>1 --> High</li><li>2 --> Medium</li><li>3 --> Low</li>");
                case "mapid":
                    return ("Get the current map id.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.debug

