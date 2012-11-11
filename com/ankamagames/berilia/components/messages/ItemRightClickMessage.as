package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.types.data.*;

    public class ItemRightClickMessage extends ComponentMessage
    {
        private var _gridItem:GridItem;

        public function ItemRightClickMessage(param1:Grid, param2:GridItem)
        {
            super(param1);
            this._gridItem = param2;
            return;
        }// end function

        public function get item() : GridItem
        {
            return this._gridItem;
        }// end function

    }
}
