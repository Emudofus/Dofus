package com.ankamagames.berilia.utils
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.resources.protocols.impl.*;
    import com.ankamagames.jerakine.types.*;

    public class ModFlashProtocol extends FileFlashProtocol implements IProtocol
    {
        private var _uri:Uri;
        private var _observer2:IResourceObserver;

        public function ModFlashProtocol()
        {
            return;
        }// end function

        override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            var _loc_7:* = param1.path.substr(0, param1.path.indexOf("/"));
            var _loc_8:* = UiModuleManager.getInstance().getModulePath(_loc_7) + param1.path.substr(param1.path.indexOf("/"));
            var _loc_9:* = new Uri(_loc_8);
            this._uri = param1;
            this._observer2 = param2;
            super.load(_loc_9, new ResourceObserverWrapper(this._onLoaded, this._onFailed, this._onProgress), param3, param4, param5, param6);
            return;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            getAdapter(param1, param4);
            var _loc_5:* = param1.path.substr(0, param1.path.indexOf("/"));
            var _loc_6:* = UiModuleManager.getInstance().getModulePath(_loc_5) + param1.path.substr(param1.path.indexOf("/"));
            _adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, extractPath(_loc_6), param2, param3);
            return;
        }// end function

        private function _onLoaded(param1:Uri, param2:uint, param3) : void
        {
            this._observer2.onLoaded(this._uri, param2, param3);
            return;
        }// end function

        private function _onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            this._observer2.onFailed(this._uri, param2, param3);
            return;
        }// end function

        private function _onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            this._observer2.onProgress(this._uri, param2, param3);
            return;
        }// end function

    }
}
