package com.ankamagames.berilia.components.gridRenderer
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import gs.*;
    import gs.easing.*;
    import gs.events.*;

    public class SlotGridRenderer extends Object implements IGridRenderer, ICustomSecureObject
    {
        protected var _log:Logger;
        private var _grid:Grid;
        private var _emptyTexture:Uri;
        private var _overTexture:Uri;
        private var _selectedTexture:Uri;
        private var _acceptDragTexture:Uri;
        private var _refuseDragTexture:Uri;
        private var _timerTexture:Uri;
        private var _cssUri:Uri;
        private var _allowDrop:Boolean;
        private var _isButton:Boolean;
        private var _hideQuantities:Boolean = false;
        public var dropValidatorFunction:Function;
        public var processDropFunction:Function;
        public var removeDropSourceFunction:Function;

        public function SlotGridRenderer(param1:String)
        {
            this._log = Log.getLogger(getQualifiedClassName(SlotGridRenderer));
            var _loc_2:* = param1 ? (param1.split(",")) : ([]);
            this._emptyTexture = _loc_2[0] && _loc_2[0].length ? (new Uri(_loc_2[0])) : (null);
            this._overTexture = _loc_2[1] && _loc_2[1].length ? (new Uri(_loc_2[1])) : (null);
            this._selectedTexture = _loc_2[2] && _loc_2[2].length ? (new Uri(_loc_2[2])) : (null);
            this._selectedTexture = _loc_2[2] && _loc_2[2].length ? (new Uri(_loc_2[2])) : (null);
            this._acceptDragTexture = _loc_2[3] && _loc_2[3].length ? (new Uri(_loc_2[3])) : (null);
            this._refuseDragTexture = _loc_2[4] && _loc_2[4].length ? (new Uri(_loc_2[4])) : (null);
            this._timerTexture = _loc_2[5] && _loc_2[5].length ? (new Uri(_loc_2[5])) : (null);
            this._cssUri = _loc_2[6] && _loc_2[6].length ? (new Uri(_loc_2[6])) : (null);
            this._allowDrop = _loc_2[7] && _loc_2[7].length ? (_loc_2[7] == "true") : (true);
            this._isButton = _loc_2[8] && _loc_2[8].length ? (_loc_2[8] == "true") : (false);
            return;
        }// end function

        public function set allowDrop(param1:Boolean) : void
        {
            this._allowDrop = param1;
            return;
        }// end function

        public function get allowDrop() : Boolean
        {
            return this._allowDrop;
        }// end function

        public function set isButton(param1:Boolean) : void
        {
            this._isButton = param1;
            return;
        }// end function

        public function get isButton() : Boolean
        {
            return this._isButton;
        }// end function

        public function set hideQuantities(param1:Boolean) : void
        {
            this._hideQuantities = param1;
            return;
        }// end function

        public function get hideQuantities() : Boolean
        {
            return this._hideQuantities;
        }// end function

        public function get acceptDragTexture() : Uri
        {
            return this._acceptDragTexture;
        }// end function

        public function set acceptDragTexture(param1:Uri) : void
        {
            this._acceptDragTexture = param1;
            return;
        }// end function

        public function get refuseDragTexture() : Uri
        {
            return this._refuseDragTexture;
        }// end function

        public function set refuseDragTexture(param1:Uri) : void
        {
            this._refuseDragTexture = param1;
            return;
        }// end function

        public function set grid(param1:Grid) : void
        {
            this._grid = param1;
            return;
        }// end function

        public function render(param1, param2:uint, param3:Boolean, param4:Boolean = true) : DisplayObject
        {
            var _loc_5:* = SecureCenter.unsecure(param1);
            var _loc_6:* = new Slot();
            new Slot().name = this._grid.getUi().name + "::" + this._grid.name + "::item" + param2;
            _loc_6.mouseEnabled = true;
            _loc_6.emptyTexture = this._emptyTexture;
            _loc_6.highlightTexture = this._overTexture;
            _loc_6.timerTexture = this._timerTexture;
            _loc_6.selectedTexture = this._selectedTexture;
            _loc_6.acceptDragTexture = this._acceptDragTexture;
            _loc_6.refuseDragTexture = this._refuseDragTexture;
            _loc_6.css = this._cssUri;
            _loc_6.isButton = this._isButton;
            if (this._hideQuantities)
            {
                _loc_6.hideTopLabel = true;
            }
            else
            {
                _loc_6.hideTopLabel = false;
            }
            _loc_6.width = this._grid.slotWidth;
            _loc_6.height = this._grid.slotHeight;
            if (this._isButton)
            {
                _loc_6.selected = param3;
            }
            else
            {
                _loc_6.allowDrag = this._allowDrop;
            }
            _loc_6.data = _loc_5;
            _loc_6.processDrop = this._processDrop;
            _loc_6.removeDropSource = this._removeDropSourceFunction;
            _loc_6.dropValidator = this._dropValidatorFunction;
            _loc_6.finalize();
            return _loc_6;
        }// end function

        public function _removeDropSourceFunction(param1) : void
        {
            var _loc_4:* = undefined;
            if (this.removeDropSourceFunction != null)
            {
                this.removeDropSourceFunction(param1);
                return;
            }
            var _loc_2:* = new Array();
            var _loc_3:* = true;
            for each (_loc_4 in this._grid.dataProvider)
            {
                
                if (_loc_4 != param1.data)
                {
                    _loc_2.push(_loc_4);
                }
            }
            this._grid.dataProvider = _loc_2;
            return;
        }// end function

        public function _dropValidatorFunction(param1:Object, param2, param3:Object) : Boolean
        {
            if (this.dropValidatorFunction != null)
            {
                return this.dropValidatorFunction(param1, param2, param3);
            }
            return true;
        }// end function

        public function update(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean = true) : void
        {
            var _loc_6:* = null;
            if (param3 is Slot)
            {
                _loc_6 = Slot(param3);
                _loc_6.data = SecureCenter.unsecure(param1) as ISlotData;
                if (!this._isButton)
                {
                    _loc_6.selected = param4;
                    _loc_6.allowDrag = this._allowDrop;
                }
                _loc_6.isButton = this._isButton;
                if (this._hideQuantities)
                {
                    _loc_6.hideTopLabel = true;
                }
                else
                {
                    _loc_6.hideTopLabel = false;
                }
                _loc_6.dropValidator = this._dropValidatorFunction;
                _loc_6.removeDropSource = this._removeDropSourceFunction;
                _loc_6.processDrop = this._processDrop;
            }
            else
            {
                this._log.warn("Can\'t update, " + param3.name + " is not a Slot component");
            }
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            if (param1 is Slot && param1.parent)
            {
                Slot(param1).remove();
            }
            return;
        }// end function

        public function destroy() : void
        {
            this._grid = null;
            this._emptyTexture = null;
            this._overTexture = null;
            this._timerTexture = null;
            this._selectedTexture = null;
            this._acceptDragTexture = null;
            this._refuseDragTexture = null;
            this._cssUri = null;
            return;
        }// end function

        public function _processDrop(param1, param2, param3) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (this.processDropFunction != null)
            {
                this.processDropFunction(param1, param2, param3);
                return;
            }
            var _loc_4:* = false;
            if (DisplayObject(param2.holder).parent != this._grid)
            {
                if (param2 is IClonable)
                {
                    this._grid.dataProvider.push((param2 as IClonable).clone());
                }
                else
                {
                    this._grid.dataProvider.push(param2);
                }
                this._grid.dataProvider = this._grid.dataProvider;
            }
            else
            {
                _loc_4 = true;
            }
            _loc_5 = LinkedCursorSpriteManager.getInstance().getItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
            if (_loc_4 || !this._grid.indexIsInvisibleSlot((this._grid.dataProvider.length - 1)))
            {
                _loc_7 = DisplayObject(param2.holder);
                _loc_6 = _loc_7.localToGlobal(new Point(_loc_7.x, _loc_7.y));
                TweenMax.to(_loc_5.sprite, 0.5, {x:_loc_6.x, y:_loc_6.y, alpha:0, ease:Quart.easeOut, onCompleteListener:this.onTweenEnd});
            }
            else
            {
                _loc_6 = this._grid.localToGlobal(new Point(this._grid.x, this._grid.y));
                _loc_5.sprite.stopDrag();
                TweenMax.to(_loc_5.sprite, 0.5, {x:_loc_6.x + this._grid.width / 2, y:_loc_6.y + this._grid.height, alpha:0, scaleX:0.1, scaleY:0.1, ease:Quart.easeOut, onCompleteListener:this.onTweenEnd});
            }
            return;
        }// end function

        public function renderModificator(param1:Array) : Array
        {
            return param1;
        }// end function

        public function eventModificator(param1:Message, param2:String, param3:Array, param4:UIComponent) : String
        {
            return param2;
        }// end function

        private function onTweenEnd(event:TweenEvent) : void
        {
            LinkedCursorSpriteManager.getInstance().removeItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
            return;
        }// end function

    }
}
