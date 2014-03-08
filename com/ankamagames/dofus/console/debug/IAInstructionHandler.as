package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import __AS3__.vec.Vector;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.map.LosDetector;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.jerakine.utils.display.Dofus1Line;
   
   public class IAInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function IAInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc5_:uint = 0;
         var _loc6_:MapPoint = null;
         var _loc7_:uint = 0;
         var _loc8_:Selection = null;
         var _loc9_:Lozenge = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:MapPoint = null;
         var _loc14_:MapPoint = null;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:Selection = null;
         var _loc17_:uint = 0;
         var _loc18_:MapPoint = null;
         var _loc19_:uint = 0;
         var _loc20_:MapPoint = null;
         var _loc21_:Array = null;
         var _loc22_:* = 0;
         var _loc4_:IDataMapProvider = DataMapProvider.getInstance();
         switch(param2)
         {
            case "debuglos":
               if(param3.length != 2)
               {
                  param1.output("Arguments needed : cell and range");
               }
               else
               {
                  if(param3.length == 2)
                  {
                     _loc5_ = uint(param3[0]);
                     _loc6_ = MapPoint.fromCellId(_loc5_);
                     _loc7_ = uint(param3[1]);
                     _loc8_ = new Selection();
                     _loc9_ = new Lozenge(0,_loc7_,_loc4_);
                     _loc10_ = _loc9_.getCells(_loc5_);
                     _loc8_.renderer = new ZoneDARenderer();
                     _loc8_.color = new Color(26112);
                     _loc8_.zone = new Custom(LosDetector.getCell(_loc4_,_loc10_,_loc6_));
                     SelectionManager.getInstance().addSelection(_loc8_,"CellsFreeForLOS");
                     SelectionManager.getInstance().update("CellsFreeForLOS");
                  }
               }
               break;
            case "tracepath":
               if(param3.length != 2)
               {
                  param1.output("Arguments needed : start and end of the path");
               }
               else
               {
                  if(param3.length == 2)
                  {
                     _loc11_ = uint(param3[0]);
                     _loc12_ = uint(param3[1]);
                     _loc13_ = MapPoint.fromCellId(_loc12_);
                     if(_loc4_.height == 0 || _loc4_.width == 0 || !_loc4_.pointMov(_loc13_.x,_loc13_.y,true))
                     {
                        param1.output("Problem with the map or the end.");
                     }
                     else
                     {
                        _loc14_ = MapPoint.fromCellId(_loc11_);
                        _loc15_ = Pathfinding.findPath(_loc4_,_loc14_,_loc13_).getCells();
                        _loc16_ = new Selection();
                        _loc16_.renderer = new ZoneDARenderer();
                        _loc16_.color = new Color(26112);
                        _loc16_.zone = new Custom(_loc15_);
                        SelectionManager.getInstance().addSelection(_loc16_,"CellsForPath");
                        SelectionManager.getInstance().update("CellsForPath");
                     }
                  }
               }
               break;
            case "debugcellsinline":
               if(param3.length != 2)
               {
                  param1.output("Arguments needed : cell and cell");
               }
               else
               {
                  if(param3.length == 2)
                  {
                     _loc17_ = uint(param3[0]);
                     _loc18_ = MapPoint.fromCellId(_loc17_);
                     _loc19_ = uint(param3[1]);
                     _loc20_ = MapPoint.fromCellId(_loc19_);
                     _loc21_ = Dofus1Line.getLine(_loc18_.x,_loc18_.y,0,_loc20_.x,_loc20_.y,0);
                     _loc8_ = new Selection();
                     _loc10_ = new Vector.<uint>();
                     _loc22_ = 0;
                     while(_loc22_ < _loc21_.length)
                     {
                        _loc10_.push(MapPoint.fromCoords(_loc21_[_loc22_].x,_loc21_[_loc22_].y).cellId);
                        _loc22_++;
                     }
                     _loc8_.renderer = new ZoneDARenderer();
                     _loc8_.color = new Color(26112);
                     _loc8_.zone = new Custom(_loc10_);
                     SelectionManager.getInstance().addSelection(_loc8_,"CellsFreeForLOS");
                     SelectionManager.getInstance().update("CellsFreeForLOS");
                  }
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "debuglos":
               return "Display all cells which have LOS with the given cell.";
            case "tracepath":
               return "Display all cells of the path between the start and the end.";
            case "debugcellsinline":
               return "Display all cells of line between the start and the end.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
