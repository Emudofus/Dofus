package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Lozenge;
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
   
   public class IAInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function IAInstructionHandler()
      {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc5_:Selection = null;
         var _loc6_:uint = 0;
         var _loc7_:MapPoint = null;
         var _loc8_:uint = 0;
         var _loc9_:Selection = null;
         var _loc10_:Lozenge = null;
         var _loc11_:Vector.<uint> = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:MapPoint = null;
         var _loc15_:MapPoint = null;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:Selection = null;
         var _loc18_:uint = 0;
         var _loc19_:MapPoint = null;
         var _loc20_:uint = 0;
         var _loc21_:MapPoint = null;
         var _loc22_:* = undefined;
         var _loc23_:* = 0;
         var _loc4_:IDataMapProvider = DataMapProvider.getInstance();
         switch(param2)
         {
            case "debuglos":
               if(param3.length != 2)
               {
                  _loc5_ = SelectionManager.getInstance().getSelection("CellsFreeForLOS");
                  if(_loc5_)
                  {
                     _loc5_.remove();
                     param1.output("Selection cleared");
                  }
                  else
                  {
                     param1.output("Arguments needed : cell and range");
                  }
               }
               else if(param3.length == 2)
               {
                  _loc6_ = uint(param3[0]);
                  _loc7_ = MapPoint.fromCellId(_loc6_);
                  _loc8_ = uint(param3[1]);
                  _loc9_ = new Selection();
                  _loc10_ = new Lozenge(0,_loc8_,_loc4_);
                  _loc11_ = _loc10_.getCells(_loc6_);
                  _loc9_.renderer = new ZoneDARenderer();
                  _loc9_.color = new Color(26112);
                  _loc9_.zone = new Custom(LosDetector.getCell(_loc4_,_loc11_,_loc7_));
                  SelectionManager.getInstance().addSelection(_loc9_,"CellsFreeForLOS");
                  SelectionManager.getInstance().update("CellsFreeForLOS");
               }
               
               break;
            case "calculatepath":
            case "tracepath":
               if(param3.length != 2)
               {
                  _loc5_ = SelectionManager.getInstance().getSelection("CellsForPath");
                  if(_loc5_)
                  {
                     _loc5_.remove();
                     param1.output("Selection cleared");
                  }
                  else
                  {
                     param1.output("Arguments needed : start and end of the path");
                  }
               }
               else if(param3.length == 2)
               {
                  _loc12_ = uint(param3[0]);
                  _loc13_ = uint(param3[1]);
                  _loc14_ = MapPoint.fromCellId(_loc13_);
                  if(_loc4_.height == 0 || _loc4_.width == 0 || !_loc4_.pointMov(_loc14_.x,_loc14_.y,true))
                  {
                     param1.output("Problem with the map or the end.");
                  }
                  else
                  {
                     _loc15_ = MapPoint.fromCellId(_loc12_);
                     _loc16_ = Pathfinding.findPath(_loc4_,_loc15_,_loc14_).getCells();
                     if(param2 == "calculatepath")
                     {
                        param1.output("Path: " + _loc16_.join(","));
                        break;
                     }
                     _loc17_ = new Selection();
                     _loc17_.renderer = new ZoneDARenderer();
                     _loc17_.color = new Color(26112);
                     _loc17_.zone = new Custom(_loc16_);
                     SelectionManager.getInstance().addSelection(_loc17_,"CellsForPath");
                     SelectionManager.getInstance().update("CellsForPath");
                  }
               }
               
               break;
            case "debugcellsinline":
               if(param3.length != 2)
               {
                  _loc5_ = SelectionManager.getInstance().getSelection("CellsFreeForLOS");
                  if(_loc5_)
                  {
                     _loc5_.remove();
                     param1.output("Selection cleared");
                  }
                  else
                  {
                     param1.output("Arguments needed : cell and cell");
                  }
               }
               else if(param3.length == 2)
               {
                  _loc18_ = uint(param3[0]);
                  _loc19_ = MapPoint.fromCellId(_loc18_);
                  _loc20_ = uint(param3[1]);
                  _loc21_ = MapPoint.fromCellId(_loc20_);
                  _loc22_ = Dofus1Line.useDofus2Line?Dofus2Line.getLine(_loc19_.cellId,_loc21_.cellId):Dofus1Line.getLine(_loc19_.x,_loc19_.y,0,_loc21_.x,_loc21_.y,0);
                  _loc9_ = new Selection();
                  _loc11_ = new Vector.<uint>();
                  _loc23_ = 0;
                  while(_loc23_ < _loc22_.length)
                  {
                     _loc11_.push(MapPoint.fromCoords(_loc22_[_loc23_].x,_loc22_[_loc23_].y).cellId);
                     _loc23_++;
                  }
                  _loc9_.renderer = new ZoneDARenderer();
                  _loc9_.color = new Color(26112);
                  _loc9_.zone = new Custom(_loc11_);
                  SelectionManager.getInstance().addSelection(_loc9_,"CellsFreeForLOS");
                  SelectionManager.getInstance().update("CellsFreeForLOS");
               }
               
               break;
         }
      }
      
      public function getHelp(param1:String) : String
      {
         switch(param1)
         {
            case "debuglos":
               return "Display all cells which have LOS with the given cell. No argument will clear the selection if any.";
            case "calculatepath":
               return "List all cells of the path between two cellIds.";
            case "tracepath":
               return "Display all cells of the path between two cellIds. No argument will clear the selection if any.";
            case "debugcellsinline":
               return "Display all cells of line between two cellIds. No argument will clear the selection if any.";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
      {
         return [];
      }
   }
}
