package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
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
      
      public function TacticModeManager(pvt:PrivateClass) {
         super();
         this._dmp = DataMapProvider.getInstance();
      }
      
      private static var SWF_LIB:String;
      
      private static var TILES_REACHABLE:Array;
      
      private static var TILES_NO_MVT:Array;
      
      private static var TILES_NO_VIEW:Array;
      
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
      
      public function show(pPoint:WorldPointWrapper, openByTerminal:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function canMoveOnThisCell(canMov:Boolean, nonWalkableDuringFight:Boolean, nonWalkableDuringRp:Boolean) : Boolean {
         if(!canMov)
         {
            return false;
         }
         if(((!this._debugMode) || (this._debugMode) && (this._debugType == DEBUG_FIGHT_MODE)) && (nonWalkableDuringFight))
         {
            return false;
         }
         if((this._debugMode) && (this._debugType == DEBUG_RP_MODE) && (nonWalkableDuringRp))
         {
            return false;
         }
         return true;
      }
      
      public function hide(force:Boolean = false) : void {
         var s:Selection = null;
         var cellRef:CellReference = null;
         var cellData:CellData = null;
         var i:* = 0;
         var cellInteractionCtr:DisplayObjectContainer = null;
         if(!this._tacticModeActivated)
         {
            return;
         }
         this._tacticModeActivated = false;
         if(!force)
         {
            KernelEventsManager.getInstance().processCallback(HookList.ShowTacticMode,false);
         }
         if(SHOW_BACKGROUND)
         {
            this.removeBackground();
         }
         s = SelectionManager.getInstance().getSelection("tacticReachableRange");
         if(s)
         {
            s.remove();
         }
         s = SelectionManager.getInstance().getSelection("tacticUnreachableRange");
         if(s)
         {
            s.remove();
         }
         if(this._tacticOtherSelection != null)
         {
            s = SelectionManager.getInstance().getSelection("tacticOtherRange");
            if(s)
            {
               s.remove();
            }
         }
         if(this._interactiveCellsZone != null)
         {
            s = SelectionManager.getInstance().getSelection("interactiveCellsZone");
            if(s)
            {
               s.remove();
            }
         }
         if(this._scaleZone != null)
         {
            s = SelectionManager.getInstance().getSelection("scaleZone");
            if(s)
            {
               s.remove();
            }
         }
         if(this._fightZone != null)
         {
            s = SelectionManager.getInstance().getSelection("debugSelection");
            if(s)
            {
               s.remove();
            }
         }
         var len:int = this._cellsRef.length;
         i = 0;
         while(i < len)
         {
            cellRef = this._cellsRef[i];
            if(cellRef)
            {
               cellData = this._cellsData[i];
               if(cellRef)
               {
                  cellRef.visible = true;
               }
               if(cellData.floor != 0)
               {
                  cellInteractionCtr = InteractiveCellManager.getInstance().getCell(cellRef.id);
                  cellInteractionCtr.y = cellRef.elevation;
                  this.updateEntitiesOnCell(i);
               }
            }
            i++;
         }
         MapDisplayManager.getInstance().hideBackgroundForTacticMode(false);
      }
      
      private function updateEntitiesOnCell(cellId:uint) : void {
         var characterEntity:AnimatedCharacter = null;
         var e:IEntity = null;
         var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId);
         for each(e in entities)
         {
            characterEntity = DofusEntities.getEntity(e.id) as AnimatedCharacter;
            if(characterEntity)
            {
               characterEntity.jump(characterEntity.position);
            }
         }
      }
      
      private function clearUnneededCells(zonesMaxX:int, zonesMaxY:int, zonesMinX:int, zonesMinY:int) : void {
         var uCell:uint = 0;
         var i:* = 0;
         var infos:Array = null;
         var avgX:int = zonesMaxX - zonesMinX;
         var avgY:int = Math.abs(zonesMinY) + Math.abs(zonesMaxY);
         var centerCellId:int = CellIdConverter.coordToCellId(avgX / 2 + zonesMinX,avgY / 2 + zonesMinY);
         var l:ZRectangle = new ZRectangle(0,avgX / 2,avgY / 2,null);
         var collideCells:Vector.<uint> = l.getCells(centerCellId);
         if((this._debugMode) && (this._showFightZone))
         {
            this._fightZone = new Selection();
            this._fightZone.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._fightZone.color = new Color(16772608);
            this._fightZone.zone = l;
            this._debugCellId = centerCellId;
         }
         var unreachablePathDuplicate:Vector.<uint> = this._unreachablePath.concat();
         var len:int = unreachablePathDuplicate.length;
         i = 0;
         while(i < len)
         {
            uCell = unreachablePathDuplicate[i];
            infos = this.getInformations(uCell);
            if((infos[1]) || (collideCells.indexOf(uCell) == -1) && (!infos[0]))
            {
               this._unreachablePath.splice(this._unreachablePath.indexOf(uCell),1);
            }
            i = i + 1;
         }
         unreachablePathDuplicate = null;
      }
      
      private function updateCellWithRealCellZone() : void {
         var zone:* = 0;
         var isLeftCol:* = false;
         var isRightCol:* = false;
         var isEvenRow:* = false;
         var zones:Vector.<int> = null;
         var cellId:* = 0;
         var i:* = 0;
         var len2:* = 0;
         var j:* = 0;
         var minValue:* = 0;
         var maxValue:* = 0;
         var len:int = this._cellZones.length;
         var collideZones:Array = new Array();
         cellId = 0;
         while(cellId < len)
         {
            zone = this._cellZones[cellId];
            if(zone > 0)
            {
               isLeftCol = CellUtil.isLeftCol(cellId);
               isRightCol = CellUtil.isRightCol(cellId);
               isEvenRow = CellUtil.isEvenRow(cellId);
               zones = new Vector.<int>();
               if((cellId - 28 > 0) && (this._cellZones[cellId - 28] > 0))
               {
                  zones.push(this._cellZones[cellId - 28]);
               }
               if((!isRightCol) && (cellId + 1 < this._cellZones.length) && (this._cellZones[cellId + 1] > 0))
               {
                  zones.push(this._cellZones[cellId + 1]);
               }
               if((cellId + 28 < this._cellZones.length) && (this._cellZones[cellId + 28] > 0))
               {
                  zones.push(this._cellZones[cellId + 28]);
               }
               if((!isLeftCol) && (cellId - 1 > 0) && (this._cellZones[cellId - 1] > 0))
               {
                  zones.push(this._cellZones[cellId - 1]);
               }
               if(((!isLeftCol) || (isLeftCol) && (!isEvenRow)) && (cellId + 14 < this._cellZones.length) && (this._cellZones[cellId + 14] > 0))
               {
                  zones.push(this._cellZones[cellId + 14]);
               }
               if(((!isLeftCol) || (isLeftCol) && (!isEvenRow)) && (cellId - 14 > 0) && (this._cellZones[cellId - 14] > 0))
               {
                  zones.push(this._cellZones[cellId - 14]);
               }
               if(isEvenRow)
               {
                  if((!isLeftCol) && (cellId + 13 < this._cellZones.length) && (this._cellZones[cellId + 13] > 0))
                  {
                     zones.push(this._cellZones[cellId + 13]);
                  }
                  if((!isLeftCol) && (cellId - 15 > 0) && (this._cellZones[cellId - 15] > 0))
                  {
                     zones.push(this._cellZones[cellId - 15]);
                  }
               }
               else
               {
                  if((!isRightCol) && (cellId - 13 > 0) && (this._cellZones[cellId - 13] > 0))
                  {
                     zones.push(this._cellZones[cellId - 13]);
                  }
                  if((!isRightCol) && (cellId + 15 < this._cellZones.length) && (this._cellZones[cellId + 15] > 0))
                  {
                     zones.push(this._cellZones[cellId + 15]);
                  }
               }
               if(zones.length > 0)
               {
                  len2 = zones.length;
                  i = 0;
                  while(i < len2)
                  {
                     if((!(zone == zones[i])) && (!this.containZone(collideZones,zone,zones[i])))
                     {
                        collideZones.push(
                           {
                              "z1":zone,
                              "z2":zones[i]
                           });
                     }
                     if(zones[i] < zone)
                     {
                        zone = zones[i];
                     }
                     i = i + 1;
                  }
                  if(zone > 0)
                  {
                     this._cellZones[cellId] = zone;
                     if((cellId - 28 > 0) && (this._cellZones[cellId - 28] > 0))
                     {
                        this._cellZones[cellId - 28] = zone;
                     }
                     if((cellId - 13 > 0) && (this._cellZones[cellId - 13] > 0))
                     {
                        this._cellZones[cellId - 13] = zone;
                     }
                     if((cellId + 1 < this._cellZones.length) && (this._cellZones[cellId + 1] > 0))
                     {
                        this._cellZones[cellId + 1] = zone;
                     }
                     if((cellId + 15 < this._cellZones.length) && (this._cellZones[cellId + 15] > 0))
                     {
                        this._cellZones[cellId + 15] = zone;
                     }
                     if((cellId + 28 < this._cellZones.length) && (this._cellZones[cellId + 28] > 0))
                     {
                        this._cellZones[cellId + 28] = zone;
                     }
                     if((cellId + 14 < this._cellZones.length) && (this._cellZones[cellId + 14] > 0))
                     {
                        this._cellZones[cellId + 14] = zone;
                     }
                     if((cellId - 1 > 0) && (this._cellZones[cellId - 1] > 0))
                     {
                        this._cellZones[cellId - 1] = zone;
                     }
                  }
               }
            }
            cellId = cellId + 1;
         }
         if(collideZones.length > 0)
         {
            i = 0;
            while(i < collideZones.length)
            {
               if((!(this._cellZones.indexOf(collideZones[i].z1) == -1)) && (!(this._cellZones.indexOf(collideZones[i].z2) == -1)))
               {
                  minValue = Math.min(collideZones[i].z1,collideZones[i].z2);
                  maxValue = Math.max(collideZones[i].z1,collideZones[i].z2);
                  j = 0;
                  while(j < len)
                  {
                     if(this._cellZones[j] == maxValue)
                     {
                        this._cellZones[j] = minValue;
                     }
                     j = j + 1;
                  }
               }
               i = i + 1;
            }
            collideZones = null;
         }
      }
      
      private function containZone(zones:Array, z1:int, z2:int) : Boolean {
         var i:* = 0;
         var len:int = zones.length;
         i = 0;
         while(i < len)
         {
            if((zones[i].z1 == z1) && (zones[i].z2 == z2) || (zones[i].z1 == z2) && (zones[i].z2 == z1))
            {
               return true;
            }
            i = i + 1;
         }
         return false;
      }
      
      private function getCellZone(cellId:int) : int {
         var zone:int = -1;
         var isLeftCol:Boolean = CellUtil.isLeftCol(cellId);
         var isRightCol:Boolean = CellUtil.isRightCol(cellId);
         var isEvenRow:Boolean = CellUtil.isEvenRow(cellId);
         if((!isLeftCol) && (cellId - 1 > 0) && (this._cellZones[cellId - 1] > 0))
         {
            zone = this._cellZones[cellId - 1];
         }
         else if((cellId - 28 > 0) && (this._cellZones[cellId - 28] > 0))
         {
            zone = this._cellZones[cellId - 28];
         }
         else if((!isEvenRow) && (!isRightCol) && (cellId - 13 > 0) && (this._cellZones[cellId - 13] > 0))
         {
            zone = this._cellZones[cellId - 13];
         }
         else if((isEvenRow) && ((!isLeftCol) || (isLeftCol) && (!isEvenRow)) && (cellId - 14 > 0) && (this._cellZones[cellId - 14] > 0))
         {
            zone = this._cellZones[cellId - 14];
         }
         
         
         
         return zone;
      }
      
      private function getInformations(cellId:int) : Array {
         var isBorder:Boolean = false;
         var isUseless:Boolean = true;
         var isLeftCol:Boolean = CellUtil.isLeftCol(cellId);
         var isRightCol:Boolean = CellUtil.isRightCol(cellId);
         var isEvenRow:Boolean = CellUtil.isEvenRow(cellId);
         if((!isLeftCol) && (cellId - 1 > 0))
         {
            if(this._cellZones[cellId - 1] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 1] != -1)
            {
               isUseless = false;
            }
         }
         if((!isRightCol) && (cellId + 1 < this._cellZones.length))
         {
            if(this._cellZones[cellId + 1] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 1] != -1)
            {
               isUseless = false;
            }
         }
         if(((!isLeftCol) || (isLeftCol) && (!isEvenRow)) && (cellId + 14 < this._cellZones.length))
         {
            if(this._cellZones[cellId + 14] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 14] != -1)
            {
               isUseless = false;
            }
         }
         if(cellId + 28 < this._cellZones.length)
         {
            if(this._cellZones[cellId + 28] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId + 28] != -1)
            {
               isUseless = false;
            }
         }
         if(((!isLeftCol) || (isLeftCol) && (!isEvenRow)) && (cellId - 14 > 0))
         {
            if(this._cellZones[cellId - 14] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 14] != -1)
            {
               isUseless = false;
            }
         }
         if(cellId - 28 > 0)
         {
            if(this._cellZones[cellId - 28] > 0)
            {
               isBorder = true;
            }
            if(this._cellZones[cellId - 28] != -1)
            {
               isUseless = false;
            }
         }
         if(isEvenRow)
         {
            if((!isLeftCol) && (cellId + 13 < this._cellZones.length))
            {
               if(this._cellZones[cellId + 13] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId + 13] != -1)
               {
                  isUseless = false;
               }
            }
            if((!isLeftCol) && (cellId - 15 > 0))
            {
               if(this._cellZones[cellId - 15] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId - 15] != -1)
               {
                  isUseless = false;
               }
            }
         }
         else
         {
            if((!isRightCol) && (cellId - 13 > 0))
            {
               if(this._cellZones[cellId - 13] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId - 13] != -1)
               {
                  isUseless = false;
               }
            }
            if((!isRightCol) && (cellId + 15 < this._cellZones.length))
            {
               if(this._cellZones[cellId + 15] > 0)
               {
                  isBorder = true;
               }
               if(this._cellZones[cellId + 15] != -1)
               {
                  isUseless = false;
               }
            }
         }
         return [isBorder,isUseless];
      }
      
      public function get tacticModeActivated() : Boolean {
         return this._tacticModeActivated;
      }
      
      private function loadBackground() : void {
         var loader:IResourceLoader = null;
         if(this._background == null)
         {
            loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
            loader.addEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
            loader.load(new Uri(SWF_LIB),null,AdvancedSwfAdapter);
         }
         else
         {
            MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
         }
      }
      
      private function removeBackground() : void {
         if((!(this._background == null)) && (MapDisplayManager.getInstance().renderer.container.contains(this._background)))
         {
            MapDisplayManager.getInstance().renderer.container.removeChild(this._background);
         }
      }
      
      private function onBackgroundLoaded(pEvt:ResourceLoadedEvent = null) : void {
         pEvt.currentTarget.removeEventListener(ResourceLoadedEvent.LOADED,this.onBackgroundLoaded);
         var appDomain:ApplicationDomain = pEvt.resource.applicationDomain;
         this._background = new appDomain.getDefinition("BG")() as Sprite;
         this._background.name = "TacticModeBackground";
         MapDisplayManager.getInstance().renderer.container.addChildAt(this._background,0);
      }
      
      public function setDebugMode(pShowFightZone:Boolean = false, pUseCache:Boolean = false, pDebugType:int = 0, pShowInteractiveCells:Boolean = false, pShowScaleZone:Boolean = false, pFlattenCells:Boolean = true, pShowBlockMvt:Boolean = true) : void {
         this._showFightZone = pShowFightZone;
         this._debugCache = pUseCache;
         this._debugType = pDebugType;
         this._showInteractiveCells = pShowInteractiveCells;
         this._showScaleZone = pShowScaleZone;
         this._flattenCells = pFlattenCells;
         this._showBlockMvt = pShowBlockMvt;
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
