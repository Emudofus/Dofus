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
      
      public function RoleplayPointCellFrame(param1:Function=null, param2:Sprite=null, param3:Boolean=false, param4:Function=null, param5:Boolean=false) {
         var _loc6_:LinkedCursorData = null;
         super();
         this._entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         this._callBack = param1;
         this._freeCellOnly = param3;
         this._customCellValidatorFct = param4;
         this._untargetableEntities = param5;
         if(param2)
         {
            _loc6_ = new LinkedCursorData();
            _loc6_.sprite = param2;
            _loc6_.offset = new Point(-20,-20);
            LinkedCursorSpriteManager.getInstance().addItem(LINKED_CURSOR_NAME,_loc6_);
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:CellOverMessage = null;
         var _loc3_:CellOutMessage = null;
         var _loc4_:EntityMouseOverMessage = null;
         var _loc5_:CellClickMessage = null;
         var _loc6_:EntityClickMessage = null;
         switch(true)
         {
            case param1 is CellOverMessage:
               _loc2_ = param1 as CellOverMessage;
               this.refreshTarget(_loc2_.cellId);
               return true;
            case param1 is CellOutMessage:
               _loc3_ = param1 as CellOutMessage;
               this.refreshTarget(-1);
               return true;
            case param1 is EntityMouseOverMessage:
               _loc4_ = param1 as EntityMouseOverMessage;
               this.refreshTarget(_loc4_.entity.position.cellId);
               return false;
            case param1 is CellClickMessage:
               _loc5_ = param1 as CellClickMessage;
               this.showCell(_loc5_.cellId);
               return true;
            case param1 is EntityClickMessage:
               _loc6_ = param1 as EntityClickMessage;
               this.showCell(_loc6_.entity.position.cellId,_loc6_.entity.id);
               return true;
            case param1 is AdjacentMapClickMessage:
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return true;
            case param1 is MouseClickMessage:
               if(MouseClickMessage(param1).target is GraphicCell || MouseClickMessage(param1).target is IEntity)
               {
                  return false;
               }
               this.cancelShow();
               if(this._callBack != null)
               {
                  this._callBack(false,0,-1);
               }
               return false;
            default:
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
      
      private function refreshTarget(param1:int) : void {
         var _loc2_:IEntity = null;
         if(!(param1 == -1) && (this.isValidCell(param1)))
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
               this._targetSelection.color = TARGET_COLOR;
               this._targetSelection.zone = new Cross(0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            _loc2_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(!_loc2_)
            {
               return;
            }
            this._targetSelection.zone.direction = MapPoint(_loc2_.position).advancedOrientationTo(MapPoint.fromCellId(param1));
            SelectionManager.getInstance().update(SELECTION_TARGET,param1);
         }
         else
         {
            this.removeTarget();
         }
      }
      
      private function removeTarget() : void {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(_loc1_)
         {
            _loc1_.remove();
            this._targetSelection = null;
         }
      }
      
      private function showCell(param1:uint, param2:int=-1) : void {
         if(this.isValidCell(param1))
         {
            if(this._callBack != null)
            {
               this._callBack(true,param1,param2);
            }
         }
         this.cancelShow();
      }
      
      public function cancelShow() : void {
         KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
         var _loc1_:InventoryManagementFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         _loc1_.roleplayPointCellFrame = null;
         Kernel.getWorker().removeFrame(this);
      }
      
      private function isValidCell(param1:uint) : Boolean {
         if(this._customCellValidatorFct != null)
         {
            return this._customCellValidatorFct(param1);
         }
         return (DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(param1).x,MapPoint.fromCellId(param1).y,true)) && (!this._freeCellOnly || EntitiesManager.getInstance().getEntityOnCell(param1) == null);
      }
   }
}
