package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.utils.ByteArray;
   import com.hurlant.util.Hex;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.utils.map.getWorldPointFromMapId;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.atouin.utils.map.getMapIdFromCoord;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   
   public class DisplayMapInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function DisplayMapInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayMapInstructionHandler));
      
      private var _console:ConsoleHandler;
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var decryptionKey:ByteArray = null;
         var cacheMode:* = 0;
         this._console = console;
         switch(cmd)
         {
            case "displaymapdebug":
            case "displaymap":
               if(!args[0])
               {
                  console.output("Error : need mapId or map location as first parameter");
                  return;
               }
               decryptionKey = args.length > 1?Hex.toArray(Hex.fromString(args[1])):null;
               if(decryptionKey)
               {
                  decryptionKey.position = 0;
               }
               if(args[0].indexOf(",") == -1)
               {
                  MapDisplayManager.getInstance().display(getWorldPointFromMapId(args[0]),false,decryptionKey);
               }
               else
               {
                  MapDisplayManager.getInstance().display(WorldPoint.fromCoords(0,args[0].split(",")[0],args[0].split(",")[1]),false,decryptionKey);
               }
               break;
            case "getmapcoord":
               console.output("Map world point for " + args[0] + " : " + getWorldPointFromMapId(int(args[0])).x + "/" + getWorldPointFromMapId(int(args[0])).y + " (world : " + WorldPoint.fromMapId(int(args[0])).worldId + ")");
               break;
            case "getmapid":
               console.output("Map id : " + getMapIdFromCoord(int(args[0]),parseInt(args[1]),parseInt(args[2])));
               break;
            case "testatouin":
               Atouin.getInstance().display(new WorldPoint());
               break;
            case "mapid":
               console.output("Current map : " + MapDisplayManager.getInstance().currentMapPoint.x + "/" + MapDisplayManager.getInstance().currentMapPoint.y + " (map id : " + MapDisplayManager.getInstance().currentMapPoint.mapId + ")");
               break;
            case "showcellid":
               Atouin.getInstance().options.showCellIdOnOver = !Atouin.getInstance().options.showCellIdOnOver;
               console.output("showCellIdOnOver : " + Atouin.getInstance().options.showCellIdOnOver);
               InteractiveCellManager.getInstance().setInteraction(true,Atouin.getInstance().options.showCellIdOnOver,Atouin.getInstance().options.showCellIdOnOver);
               break;
            case "playerjump":
               Atouin.getInstance().options.virtualPlayerJump = !Atouin.getInstance().options.virtualPlayerJump;
               console.output("playerJump : " + Atouin.getInstance().options.virtualPlayerJump);
               break;
            case "showtransitions":
               Atouin.getInstance().options.showTransitions = !Atouin.getInstance().options.showTransitions;
               break;
            case "groundcache":
               if(args.length)
               {
                  cacheMode = int(args[0]);
                  Atouin.getInstance().options.groundCacheMode = cacheMode;
               }
               else
               {
                  cacheMode = Atouin.getInstance().options.groundCacheMode;
               }
               if(cacheMode == 0)
               {
                  console.output("Ground cache : disabled");
               }
               else
               {
                  if(cacheMode == 1)
                  {
                     console.output("Ground cache : High");
                  }
                  else
                  {
                     if(cacheMode == 2)
                     {
                        console.output("Ground cache : Medium");
                     }
                     else
                     {
                        if(cacheMode == 3)
                        {
                           console.output("Ground cache : Low");
                        }
                     }
                  }
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "displaymapdebug":
               return "Display a given map with debug filters activated. These filters apply a different color on every map layers.";
            case "displaymap":
               return "Display a given map.";
            case "getmapcoord":
               return "Get the world point for a given map id.";
            case "getmapid":
               return "Get the map id for a given world point.";
            case "showtransitions":
               return "Toggle map transitions highlighting";
            case "groundcache":
               return "Set ground cache.\n<li>0 --> Disabled</li><li>1 --> High</li><li>2 --> Medium</li><li>3 --> Low</li>";
            case "mapid":
               return "Get the current map id.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }
}
