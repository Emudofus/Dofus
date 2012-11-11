package com.ankamagames.dofus.types.data
{
    import com.ankamagames.dofus.internalDatacenter.spells.*;

    public class SpellTooltipInfo extends Object
    {
        public var spellWrapper:SpellWrapper;
        public var shortcutKey:String;

        public function SpellTooltipInfo(param1:SpellWrapper, param2:String = null)
        {
            this.spellWrapper = param1;
            this.shortcutKey = param2;
            return;
        }// end function

    }
}
