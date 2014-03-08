package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import __AS3__.vec.Vector;
   import flash.display.Sprite;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.types.CellReference;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.renderers.ZoneClipRenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.jerakine.types.zones.ZRectangle;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import flash.system.ApplicationDomain;
   
   public class TacticModeManager extends Object
   {
      
      public function TacticModeManager(param1:PrivateClass) {
         super();
         this._dmp = DataMapProvider.getInstance();
      }
      
      private static var SWF_LIB:String = XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets_tacticmod.swf");
      
      private static var TILES_REACHABLE:Array = ["Dalle01"];
      
      private static var TILES_NO_MVT:Array = ["BlocageMvt"];
      
      private static var TILES_NO_VIEW:Array = ["BlocageLDV"];
      
      private static var SHOW_BLOC_MOVE:Boolean = false;
      
      private static var SHOW_BACKGROUND:Boolean = false;
      
      private static var _self:TacticModeManager;
      
      private static const DEBUG_FIGHT_MODE:int = 0;
      
      private static const DEBUG_RP_MODE:int = 1;
      
      public static function getInstance() : TacticModeManager {
         if(_self == null)
         {
            _self = new TacticModeManager(new PrivateClass());
         }
         return _self;
      }
      
      private var _roleplayInteractivesFrame:RoleplayInteractivesFrame;
      
      private var _tacticReachableRangeSelection:Selection;
      
      private var _tacticUnreachableRangeSelection:Selection;
      
      private var _tacticOtherSelection:Selection;
      
      private var _debugCellId:uint;
      
      private var _debugMode:Boolean = false;
      
      private var _debugCache:Boolean = true;
      
      private var _debugType:int;
      
      private var _showFightZone:Boolean = false;
      
      private var _fightZone:Selection;
      
      private var _showInteractiveCells:Boolean = false;
      
      private var _interactiveCellsZone:Selection;
      
      private var _showScaleZone:Boolean = false;
      
      private var _scaleZone:Selection;
      
      private var _flattenCells:Boolean;
      
      private var _showBlockMvt:Boolean = true;
      
      private var _dmp:DataMapProvider;
      
      private var _cellsRef:Array;
      
      private var _cellsData:Array;
      
      private var _cellZones:Vector.<int>;
      
      private var _currentNbZone:int = 0;
      
      private var _zones:Array;
      
      private var _tacticModeActivated:Boolean = false;
      
      private var _currentMapId:uint;
      
      private var _nbMov:int;
      
      private var _nbLos:int;
      
      private var _reachablePath:Vector.<uint>;
      
      private var _unreachablePath:Vector.<uint>;
      
      private var _otherPath:Vector.<uint>;
      
      private var _background:Sprite;
      
      public function show(param1:WorldPointWrapper, param2:Boolean=false) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:CellData = null;
         var _loc7_:CellReference = null;
         var _loc8_:* = 0;
         var _loc9_:MapPoint = null;
         var _loc10_:DisplayObjectContainer = null;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc14_:* = false;
         var _loc15_:Array = null;
         var _loc16_:Object = null;
         var _loc17_:Point = null;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:Object = null;
         if(!param2)
         {
            this._debugMode = false;
            SHOW_BLOC_MOVE = false;
         }
         else
         {
            this._debugMode = true;
            SHOW_BLOC_MOVE = true;
         }
         if(this._roleplayInteractivesFrame == null)
         {
            this._roleplayInteractivesFrame = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
         }
         if(this._tacticModeActivated)
         {
            return;
         }
         this._tacticModeActivated = true;
         KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode,true);
         if((this._debugMode) && (this._debugCache) || (((!this._debugMode) && (this._currentMapId)) && (this._currentMapId == param1.mapId)) && (this._cellsRef.length > 0))
         {
            if(this._cellsRef == null || this._cellsRef[0] == null)
            {
               this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
               this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
            }
            _loc4_ = this._cellsRef.length;
            if(!this._debugMode || (this._debugMode) && (this._flattenCells))
            {
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  if(this._cellsRef[_loc3_] != null)
                  {
                     this._cellsRef[_loc3_].visible = true;
                     this._cellsRef[_loc3_].visible = false;
                     if(this._cellsData[_loc3_].floor != 0)
                     {
                        _loc10_ = InteractiveCellManager.getInstance().getCell(this._cellsRef[_loc3_].id);
                        _loc10_.y = this._cellsRef[_loc3_].elevation + this._cellsData[_loc3_].floor;
                        this.updateEntitiesOnCell(_loc3_);
                     }
                  }
                  _loc3_ = _loc3_ + 1;
               }
            }
            SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection,"tacticReachableRange",0);
            if(!this._debugMode || (this._showBlockMvt))
            {
               SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection,"tacticUnreachableRange",0);
            }
            if((SHOW_BLOC_MOVE) && this._nbMov > this._nbLos)
            {
               SelectionManager.getInstance().addSelection(this._tacticOtherSelection,"tacticOtherRange",0);
            }
            else
            {
               if((!SHOW_BLOC_MOVE) && (this._tacticOtherSelection) && !(SelectionManager.getInstance().getSelection("tacticOtherRange") == null))
               {
                  SelectionManager.getInstance().getSelection("tacticOtherRange").remove();
               }
            }
            if((this._debugMode) && (this._fightZone))
            {
               if(this._showFightZone)
               {
                  SelectionManager.getInstance().addSelection(this._fightZone,"debugSelection",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("debugSelection").remove();
               }
            }
            if((this._debugMode) && (this._scaleZone))
            {
               if(this._showScaleZone)
               {
                  SelectionManager.getInstance().addSelection(this._scaleZone,"scaleZone",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("scaleZone").remove();
               }
            }
            if((this._debugMode) && (this._interactiveCellsZone))
            {
               if(this._showInteractiveCells)
               {
                  SelectionManager.getInstance().addSelection(this._interactiveCellsZone,"interactiveCellsZone",this._debugCellId);
               }
               else
               {
                  SelectionManager.getInstance().getSelection("interactiveCellsZone").remove();
               }
            }
         }
         else
         {
            this._currentMapId = param1.mapId;
            this._reachablePath = new Vector.<uint>();
            this._unreachablePath = new Vector.<uint>();
            this._otherPath = new Vector.<uint>();
            _loc5_ = new Vector.<uint>();
            this._cellsRef = MapDisplayManager.getInstance().getDataMapContainer().getCell();
            this._cellsData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
            _loc4_ = this._cellsRef.length;
            this._cellZones = new Vector.<int>(_loc4_);
            this._currentNbZone = 0;
            this._nbMov = 0;
            this._nbLos = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc7_ = this._cellsRef[_loc3_];
               _loc6_ = this._cellsData[_loc3_];
               _loc7_.visible = true;
               _loc7_.visible = false;
               if(!_loc7_.isDisabled)
               {
                  _loc8_ = this.getCellZone(_loc3_);
                  _loc9_ = MapPoint.fromCellId(_loc3_);
                  _loc11_ = (this._dmp.pointMov(_loc9_.x,_loc9_.y)) && ((this._debugMode) || !this._debugMode && !this._dmp.farmCell(_loc9_.x,_loc9_.y));
                  _loc12_ = this._dmp.pointLos(_loc9_.x,_loc9_.y);
                  _loc13_ = _loc6_.nonWalkableDuringFight;
                  _loc14_ = _loc6_.nonWalkableDuringRP;
                  if(_loc6_.moveZone)
                  {
                     _loc5_.push(_loc7_.id);
                  }
                  if((!this._debugMode || (this._debugMode) && (this._flattenCells)) && !(_loc6_.floor == 0))
                  {
                     _loc10_ = InteractiveCellManager.getInstance().getCell(_loc7_.id);
                     _loc10_.y = _loc7_.elevation + _loc6_.floor;
                     this.updateEntitiesOnCell(_loc3_);
                  }
                  if(this.canMoveOnThisCell(_loc11_,_loc13_,_loc14_))
                  {
                     if(_loc8_ > 0)
                     {
                        this._cellZones[_loc3_] = _loc8_;
                     }
                     else
                     {
                        this._currentNbZone++;
                        this._cellZones[_loc3_] = this._currentNbZone;
                     }
                  }
                  else
                  {
                     if((_loc12_) && !this.canMoveOnThisCell(_loc11_,_loc13_,_loc14_))
                     {
                        this._cellZones[_loc3_] = 0;
                     }
                     else
                     {
                        if(!_loc12_ && !this.canMoveOnThisCell(_loc11_,_loc13_,_loc14_))
                        {
                           this._cellZones[_loc3_] = -1;
                        }
                     }
                  }
               }
               _loc3_ = _loc3_ + 1;
            }
            this.updateCellWithRealCellZone();
            _loc15_ = new Array();
            this._zones = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               switch(this._cellZones[_loc3_])
               {
                  case -1:
                     this._unreachablePath.push(_loc3_);
                     break;
                  case 0:
                     if((SHOW_BLOC_MOVE) && (this.getInformations(_loc3_)[0]))
                     {
                        this._otherPath.push(_loc3_);
                        this._nbLos++;
                     }
                     break;
                  default:
                     if(_loc15_.indexOf(this._cellZones[_loc3_]) == -1)
                     {
                        _loc15_.push(this._cellZones[_loc3_]);
                     }
                     _loc17_ = CellIdConverter.cellIdToCoord(_loc3_);
                     if(this._zones[this._cellZones[_loc3_]] == null)
                     {
                        _loc16_ = new Object();
                        _loc16_.map = new Vector.<int>();
                        _loc16_.maxX = _loc17_.x;
                        _loc16_.minX = _loc17_.x;
                        _loc16_.maxY = _loc17_.y;
                        _loc16_.minY = _loc17_.y;
                        this._zones[this._cellZones[_loc3_]] = _loc16_;
                     }
                     else
                     {
                        _loc16_ = this._zones[this._cellZones[_loc3_]];
                        if(_loc17_.x > _loc16_.maxX)
                        {
                           _loc16_.maxX = _loc17_.x;
                        }
                        if(_loc17_.x < _loc16_.minX)
                        {
                           _loc16_.minX = _loc17_.x;
                        }
                        if(_loc17_.y > _loc16_.maxY)
                        {
                           _loc16_.maxY = _loc17_.y;
                        }
                        if(_loc17_.y < _loc16_.minY)
                        {
                           _loc16_.minY = _loc17_.y;
                        }
                     }
                     this._zones[this._cellZones[_loc3_]].map.push(_loc3_);
                     if(this._reachablePath.indexOf(_loc3_) == -1)
                     {
                        this._reachablePath.push(_loc3_);
                     }
                     this._nbMov++;
               }
               _loc3_ = _loc3_ + 1;
            }
            this._currentNbZone = _loc15_.length;
            _loc15_ = null;
            for each (_loc22_ in this._zones)
            {
               if(!_loc20_)
               {
                  _loc20_ = _loc22_.maxX;
               }
               else
               {
                  _loc20_ = Math.max(_loc20_,_loc22_.maxX);
               }
               if(!_loc19_)
               {
                  _loc21_ = _loc22_.minX;
               }
               else
               {
                  _loc21_ = Math.min(_loc21_,_loc22_.minX);
               }
               if(!_loc18_)
               {
                  _loc18_ = _loc22_.maxY;
               }
               else
               {
                  _loc18_ = Math.max(_loc18_,_loc22_.maxY);
               }
               if(!_loc19_)
               {
                  _loc19_ = _loc22_.minY;
               }
               else
               {
                  _loc19_ = Math.min(_loc19_,_loc22_.minY);
               }
            }
            this.clearUnneededCells(_loc20_,_loc18_,_loc21_,_loc19_);
            this._tacticReachableRangeSelection = new Selection();
            this._tacticReachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER,SWF_LIB,TILES_REACHABLE,TILES_REACHABLE.length > 1?this._currentMapId:-1,SHOW_BLOC_MOVE);
            this._tacticReachableRangeSelection.zone = new Custom(this._reachablePath);
            SelectionManager.getInstance().addSelection(this._tacticReachableRangeSelection,"tacticReachableRange",0);
            if(!this._debugMode || (this._showBlockMvt))
            {
               this._tacticUnreachableRangeSelection = new Selection();
               this._tacticUnreachableRangeSelection.renderer = new ZoneClipRenderer(PlacementStrataEnums.STRATA_AREA,SWF_LIB,TILES_NO_VIEW,TILES_NO_VIEW.length > 1?this._currentMapId:-1,SHOW_BLOC_MOVE);
               this._tacticUnreachableRangeSelection.zone = new Custom(this._unreachablePath);
               SelectionManager.getInstance().addSelection(this._tacticUnreachableRangeSelection,"tacticUnreachableRange",0);
            }
            if(this._nbMov > this._nbLos && (SHOW_BLOC_MOVE) || (this._debugMode))
            {
               this._tacticOtherSelection = new Selection();
               this._tacticOtherSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._tacticOtherSelection.color = new Color(717337);
               this._tacticOtherSelection.zone = new Custom(this._otherPath);
            }
            if((this._debugMode) && (this._showScaleZone))
            {
               this._scaleZone = new Selection();
               this._scaleZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._scaleZone.color = new Color(5085175);
               this._scaleZone.zone = new Custom(_loc5_);
               SelectionManager.getInstance().addSelection(this._scaleZone,"scaleZone",this._debugCellId);
            }
            if((this._debugMode) && (this._showFightZone))
            {
               SelectionManager.getInstance().addSelection(this._fightZone,"debugSelection",this._debugCellId);
            }
            if((this._debugMode) && (this._showInteractiveCells))
            {
               this._interactiveCellsZone = new Selection();
               this._interactiveCellsZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._interactiveCellsZone.color = new Color(16777215);
               this._interactiveCellsZone.zone = new Custom(this._roleplayInteractivesFrame.getInteractiveElementsCells());
               SelectionManager.getInstance().addSelection(this._interactiveCellsZone,"interactiveCellsZone",this._debugCellId);
            }
         }
         MapDisplayManager.getInstance().hideBackgroundForTacticMode(true);
         if(SHOW_BACKGROUND)
         {
            this.loadBackground();
         }
      }
      
      private function canMoveOnThisCell(param1:Boolean, param2:Boolean, param3:Boolean) : Boolean {
         if(!param1)
         {
            return false;
         }
         if((!this._debugMode || (this._debugMode) && this._debugType == DEBUG_FIGHT_MODE) && (param2))
         {
            return false;
         }
         if((this._debugMode) && this._debugType == DEBUG_RP_MODE && (param3))
         {
            return false;
         }
         return true;
      }
      
      public function hide(param1:Boolean=false) : void {
         var _loc2_:Selection = null;
         var _loc3_:CellReference = null;
         var _loc4_:CellData = null;
         var _loc5_:* = 0;
         var _loc7_:DisplayObjectContainer = null;
         if(!this._tacticModeActivated)
         {
            return;
         }
         this._tacticModeActivated = false;
         if(!param1)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode,false);
         }
         if(SHOW_BACKGROUND)
         {
            this.removeBackground();
         }
         _loc2_ = SelectionManager.getInstance().getSelection("tacticReachableRange");
         if(_loc2_)
         {
            _loc2_.remove();
         }
         _loc2_ = SelectionManager.getInstance().getSelection("tacticUnreachableRange");
         if(_loc2_)
         {
            _loc2_.remove();
         }
         if(this._tacticOtherSelection != null)
         {
            _loc2_ = SelectionManager.getInstance().getSelection("tacticOtherRange");
            if(_loc2_)
            {
               _loc2_.remove();
            }
         }
         if(this._interactiveCellsZone != null)
         {
            _loc2_ = SelectionManager.getInstance().getSelection("interactiveCellsZone");
            if(_loc2_)
            {
               _loc2_.remove();
            }
         }
         if(this._scaleZone != null)
         {
            _loc2_ = SelectionManager.getInstance().getSelection("scaleZone");
            if(_loc2_)
            {
               _loc2_.remove();
            }
         }
         if(this._fightZone != null)
         {
            _loc2_ = SelectionManager.getInstance().getSelection("debugSelection");
            if(_loc2_)
            {
               _loc2_.remove();
            }
         }
         var _loc6_:int = this._cellsRef.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc3_ = this._cellsRef[_loc5_];
            if(_loc3_)
            {
               _loc4_ = this._cellsData[_loc5_];
               if(_loc3_)
               {
                  _loc3_.visible = true;
               }
               if(_loc4_.floor != 0)
               {
                  _loc7_ = InteractiveCellManager.getInstance().getCell(_loc3_.id);
                  _loc7_.y = _loc3_.elevation;
                  this.updateEntitiesOnCell(_loc5_);
               }
            }
            _loc5_++;
         }
         MapDisplayManager.getInstance().hideBackgroundForTacticMode(false);
      }
      
      private function updateEntitiesOnCell(param1:uint) : void {
         var _loc3_:AnimatedCharacter = null;
         var _loc4_:IEntity = null;
         var _loc2_:Array = EntitiesManager.getInstance().getEntitiesOnCell(param1);
         for each (_loc4_ in _loc2_)
         {
            _loc3_ = DofusEntities.getEntity(_loc4_.id) as AnimatedCharacter;
            if(_loc3_)
            {
               _loc3_.jump(_loc3_.position);
            }
         }
      }
      
      private function clearUnneededCells(param1:int, param2:int, param3:int, param4:int) : void {
         var _loc10_:uint = 0;
         var _loc12_:* = 0;
         var _loc14_:Array = null;
         var _loc5_:int = param1 - param3;
         var _loc6_:int = Math.abs(param4) + Math.abs(param2);
         var _loc7_:int = CellIdConverter.coordToCellId(_loc5_ / 2 + param3,_loc6_ / 2 + param4);
         var _loc8_:ZRectangle = new ZRectangle(0,_loc5_ / 2,_loc6_ / 2,null);
         var _loc9_:Vector.<uint> = _loc8_.getCells(_loc7_);
         if((this._debugMode) && (this._showFightZone))
         {
            this._fightZone = new Selection();
            this._fightZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._fightZone.color = new Color(16772608);
            this._fightZone.zone = _loc8_;
            this._debugCellId = _loc7_;
         }
         var _loc11_:Vector.<uint> = this._unreachablePath.concat();
         var _loc13_:int = _loc11_.length;
         _loc12_ = 0;
         while(_loc12_ < _loc13_)
         {
            _loc10_ = _loc11_[_loc12_];
            _loc14_ = this.getInformations(_loc10_);
            if((_loc14_[1]) || _loc9_.indexOf(_loc10_) == -1 && !_loc14_[0])
            {
               this._unreachablePath.splice(this._unreachablePath.indexOf(_loc10_),1);
            }
            _loc12_ = _loc12_ + 1;
         }
         _loc11_ = null;
      }
      
      private function updateCellWithRealCellZone() : void {
         var _loc1_:* = 0;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:Vector.<int> = null;
         var _loc6_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc7_:int = this._cellZones.length;
         var _loc8_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc1_ = this._cellZones[_loc6_];
            if(_loc1_ > 0)
            {
               _loc2_ = CellUtil.isLeftCol(_loc6_);
               _loc3_ = CellUtil.isRightCol(_loc6_);
               _loc4_ = CellUtil.isEvenRow(_loc6_);
               _loc5_ = new Vector.<int>();
               if(_loc6_ - 28 > 0 && this._cellZones[_loc6_ - 28] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_ - 28]);
               }
               if(!_loc3_ && _loc6_ + 1 < this._cellZones.length && this._cellZones[_loc6_ + 1] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_ + 1]);
               }
               if(_loc6_ + 28 < this._cellZones.length && this._cellZones[_loc6_ + 28] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_ + 28]);
               }
               if(!_loc2_ && _loc6_-1 > 0 && this._cellZones[_loc6_-1] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_-1]);
               }
               if((!_loc2_ || (_loc2_) && !_loc4_) && _loc6_ + 14 < this._cellZones.length && this._cellZones[_loc6_ + 14] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_ + 14]);
               }
               if((!_loc2_ || (_loc2_) && !_loc4_) && _loc6_ - 14 > 0 && this._cellZones[_loc6_ - 14] > 0)
               {
                  _loc5_.push(this._cellZones[_loc6_ - 14]);
               }
               if(_loc4_)
               {
                  if(!_loc2_ && _loc6_ + 13 < this._cellZones.length && this._cellZones[_loc6_ + 13] > 0)
                  {
                     _loc5_.push(this._cellZones[_loc6_ + 13]);
                  }
                  if(!_loc2_ && _loc6_ - 15 > 0 && this._cellZones[_loc6_ - 15] > 0)
                  {
                     _loc5_.push(this._cellZones[_loc6_ - 15]);
                  }
               }
               else
               {
                  if(!_loc3_ && _loc6_ - 13 > 0 && this._cellZones[_loc6_ - 13] > 0)
                  {
                     _loc5_.push(this._cellZones[_loc6_ - 13]);
                  }
                  if(!_loc3_ && _loc6_ + 15 < this._cellZones.length && this._cellZones[_loc6_ + 15] > 0)
                  {
                     _loc5_.push(this._cellZones[_loc6_ + 15]);
                  }
               }
               if(_loc5_.length > 0)
               {
                  _loc10_ = _loc5_.length;
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_)
                  {
                     if(!(_loc1_ == _loc5_[_loc9_]) && !this.containZone(_loc8_,_loc1_,_loc5_[_loc9_]))
                     {
                        _loc8_.push(
                           {
                              "z1":_loc1_,
                              "z2":_loc5_[_loc9_]
                           });
                     }
                     if(_loc5_[_loc9_] < _loc1_)
                     {
                        _loc1_ = _loc5_[_loc9_];
                     }
                     _loc9_ = _loc9_ + 1;
                  }
                  if(_loc1_ > 0)
                  {
                     this._cellZones[_loc6_] = _loc1_;
                     if(_loc6_ - 28 > 0 && this._cellZones[_loc6_ - 28] > 0)
                     {
                        this._cellZones[_loc6_ - 28] = _loc1_;
                     }
                     if(_loc6_ - 13 > 0 && this._cellZones[_loc6_ - 13] > 0)
                     {
                        this._cellZones[_loc6_ - 13] = _loc1_;
                     }
                     if(_loc6_ + 1 < this._cellZones.length && this._cellZones[_loc6_ + 1] > 0)
                     {
                        this._cellZones[_loc6_ + 1] = _loc1_;
                     }
                     if(_loc6_ + 15 < this._cellZones.length && this._cellZones[_loc6_ + 15] > 0)
                     {
                        this._cellZones[_loc6_ + 15] = _loc1_;
                     }
                     if(_loc6_ + 28 < this._cellZones.length && this._cellZones[_loc6_ + 28] > 0)
                     {
                        this._cellZones[_loc6_ + 28] = _loc1_;
                     }
                     if(_loc6_ + 14 < this._cellZones.length && this._cellZones[_loc6_ + 14] > 0)
                     {
                        this._cellZones[_loc6_ + 14] = _loc1_;
                     }
                     if(_loc6_-1 > 0 && this._cellZones[_loc6_-1] > 0)
                     {
                        this._cellZones[_loc6_-1] = _loc1_;
                     }
                  }
               }
            }
            _loc6_ = _loc6_ + 1;
         }
         if(_loc8_.length > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc8_.length)
            {
               if(!(this._cellZones.indexOf(_loc8_[_loc9_].z1) == -1) && !(this._cellZones.indexOf(_loc8_[_loc9_].z2) == -1))
               {
                  _loc12_ = Math.min(_loc8_[_loc9_].z1,_loc8_[_loc9_].z2);
                  _loc13_ = Math.max(_loc8_[_loc9_].z1,_loc8_[_loc9_].z2);
                  _loc11_ = 0;
                  while(_loc11_ < _loc7_)
                  {
                     if(this._cellZones[_loc11_] == _loc13_)
                     {
                        this._cellZones[_loc11_] = _loc12_;
                     }
                     _loc11_ = _loc11_ + 1;
                  }
               }
               _loc9_ = _loc9_ + 1;
            }
            _loc8_ = null;
         }
      }
      
      private function containZone(param1:Array, param2:int, param3:int) : Boolean {
         var _loc4_:* = 0;
         var _loc5_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(param1[_loc4_].z1 == param2 && param1[_loc4_].z2 == param3 || param1[_loc4_].z1 == param3 && param1[_loc4_].z2 == param2)
            {
               return true;
            }
            _loc4_ = _loc4_ + 1;
         }
         return false;
      }
      
      private function getCellZone(param1:int) : int {
         var _loc2_:* = -1;
         var _loc3_:Boolean = CellUtil.isLeftCol(param1);
         var _loc4_:Boolean = CellUtil.isRightCol(param1);
         var _loc5_:Boolean = CellUtil.isEvenRow(param1);
         if(!_loc3_ && param1-1 > 0 && this._cellZones[param1-1] > 0)
         {
            _loc2_ = this._cellZones[param1-1];
         }
         else
         {
            if(param1 - 28 > 0 && this._cellZones[param1 - 28] > 0)
            {
               _loc2_ = this._cellZones[param1 - 28];
            }
            else
            {
               if(!_loc5_ && !_loc4_ && param1 - 13 > 0 && this._cellZones[param1 - 13] > 0)
               {
                  _loc2_ = this._cellZones[param1 - 13];
               }
               else
               {
                  if((_loc5_) && (!_loc3_ || (_loc3_) && !_loc5_) && param1 - 14 > 0 && this._cellZones[param1 - 14] > 0)
                  {
                     _loc2_ = this._cellZones[param1 - 14];
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function getInformations(param1:int) : Array {
         var _loc2_:* = false;
         var _loc3_:* = true;
         var _loc4_:Boolean = CellUtil.isLeftCol(param1);
         var _loc5_:Boolean = CellUtil.isRightCol(param1);
         var _loc6_:Boolean = CellUtil.isEvenRow(param1);
         if(!_loc4_ && param1-1 > 0)
         {
            if(this._cellZones[param1-1] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1-1] != -1)
            {
               _loc3_ = false;
            }
         }
         if(!_loc5_ && param1 + 1 < this._cellZones.length)
         {
            if(this._cellZones[param1 + 1] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1 + 1] != -1)
            {
               _loc3_ = false;
            }
         }
         if((!_loc4_ || (_loc4_) && !_loc6_) && param1 + 14 < this._cellZones.length)
         {
            if(this._cellZones[param1 + 14] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1 + 14] != -1)
            {
               _loc3_ = false;
            }
         }
         if(param1 + 28 < this._cellZones.length)
         {
            if(this._cellZones[param1 + 28] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1 + 28] != -1)
            {
               _loc3_ = false;
            }
         }
         if((!_loc4_ || (_loc4_) && !_loc6_) && param1 - 14 > 0)
         {
            if(this._cellZones[param1 - 14] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1 - 14] != -1)
            {
               _loc3_ = false;
            }
         }
         if(param1 - 28 > 0)
         {
            if(this._cellZones[param1 - 28] > 0)
            {
               _loc2_ = true;
            }
            if(this._cellZones[param1 - 28] != -1)
            {
               _loc3_ = false;
            }
         }
         if(_loc6_)
         {
            if(!_loc4_ && param1 + 13 < this._cellZones.length)
            {
               if(this._cellZones[param1 + 13] > 0)
               {
                  _loc2_ = true;
               }
               if(this._cellZones[param1 + 13] != -1)
               {
                  _loc3_ = false;
               }
            }
            if(!_loc4_ && param1 - 15 > 0)
            {
               if(this._cellZones[param1 - 15] > 0)
               {
                  _loc2_ = true;
               }
               if(this._cellZones[param1 - 15] != -1)
               {
                  _loc3_ = false;
               }
            }
         }
         else
         {
            if(!_loc5_ && param1 - 13 > 0)
            {
               if(this._cellZones[param1 - 13] > 0)
               {
                  _loc2_ = true;
               }
               if(this._cellZones[param1 - 13] != -1)
               {
                  _loc3_ = false;
               }
            }
            if(!_loc5_ && param1 + 15 < this._cellZones.length)
            {
               if(this._cellZones[param1 + 15] > 0)
               {
                  _loc2_ = true;
               }
               if(this._cellZones[param1 + 15] != -1)
               {
                  _loc3_ = false;
               }
            }
         }
         return [_loc2_,_loc3_];
      }
      
      public function get tacticModeActivated() : Boolean {
         return this._tacticModeActivated;
      }
      
      private function loadBackground() : void {
         var _loc1_:IResourceLoader = null;
         if(this._background == null)
         {
            _loc1_ = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            _loc1_.addEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
            _loc1_.load(new Uri(SWF_LIB),null,AdvancedSwfAdapter);
         }
         else
         {
            MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
         }
      }
      
      private function removeBackground() : void {
         if(!(this._background == null) && (MapDisplayManager.getInstance().renderer.container.contains(this._background)))
         {
            MapDisplayManager.getInstance().renderer.container.removeChild(this._background);
         }
      }
      
      private function onBackgroundLoaded(param1:ResourceLoadedEvent=null) : void {
         param1.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
         var _loc2_:ApplicationDomain = param1.resource.applicationDomain;
         this._background = new _loc2_.getDefinition("BG")() as Sprite;
         this._background.name = "TacticModeBackground";
         MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
      }
      
      public function setDebugMode(param1:Boolean=false, param2:Boolean=false, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:Boolean=true, param7:Boolean=true) : void {
         this._showFightZone = param1;
         this._debugCache = param2;
         this._debugType = param3;
         this._showInteractiveCells = param4;
         this._showScaleZone = param5;
         this._flattenCells = param6;
         this._showBlockMvt = param7;
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
