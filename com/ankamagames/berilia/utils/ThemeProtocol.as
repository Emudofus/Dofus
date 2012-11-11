package com.ankamagames.berilia.utils
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.protocols.*;
    import com.ankamagames.jerakine.resources.protocols.impl.*;
    import com.ankamagames.jerakine.types.*;

    public class ThemeProtocol extends FileProtocol implements IProtocol
    {
        private static var _themePath:String;

        public function ThemeProtocol()
        {
            return;
        }// end function

        override protected function loadDirectly(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:Class) : void
        {
            var _loc_5:* = null;
            getAdapter(param1, param4);
            if (!_themePath)
            {
                _themePath = XmlConfig.getInstance().getEntry("config.ui.skin");
            }
            if (param1.protocol == "theme")
            {
                _loc_5 = _themePath + param1.path;
            }
            else
            {
                _loc_5 = param1.path;
            }
            _adapter.com.ankamagames.jerakine.resources.adapters:IAdapter::loadDirectly(param1, extractPath(_loc_5.split("file://").join("")), param2, param3);
            return;
        }// end function

    }
}
