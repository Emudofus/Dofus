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
   import com.ankamagames.atouin.types.DebugToolTip;
   import com.ankamagames.atouin.managers.SelectionManager;
   
   public class DisplayMapInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function DisplayMapInstructionHandler()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisplayMapInstructionHandler));
      
      private var _console:ConsoleHandler;
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:WorldPoint = null;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         this._console = param1;
         switch(param2)
         {
            case "displaymapdebug":
            case "displaymap":
               if(!param3[0])
               {
                  param1.output("Error : need mapId or map location as first parameter");
                  return;
               }
               _loc4_ = param3.length > 1?Hex.toArray(Hex.fromString(param3[1])):null;
               if(_loc4_)
               {
                  _loc4_.position = 0;
               }
               if(param3[0].indexOf(",") == -1)
               {
                  MapDisplayManager.getInstance().display(getWorldPointFromMapId(param3[0]),false,_loc4_);
               }
               else
               {
                  MapDisplayManager.getInstance().display(WorldPoint.fromCoords(0,param3[0].split(",")[0],param3[0].split(",")[1]),false,_loc4_);
               }
               break;
            case "getmapcoord":
               param1.output("Map world point for " + param3[0] + " : " + getWorldPointFromMapId(int(param3[0])).x + "/" + getWorldPointFromMapId(int(param3[0])).y + " (world : " + WorldPoint.fromMapId(int(param3[0])).worldId + ")");
               break;
            case "getmapid":
               param1.output("Map id : " + getMapIdFromCoord(int(param3[0]),parseInt(param3[1]),parseInt(param3[2])));
               break;
            case "testatouin":
               Atouin.getInstance().display(new WorldPoint());
               break;
            case "mapid":
               _loc5_ = MapDisplayManager.getInstance().currentMapPoint;
               if(_loc5_ is WorldPointWrapper)
               {
                  _loc6_ = "Current map : " + _loc5_.x + "/" + _loc5_.y + " (relative : " + WorldPointWrapper(_loc5_).outdoorX + "/" + WorldPointWrapper(_loc5_).outdoorY + "), map id : " + _loc5_.mapId;
               }
               else
               {
                  _loc6_ = "Current map : " + _loc5_.x + "/" + _loc5_.y + ", map id : " + _loc5_.mapId;
               }
               param1.output(_loc6_);
               break;
            case "showcellid":
               Atouin.getInstance().options.showCellIdOnOver = !Atouin.getInstance().options.showCellIdOnOver;
               param1.output("showCellIdOnOver : " + Atouin.getInstance().options.showCellIdOnOver);
               InteractiveCellManager.getInstance().setInteraction(true,Atouin.getInstance().options.showCellIdOnOver,Atouin.getInstance().options.showCellIdOnOver);
               if(!Atouin.getInstance().options.showCellIdOnOver)
               {
                  if(DebugToolTip.getInstance().parent)
                  {
                     DebugToolTip.getInstance().parent.removeChild(DebugToolTip.getInstance());
                  }
                  SelectionManager.getInstance().getSelection("infoOverCell").remove();
               }
               break;
            case "playerjump":
               Atouin.getInstance().options.virtualPlayerJump = !Atouin.getInstance().options.virtualPlayerJump;
               param1.output("playerJump : " + Atouin.getInstance().options.virtualPlayerJump);
               break;
            case "showtransitions":
               Atouin.getInstance().options.showTransitions = !Atouin.getInstance().options.showTransitions;
               break;
            case "groundcache":
               if(param3.length)
               {
                  _loc7_ = int(param3[0]);
                  Atouin.getInstance().options.groundCacheMode = _loc7_;
               }
               else
               {
                  _loc7_ = Atouin.getInstance().options.groundCacheMode;
               }
               if(_loc7_ == 0)
               {
                  param1.output("Ground cache : disabled");
               }
               else if(_loc7_ == 1)
               {
                  param1.output("Ground cache : High");
               }
               else if(_loc7_ == 2)
               {
                  param1.output("Ground cache : Medium");
               }
               else if(_loc7_ == 3)
               {
                  param1.output("Ground cache : Low");
               }
               
               
               
               break;
         }
      }
      
      public function getHelp(param1:String) : String
      {
         switch(param1)
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
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
      {
         return [];
      }
   }
}
