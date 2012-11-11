package com.ankamagames.dofus.modules.utils
{
    import com.ankamagames.berilia.interfaces.*;

    public class ItemTooltipSettings extends Object implements IModuleUtil
    {
        private var _header:Boolean;
        private var _effects:Boolean;
        private var _conditions:Boolean;
        private var _description:Boolean;

        public function ItemTooltipSettings()
        {
            this._header = true;
            this._effects = true;
            this._conditions = true;
            this._description = true;
            return;
        }// end function

        public function get header() : Boolean
        {
            return this._header;
        }// end function

        public function set header(param1:Boolean) : void
        {
            this._header = param1;
            return;
        }// end function

        public function get effects() : Boolean
        {
            return this._effects;
        }// end function

        public function set effects(param1:Boolean) : void
        {
            this._effects = param1;
            return;
        }// end function

        public function get conditions() : Boolean
        {
            return this._conditions;
        }// end function

        public function set conditions(param1:Boolean) : void
        {
            this._conditions = param1;
            return;
        }// end function

        public function get description() : Boolean
        {
            return this._description;
        }// end function

        public function set description(param1:Boolean) : void
        {
            this._description = param1;
            return;
        }// end function

    }
}
