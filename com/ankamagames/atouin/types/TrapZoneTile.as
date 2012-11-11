package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.geom.*;

    public class TrapZoneTile extends Sprite implements IDisplayable
    {
        private var _displayBehaviors:IDisplayBehavior;
        private var _displayed:Boolean;
        private var _currentCell:Point;
        private var _cellId:uint;
        public var strata:uint = 10;

        public function TrapZoneTile()
        {
            return;
        }// end function

        public function display(param1:uint = 0) : void
        {
            EntitiesDisplayManager.getInstance().displayEntity(this, MapPoint.fromCellId(this._cellId), param1);
            this._displayed = true;
            return;
        }// end function

        public function drawStroke(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
        {
            graphics.lineStyle(3, 0);
            if (!param1)
            {
                graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH, 0);
                graphics.lineTo(0, AtouinConstants.CELL_HALF_HEIGHT);
            }
            if (!param3)
            {
                graphics.moveTo(0, -AtouinConstants.CELL_HALF_HEIGHT);
                graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH, 0);
            }
            if (!param2)
            {
                graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH, 0);
                graphics.lineTo(0, -AtouinConstants.CELL_HALF_HEIGHT);
            }
            if (!param4)
            {
                graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH, 0);
                graphics.lineTo(0, AtouinConstants.CELL_HALF_HEIGHT);
            }
            return;
        }// end function

        public function remove() : void
        {
            this._displayed = false;
            EntitiesDisplayManager.getInstance().removeEntity(this);
            return;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehaviors;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehaviors = param1;
            return;
        }// end function

        public function get currentCell() : Point
        {
            return this._currentCell;
        }// end function

        public function set currentCell(param1:Point) : void
        {
            this._currentCell = param1;
            return;
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehaviors.getAbsoluteBounds(this);
        }// end function

        public function get cellId() : uint
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:uint) : void
        {
            this._cellId = param1;
            return;
        }// end function

    }
}
