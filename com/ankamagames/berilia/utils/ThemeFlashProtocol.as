package com.ankamagames.berilia.utils
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.resources.protocols.impl.*;
    import com.ankamagames.jerakine.types.*;

    public class ThemeFlashProtocol extends FileFlashProtocol implements IProtocol
    {
        private var _uri:Uri;
        private var _observer2:IResourceObserver;
        private static var _themePath:String;

        public function ThemeFlashProtocol()
        {
            return;
        }// end function

        override public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void
        {
            var _loc_7:* = null;
            this._uri = param1;
            this._observer2 = param2;
            if (!_themePath)
            {
                _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
            }
            if (param1.protocol == "theme")
            {
                _loc_7 = _themePath + param1.path.replace("file://", "");
            }
            else
            {
                _loc_7 = param1.path.replace("file://", "");
            }
            var _loc_8:* = new Uri(_loc_7);
            super.load(_loc_8, new ResourceObserverWrapper(this._onLoaded, this._onFailed, this._onProgress), param3, param4, param5, param6);
            return;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            getAdapter(param1, param4);
            var _loc_5:* = param1.path;
            trace(_loc_5);
            _adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, extractPath(_loc_5), param2, param3);
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
