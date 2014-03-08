package com.ankamagames.atouin.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.atouin.types.GraphicCell;
   import flash.events.MouseEvent;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.CellReference;
   import flash.display.DisplayObject;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.types.LayerContainer;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import flash.display.Sprite;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import flash.geom.Point;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.types.DebugToolTip;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class InteractiveCellManager extends Object
   {
      
      public function InteractiveCellManager() {
         this._aCellPool = new Array();
         this._bShowGrid = Atouin.getInstance().options.alwaysShowGrid;
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.init();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InteractiveCellManager));
      
      private static var _self:InteractiveCellManager;
      
      public static function getInstance() : InteractiveCellManager {
         if(!_self)
         {
            _self = new InteractiveCellManager();
         }
         return _self;
      }
      
      private var _cellOverEnabled:Boolean = false;
      
      private var _aCells:Array;
      
      private var _aCellPool:Array;
      
      private var _bShowGrid:Boolean;
      
      private var _interaction_click:Boolean;
      
      private var _interaction_out:Boolean;
      
      private var _trapZoneRenderer:TrapZoneRenderer;
      
      public function get cellOverEnabled() : Boolean {
         return this._cellOverEnabled;
      }
      
      public function set cellOverEnabled(value:Boolean) : void {
         this.overStateChanged(this._cellOverEnabled,value);
         this._cellOverEnabled = value;
      }
      
      public function get cellOutEnabled() : Boolean {
         return this._interaction_out;
      }
      
      public function get cellClickEnabled() : Boolean {
         return this._interaction_click;
      }
      
      public function initManager() : void {
         this._aCells = new Array();
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      public function setInteraction(click:Boolean=true, over:Boolean=false, out:Boolean=false) : void {
         var cell:GraphicCell = null;
         this._interaction_click = click;
         this._cellOverEnabled = over;
         this._interaction_out = out;
         for each (cell in this._aCells)
         {
            if(click)
            {
               cell.addEventListener(MouseEvent.CLICK,this.mouseClick);
            }
            else
            {
               cell.removeEventListener(MouseEvent.CLICK,this.mouseClick);
            }
            if(over)
            {
               cell.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            }
            else
            {
               cell.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            }
            if(out)
            {
               cell.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            }
            else
            {
               cell.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            }
            cell.mouseEnabled = (click) || (over) || (out);
         }
      }
      
      public function getCell(cellId:uint) : GraphicCell {
         this._aCells[cellId] = this._aCellPool[cellId];
         return this._aCells[cellId];
      }
      
      public function updateInteractiveCell(container:DataMapContainer) : void {
         var cellRef:CellReference = null;
         var gCell:GraphicCell = null;
         var lastZCell:DisplayObject = null;
         if(!container)
         {
            _log.error("Can\'t update interactive cell of a NULL container");
            return;
         }
         this.setInteraction(true,Atouin.getInstance().options.showCellIdOnOver,Atouin.getInstance().options.showCellIdOnOver);
         var aCell:Array = container.getCell();
         var showTransitions:Boolean = Atouin.getInstance().options.showTransitions;
         var alpha:Number = (this._bShowGrid) || (Atouin.getInstance().options.alwaysShowGrid)?1:0;
         var layer:LayerContainer = container.getLayer(Layer.LAYER_DECOR);
         var cellIndex:uint = 0;
         var cellIndexMax:uint = this._aCells.length;
         var ind:uint = 0;
         var currentCell:GraphicCell = this._aCells[0];
         if(!currentCell)
         {
            while((!currentCell) && (cellIndex < cellIndexMax))
            {
               currentCell = this._aCells[cellIndex++];
            }
            cellIndex--;
         }
         while((ind < layer.numChildren) && (cellIndex < cellIndexMax))
         {
            if((!(currentCell == null)) && (currentCell.cellId <= CellContainer(layer.getChildAt(ind)).cellId))
            {
               cellRef = aCell[cellIndex];
               gCell = this._aCells[cellIndex];
               gCell.y = cellRef.elevation;
               gCell.visible = (cellRef.mov) && (!cellRef.isDisabled);
               gCell.alpha = alpha;
               layer.addChildAt(gCell,ind);
               currentCell = this._aCells[++cellIndex];
            }
            ind++;
         }
      }
      
      public function updateCell(cellId:uint, enabled:Boolean) : Boolean {
         DataMapProvider.getInstance().updateCellMovLov(cellId,enabled);
         if(this._aCells[cellId] != null)
         {
            this._aCells[cellId].visible = enabled;
            return true;
         }
         return false;
      }
      
      public function show(b:Boolean, pIsInFight:Boolean=false) : void {
         var cell:GraphicCell = null;
         this._bShowGrid = b;
         var alpha:Number = (this._bShowGrid) || (Atouin.getInstance().options.alwaysShowGrid)?1:0;
         var cellsData:Array = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
         var i:uint = 0;
         while(i < this._aCells.length)
         {
            cell = GraphicCell(this._aCells[i]);
            if(cell)
            {
               if(((pIsInFight) || (this._cellOverEnabled)) && (alpha == 1) && (cellsData[i].nonWalkableDuringFight))
               {
                  cell.alpha = 0;
               }
               else
               {
                  cell.alpha = alpha;
               }
            }
            i++;
         }
      }
      
      public function clean() : void {
         var i:uint = 0;
         if(this._aCells)
         {
            i = 0;
            while(i < this._aCells.length)
            {
               if(!((!this._aCells[i]) || (!this._aCells[i].parent)))
               {
                  this._aCells[i].parent.removeChild(this._aCells[i]);
               }
               i++;
            }
         }
      }
      
      private function init() : void {
         var c:GraphicCell = null;
         var i:uint = 0;
         while(i < AtouinConstants.MAP_CELLS_COUNT)
         {
            c = new GraphicCell(i);
            c.mouseEnabled = false;
            c.mouseChildren = false;
            this._aCellPool[i] = c;
            i++;
         }
      }
      
      private function overStateChanged(oldValue:Boolean, newValue:Boolean) : void {
         if(oldValue == newValue)
         {
            return;
         }
         if((!oldValue) && (newValue))
         {
            this.registerOver(true);
         }
         else
         {
            if((oldValue) && (!newValue))
            {
               this.registerOver(false);
            }
         }
      }
      
      private function registerOver(enabled:Boolean) : void {
         var i:uint = 0;
         while(i < AtouinConstants.MAP_CELLS_COUNT)
         {
            if(this._aCells[i])
            {
               if(enabled)
               {
                  this._aCells[i].addEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
                  this._aCells[i].addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
               }
               else
               {
                  this._aCells[i].removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
                  this._aCells[i].removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
               }
            }
            i++;
         }
      }
      
      private function mouseClick(e:MouseEvent) : void {
         var a:Array = null;
         var entity:IEntity = null;
         var msg:CellClickMessage = null;
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var targetCell:Point = CellIdConverter.cellIdToCoord(parseInt(target.name));
         if(!DataMapProvider.getInstance().pointCanStop(targetCell.x,targetCell.y))
         {
            _log.info("Cannot move to this cell in RP");
            return;
         }
         if(Atouin.getInstance().options.virtualPlayerJump)
         {
            a = EntitiesManager.getInstance().entities;
            for each (entity in a)
            {
               if(entity is IMovable)
               {
                  IMovable(entity).jump(MapPoint.fromCellId(parseInt(target.name)));
                  break;
               }
            }
         }
         else
         {
            msg = new CellClickMessage();
            msg.cellContainer = target;
            msg.cellDepth = index;
            msg.cell = MapPoint.fromCoords(targetCell.x,targetCell.y);
            msg.cellId = parseInt(target.name);
            Atouin.getInstance().handler.process(msg);
         }
      }
      
      private function mouseOver(e:MouseEvent) : void {
         var _cellColor:uint = 0;
         var textInfo:String = null;
         var mp:MapPoint = null;
         var cellData:CellData = null;
         var sel:Selection = null;
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var targetCell:Point = CellIdConverter.cellIdToCoord(parseInt(target.name));
         if(Atouin.getInstance().options.showCellIdOnOver)
         {
            _cellColor = 0;
            textInfo = target.name + " (" + targetCell.x + "/" + targetCell.y + ")";
            mp = MapPoint.fromCoords(targetCell.x,targetCell.y);
            textInfo = textInfo + ("\nLigne de vue : " + !DataMapProvider.getInstance().pointLos(mp.x,mp.y));
            textInfo = textInfo + ("\nBlocage éditeur : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y));
            textInfo = textInfo + ("\nBlocage entitée : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y,false));
            cellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[parseInt(target.name)]);
            textInfo = textInfo + ("\nForcage fleche bas : " + cellData.useBottomArrow);
            textInfo = textInfo + ("\nForcage fleche haut : " + cellData.useTopArrow);
            textInfo = textInfo + ("\nForcage fleche droite : " + cellData.useRightArrow);
            textInfo = textInfo + ("\nForcage fleche gauche : " + cellData.useLeftArrow);
            textInfo = textInfo + ("\nID de zone : " + cellData.moveZone);
            textInfo = textInfo + ("\nHauteur : " + cellData.floor + " px");
            textInfo = textInfo + ("\nSpeed : " + cellData.speed);
            DebugToolTip.getInstance().text = textInfo;
            sel = SelectionManager.getInstance().getSelection("infoOverCell");
            if(!sel)
            {
               sel = new Selection();
               sel.color = new Color(_cellColor);
               sel.renderer = new ZoneDARenderer();
               sel.zone = new Lozenge(0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(sel,"infoOverCell",parseInt(target.name));
            }
            else
            {
               SelectionManager.getInstance().update("infoOverCell",parseInt(target.name));
            }
            StageShareManager.stage.addChild(DebugToolTip.getInstance());
         }
         var msg:CellOverMessage = new CellOverMessage();
         msg.cellContainer = target;
         msg.cellDepth = index;
         msg.cell = MapPoint.fromCoords(targetCell.x,targetCell.y);
         msg.cellId = parseInt(target.name);
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mouseOut(e:MouseEvent) : void {
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var targetCell:Point = CellIdConverter.cellIdToCoord(parseInt(target.name));
         if(Atouin.getInstance().worldContainer.contains(DebugToolTip.getInstance()))
         {
            Atouin.getInstance().worldContainer.removeChild(DebugToolTip.getInstance());
         }
         var msg:CellOutMessage = new CellOutMessage();
         msg.cellContainer = target;
         msg.cellDepth = index;
         msg.cell = MapPoint.fromCoords(targetCell.x,targetCell.y);
         msg.cellId = parseInt(target.name);
         Atouin.getInstance().handler.process(msg);
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void {
         if(e.propertyName == "alwaysShowGrid")
         {
            this.show(e.propertyValue);
         }
      }
   }
}
