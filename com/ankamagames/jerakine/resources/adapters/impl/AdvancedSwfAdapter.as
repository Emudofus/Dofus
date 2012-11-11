package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;

    public class AdvancedSwfAdapter extends AbstractLoaderAdapter implements IAdapter
    {
        private var _aswf:ASwf;

        public function AdvancedSwfAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:LoaderInfo)
        {
            return this._aswf;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_ASWF;
        }// end function

        override protected function init(param1:LoaderInfo) : void
        {
            if (AirScanner.hasAir())
            {
                this._aswf = new ASwf(param1.loader.content, param1.applicationDomain, param1.width, param1.height);
            }
            else
            {
                this._aswf = new ASwf(param1.loader.content, param1.applicationDomain, 800, 600);
            }
            super.init(param1);
            return;
        }// end function

    }
}
