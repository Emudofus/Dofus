package 
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;

    class ItemSellByBid extends Object
    {
        public var itemWrapper:ItemWrapper;
        public var prices:Vector.<int>;

        function ItemSellByBid(param1:ItemWrapper, param2:Vector.<int>)
        {
            this.itemWrapper = param1;
            this.prices = param2;
            return;
        }// end function

    }
}
