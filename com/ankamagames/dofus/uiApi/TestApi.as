package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.profiler.*;
    import flash.utils.*;

    public class TestApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function TestApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(DataApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getTestInventory(param1:uint) : Vector.<ItemWrapper>
        {
            var _loc_4:* = null;
            var _loc_2:* = new Vector.<ItemWrapper>;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_4 = null;
                while (!_loc_4)
                {
                    
                    _loc_4 = Item.getItemById(Math.floor(Math.random() * 1000));
                }
                _loc_2.push(ItemWrapper.create(63, _loc_3, _loc_4.id, 0, null));
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public function showTrace(param1:Boolean = true) : void
        {
            showRedrawRegions(param1, 40349);
            return;
        }// end function

    }
}
