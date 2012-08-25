package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class RadioGroup extends Object
    {
        private var _items:Array;
        private var _selected:IRadioItem;
        public var name:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(RadioGroup));

        public function RadioGroup(param1:String)
        {
            this.name = param1;
            this._items = new Array();
            return;
        }// end function

        public function addItem(param1:IRadioItem) : void
        {
            this._items[param1.id] = param1;
            if (param1.selected)
            {
                this._selected = param1;
            }
            return;
        }// end function

        public function removeItem(param1:IRadioItem) : void
        {
            delete this._items[param1.id];
            return;
        }// end function

        public function destroy() : void
        {
            this._items = null;
            this._selected = null;
            return;
        }// end function

        public function get value()
        {
            if (this._selected)
            {
                return this._selected.value;
            }
            return null;
        }// end function

        public function set value(param1) : void
        {
            var _loc_2:IRadioItem = null;
            for each (_loc_2 in this._items)
            {
                
                if (_loc_2.value == param1)
                {
                    this.selectedItem = _loc_2;
                }
            }
            return;
        }// end function

        public function set selectedItem(param1:IRadioItem) : void
        {
            var _loc_2:IRadioItem = null;
            if (this._selected == param1)
            {
                return;
            }
            for each (_loc_2 in this._items)
            {
                
                if (_loc_2.selected != (param1 == _loc_2))
                {
                    _loc_2.selected = param1 == _loc_2;
                }
            }
            this._selected = param1;
            return;
        }// end function

        public function get selectedItem() : IRadioItem
        {
            return this._selected;
        }// end function

    }
}
