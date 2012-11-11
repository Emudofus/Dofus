package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;

    public class ZoneTile extends Sprite implements IDisplayable, ITransparency
    {
        private var _displayBehavior:IDisplayBehavior;
        protected var _displayed:Boolean;
        private var _currentCell:Point;
        private var _cellId:uint;
        protected var _cellInstance:Sprite;
        private var _tf:TextField;
        private var _color:uint;
        public var text:String;
        public var format:TextFormat;
        public var strata:uint = 0;
        private static const _cell:Class = ZoneTile__cell;

        public function ZoneTile()
        {
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehavior;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehavior = param1;
            return;
        }// end function

        public function get currentCellPosition() : Point
        {
            return this._currentCell;
        }// end function

        public function set currentCellPosition(param1:Point) : void
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
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        public function set color(param1:uint) : void
        {
            this._color = param1;
            return;
        }// end function

        public function get color() : uint
        {
            return this._color;
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

        public function display(param1:uint = 0) : void
        {
            if (this.text)
            {
                if (!this.format)
                {
                    this.format = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"), 20, 16777215, true);
                    this.format.align = TextFormatAlign.CENTER;
                }
                this._tf = new TextField();
                this._tf.selectable = false;
                this._tf.defaultTextFormat = this.format;
                this._tf.setTextFormat(this.format);
                this._tf.embedFonts = true;
                this._tf.text = this.text;
                this._tf.width = AtouinConstants.CELL_WIDTH;
                this._tf.height = AtouinConstants.CELL_HEIGHT;
                this._tf.x = -AtouinConstants.CELL_HALF_WIDTH;
                this._tf.y = -AtouinConstants.CELL_HALF_HEIGHT + 7;
                this._tf.alpha = 0.8;
            }
            else
            {
                this._tf = null;
            }
            this._cellInstance = new _cell();
            var _loc_2:* = new ColorTransform();
            _loc_2.color = this._color;
            this._cellInstance.transform.colorTransform = _loc_2;
            addChild(this._cellInstance);
            if (this._tf)
            {
                addChild(this._tf);
            }
            EntitiesDisplayManager.getInstance().displayEntity(this, MapPoint.fromCellId(this._cellId), this.strata);
            this._displayed = true;
            return;
        }// end function

        public function remove() : void
        {
            this._displayed = false;
            if (this._tf)
            {
                removeChild(this._tf);
            }
            removeChild(this._cellInstance);
            EntitiesDisplayManager.getInstance().removeEntity(this);
            return;
        }// end function

        public function getIsTransparencyAllowed() : Boolean
        {
            return false;
        }// end function

    }
}
