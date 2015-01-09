package com.ankamagames.dofus.internalDatacenter.sales
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.items.Item;

    public class OfflineSaleWrapper implements IDataCenter 
    {

        public static const TYPE_BIDHOUSE:uint = 1;
        public static const TYPE_MERCHANT:uint = 2;

        public var type:uint;
        public var itemId:uint;
        public var itemName:String;
        public var quantity:uint;
        public var kamas:Number;


        public static function create(pSaleType:uint, pItemId:uint, pQuantity:uint, pKamas:Number):OfflineSaleWrapper
        {
            var osw:OfflineSaleWrapper = new (OfflineSaleWrapper)();
            osw.type = pSaleType;
            osw.itemId = pItemId;
            osw.itemName = Item.getItemById(osw.itemId).name;
            osw.quantity = pQuantity;
            osw.kamas = pKamas;
            return (osw);
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.sales

