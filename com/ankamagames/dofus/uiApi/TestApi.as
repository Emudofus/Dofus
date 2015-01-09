package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.items.Item;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import __AS3__.vec.Vector;
    import flash.profiler.showRedrawRegions;
    import __AS3__.vec.*;

    [Trusted]
    [InstanciedApi]
    public class TestApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function TestApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(DataApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function getTestInventory(len:uint):Vector.<ItemWrapper>
        {
            var item:Item;
            var inventory:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
            var i:uint;
            while (i < len)
            {
                item = null;
                while (!(item))
                {
                    item = Item.getItemById(Math.floor((Math.random() * 1000)));
                };
                inventory.push(ItemWrapper.create(63, i, item.id, 0, null));
                i++;
            };
            return (inventory);
        }

        [Trusted]
        public function showTrace(active:Boolean=true):void
        {
            showRedrawRegions(active, 0x9D9D);
        }


    }
}//package com.ankamagames.dofus.uiApi

