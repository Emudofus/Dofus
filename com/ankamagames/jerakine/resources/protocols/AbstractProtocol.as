package com.ankamagames.jerakine.resources.protocols
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class AbstractProtocol extends Object
    {
        protected var _observer:IResourceObserver;
        protected var _adapter:IAdapter;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function AbstractProtocol()
        {
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function free() : void
        {
            this.release();
            this._observer = null;
            this._adapter = null;
            trace("Protocol " + this + " freed.");
            return;
        }// end function

        public function cancel() : void
        {
            return;
        }// end function

        protected function release() : void
        {
            throw new AbstractMethodCallError("AbstractProtocol childs must override the release method in order to free their resources.");
        }// end function

        protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            this.getAdapter(param1, param4);
            this._adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, param1.path, param2, param3);
            return;
        }// end function

        protected function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean, param5:Class) : void
        {
            this.getAdapter(param1, param5);
            this._adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadFromData(param1, param2, param3, param4);
            return;
        }// end function

        protected function getAdapter(param1:Uri, param2:Class) : void
        {
            if (param2 == null)
            {
                this._adapter = AdapterFactory.getAdapter(param1);
            }
            else
            {
                this._adapter = new param2;
            }
            return;
        }// end function

    }
}
