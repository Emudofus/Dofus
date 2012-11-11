package com.ankamagames.dofus.modules.utils
{
    import com.ankamagames.berilia.interfaces.*;

    public class SpellTooltipSettings extends Object implements IModuleUtil
    {
        private var _header:Boolean;
        private var _effects:Boolean;
        private var _description:Boolean;
        private var _CC_EC:Boolean;

        public function SpellTooltipSettings()
        {
            this._header = true;
            this._effects = true;
            this._description = true;
            this._CC_EC = true;
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

        public function get description() : Boolean
        {
            return this._description;
        }// end function

        public function set description(param1:Boolean) : void
        {
            this._description = param1;
            return;
        }// end function

        public function get CC_EC() : Boolean
        {
            return this._CC_EC;
        }// end function

        public function set CC_EC(param1:Boolean) : void
        {
            this._CC_EC = param1;
            return;
        }// end function

    }
}
