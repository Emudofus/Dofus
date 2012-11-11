package com.ankamagames.berilia.utils
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.resources.protocols.impl.*;
    import com.ankamagames.jerakine.types.*;

    public class ModProtocol extends FileProtocol implements IProtocol
    {

        public function ModProtocol()
        {
            return;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            getAdapter(param1, param4);
            var _loc_5:* = param1.path.substr(0, param1.path.indexOf("/"));
            var _loc_6:* = UiModuleManager.getInstance().getModulePath(_loc_5);
            var _loc_7:* = param1.path.substr(param1.path.indexOf("/"));
            if (_loc_6.charAt((_loc_6.length - 1)) != "/" && _loc_7.charAt(0) != "/")
            {
                _loc_6 = _loc_6 + "/";
            }
            if (_loc_6.charAt((_loc_6.length - 1)) == "/" && _loc_7.charAt(0) == "/")
            {
                _loc_7 = _loc_7.substr(1);
            }
            _loc_6 = _loc_6 + _loc_7;
            if (_loc_6.indexOf("undefine") != -1)
            {
                trace("iok");
            }
            _adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, extractPath(_loc_6), param2, param3);
            return;
        }// end function

    }
}
