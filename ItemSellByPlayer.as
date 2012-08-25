package 
{
    import com.ankamagames.dofus.internalDatacenter.items.*;

    class ItemSellByPlayer extends Object
    {
        public var itemWrapper:ItemWrapper;
        public var price:int;
        public var unsoldDelay:uint;

        function ItemSellByPlayer(param1:ItemWrapper, param2:int, param3:uint)
        {
            this.itemWrapper = param1;
            this.price = param2;
            this.unsoldDelay = param3;
            return;
        }// end function

    }
}
