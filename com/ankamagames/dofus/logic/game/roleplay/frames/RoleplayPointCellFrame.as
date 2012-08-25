package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.messages.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.entities.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class RoleplayPointCellFrame extends Object implements Frame
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayPointCellFrame));
        private static const TARGET_COLOR:Color = new Color(16548386);
        private static const SELECTION_TARGET:String = "SpellCastTarget";
        private static const LINKED_CURSOR_NAME:String = "RoleplayPointCellFrame_Pointer";

        public function RoleplayPointCellFrame(param1:Function = null, param2:Sprite = null, param3:Boolean = false, param4:Function = null, param5:Boolean = false)
        {
            var _loc_6:LinkedCursorData = null;
            this._entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            this._callBack = param1;
            this._freeCellOnly = param3;
            this._customCellValidatorFct = param4;
            this._untargetableEntities = param5;
            if (param2)
            {
                _loc_6 = new LinkedCursorData();
                _loc_6.sprite = param2;
                _loc_6.offset = new Point(-20, -20);
                LinkedCursorSpriteManager.getInstance().addItem(LINKED_CURSOR_NAME, _loc_6);
            }
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
        }// end function

        public function pushed() : Boolean
        {
            this._InteractiveCellManager_click = InteractiveCellManager.getInstance().cellClickEnabled;
            this._InteractiveCellManager_over = InteractiveCellManager.getInstance().cellOverEnabled;
            this._InteractiveCellManager_out = InteractiveCellManager.getInstance().cellOutEnabled;
            InteractiveCellManager.getInstance().setInteraction(true, true, true);
            this._untargetableEntitiesBackup = this._entitiesFrame.untargetableEntities;
            this._entitiesFrame.untargetableEntities = this._untargetableEntities;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:CellOverMessage = null;
            var _loc_3:CellOutMessage = null;
            var _loc_4:EntityMouseOverMessage = null;
            var _loc_5:CellClickMessage = null;
            var _loc_6:EntityClickMessage = null;
            switch(true)
            {
                case param1 is CellOverMessage:
                {
                    _loc_2 = param1 as CellOverMessage;
                    this.refreshTarget(_loc_2.cellId);
                    return true;
                }
                case param1 is CellOutMessage:
                {
                    _loc_3 = param1 as CellOutMessage;
                    this.refreshTarget(-1);
                    return true;
                }
                case param1 is EntityMouseOverMessage:
                {
                    _loc_4 = param1 as EntityMouseOverMessage;
                    this.refreshTarget(_loc_4.entity.position.cellId);
                    return false;
                }
                case param1 is CellClickMessage:
                {
                    _loc_5 = param1 as CellClickMessage;
                    this.showCell(_loc_5.cellId);
                    return true;
                }
                case param1 is EntityClickMessage:
                {
                    _loc_6 = param1 as EntityClickMessage;
                    this.showCell(_loc_6.entity.position.cellId, _loc_6.entity.id);
                    return true;
                }
                case param1 is AdjacentMapClickMessage:
                {
                    this.cancelShow();
                    if (this._callBack != null)
                    {
                        this._callBack(false, 0, -1);
                    }
                    return true;
                }
                case param1 is MouseClickMessage:
                {
                    if (MouseClickMessage(param1).target is GraphicCell || MouseClickMessage(param1).target is IEntity)
                    {
                        return false;
                    }
                    this.cancelShow();
                    if (this._callBack != null)
                    {
                        this._callBack(false, 0, -1);
                    }
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            this.removeTarget();
            LinkedCursorSpriteManager.getInstance().removeItem(LINKED_CURSOR_NAME);
            InteractiveCellManager.getInstance().setInteraction(this._InteractiveCellManager_click, this._InteractiveCellManager_over, this._InteractiveCellManager_out);
            this._entitiesFrame.untargetableEntities = this._untargetableEntitiesBackup;
            return true;
        }// end function

        private function refreshTarget(param1:int) : void
        {
            if (param1 != -1 && this.isValidCell(param1))
            {
                if (!this._targetSelection)
                {
                    this._targetSelection = new Selection();
                    this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
                    this._targetSelection.color = TARGET_COLOR;
                    this._targetSelection.zone = new Cross(0, 0, DataMapProvider.getInstance());
                    SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_TARGET);
                }
                this._targetSelection.zone.direction = MapPoint(DofusEntities.getEntity(PlayedCharacterManager.getInstance().id).position).advancedOrientationTo(MapPoint.fromCellId(param1));
                SelectionManager.getInstance().update(SELECTION_TARGET, param1);
            }
            else
            {
                this.removeTarget();
            }
            return;
        }// end function

        private function removeTarget() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
            if (_loc_1)
            {
                _loc_1.remove();
                this._targetSelection = null;
            }
            return;
        }// end function

        private function showCell(param1:uint, param2:int = -1) : void
        {
            if (this.isValidCell(param1))
            {
                if (this._callBack != null)
                {
                    this._callBack(true, param1, param2);
                }
            }
            this.cancelShow();
            return;
        }// end function

        public function cancelShow() : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.ShowCell);
            Kernel.getWorker().removeFrame(this);
            return;
        }// end function

        private function isValidCell(param1:uint) : Boolean
        {
            if (this._customCellValidatorFct != null)
            {
                return this._customCellValidatorFct(param1);
            }
            return DataMapProvider.getInstance().pointMov(MapPoint.fromCellId(param1).x, MapPoint.fromCellId(param1).y, true) && (!this._freeCellOnly || EntitiesManager.getInstance().getEntityOnCell(param1) == null);
        }// end function

    }
}
