package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import flash.display.Sprite;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import flash.geom.Point;
   
   public class RoleplayPointCellFrame extends Object implements Frame
   {
      
      public function RoleplayPointCellFrame(callBack:Function=null, cursorIcon:Sprite=null, freeCellOnly:Boolean=false, customCellValidatorFct:Function=null, untargetableEntities:Boolean=false) {
         var lkd:LinkedCursorData = null;
         super();
         this._entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         this._callBack = callBack;
         this._freeCellOnly = freeCellOnly;
         this._customCellValidatorFct = customCellValidatorFct;
         this._untargetableEntities = untargetableEntities;
         if(cursorIcon)
         {
            lkd = new LinkedCursorData();
            lkd.sprite = cursorIcon;
            lkd.offset = new Point(-20,-20);
            LinkedCursorSpriteManager.getInstance().addItem(LINKED_CURSOR_NAME,lkd);
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayPointCellFrame));
      
      private static const TARGET_COLOR:Color = new Color(16548386);
      
      private static const SELECTION_TARGET:String = "SpellCastTarget";
      
      private static const LINKED_CURSOR_NAME:String = "RoleplayPointCellFrame_Pointer";
      
      private var _entitiesFrame:RoleplayEntitiesFrame;
      
      private var _targetSelection:Selection;
      
      private var _InteractiveCellManager_click:Boolean;
      
      private var _InteractiveCellManager_over:Boolean;
      
      private var _InteractiveCellManager_out:Boolean;
      
      private var _freeCellOnly:Boolean;
      
      private var _callBack:Function;
      
      private var _customCellValidatorFct:Function;
      
      private var _untargetableEntities:Boolean;
      
      private var _untargetableEntitiesBackup:Boolean;
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function pushed() : Boolean {
         this._InteractiveCellManager_click = InteractiveCellManager.getInstance().cellClickEnabled;
         this._InteractiveCellManager_over = InteractiveCellManager.getInstance().cellOverEnabled;
         this._InteractiveCellManager_out = InteractiveCellManager.getInstance().cellOutEnabled;
         InteractiveCellManager.getInstance().setInteraction(true,true,true);
         this._untargetableEntitiesBackup = this._entitiesFrame.untargetableEntities;
         this._entitiesFrame.untargetableEntities = this._untargetableEntities;
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var conmsg:CellOverMessage = null;
         var coutmsg:CellOutMessage = null;
         var emomsg:EntityMouseOverMessage = null;
         var ccmsg:CellClickMessage = null;
         var ecmsg:EntityClickMessage = null;
         switch(true)
         {
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               this.refreshTarget(conmsg.cellId);
               return true;
            case msg is CellOutMessage:
               coutmsg = msg as CellOutMessage;
               this.refreshTarget(-1);
               return true;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               this.refreshTarget(emomsg.entity.position.cellId);
               return false;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               this.showCell(ccmsg.cellId);
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               this.showCell(ecmsg.entity.position.cellId,ecmsg.entity.id);
               return true;
            case msg is AdjacentMapClickMessage:
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return true;
            case msg is MouseClickMessage:
               if((MouseClickMessage(msg).target is GraphicCell) || (MouseClickMessage(msg).target is IEntity))
               {
                  return false;
               }
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return false;
         }
      }
      
      public function pulled() : Boolean {
         this.removeTarget();
         LinkedCursorSpriteManager.getInstance().removeItem(LINKED_CURSOR_NAME);
         InteractiveCellManager.getInstance().setInteraction(this._InteractiveCellManager_click,this._InteractiveCellManager_over,this._InteractiveCellManager_out);
         this._entitiesFrame.untargetableEntities = this._untargetableEntitiesBackup;
         return true;
      }
      
      private function refreshTarget(target:int) : void {
         var entity:IEntity = null;
         if((!(target == -1)) && (this.isValidCell(target)))
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._targetSelection.color = TARGET_COLOR;
               this._targetSelection.zone = new Cross(0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            entity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(!entity)
            {
               return;
            }
            this._targetSelection.zone.direction = MapPoint(entity.position).advancedOrientationTo(MapPoint.fromCellId(target));
            SelectionManager.getInstance().update(SELECTION_TARGET,target);
         }
         else
         {
            this.removeTarget();
         }
      }
      
      private function removeTarget() : void {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(s)
         {
            s.remove();
            this._targetSelection = null;
         }
      }
      
      private function showCell(cell:uint, entityId:int=-1) : void {
         if(this.isValidCell(cell))
         {
            if(this._callBack != null)
            {
               this._callBack(true,cell,entityId);
            }
         }
         this.cancelShow();
      }
      
      public function cancelShow() : void {
         KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
         var frm:InventoryManagementFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         frm.roleplayPointCellFrame = null;
         Kernel.getWorker().removeFrame(this);
      }
      
      private function isValidCell(cell:uint) : Boolean {
         if(this._customCellValidatorFct != null)
         {
            return this._customCellValidatorFct(cell);
         }
         return (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(cell).x,MapPoint.fromCellId(cell).y,true)) && ((!this._freeCellOnly) || (EntitiesManager.getInstance().getEntityOnCell(cell) == null));
      }
   }
}
