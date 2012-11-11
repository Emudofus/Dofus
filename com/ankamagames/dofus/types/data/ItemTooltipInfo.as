package com.ankamagames.dofus.types.data
{
    import com.ankamagames.dofus.internalDatacenter.items.*;

    public class ItemTooltipInfo extends Object
    {
        public var itemWrapper:ItemWrapper;
        public var shortcutKey:String;

        public function ItemTooltipInfo(param1:ItemWrapper, param2:String = null)
        {
            this.itemWrapper = param1;
            this.shortcutKey = param2;
            return;
        }// end function

    }
}
