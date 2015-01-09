package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
    import com.ankamagames.jerakine.resources.adapters.IAdapter;
    import com.ankamagames.jerakine.types.ASwf;
    import flash.display.LoaderInfo;
    import com.ankamagames.jerakine.resources.ResourceType;

    public class AdvancedSwfAdapter extends AbstractLoaderAdapter implements IAdapter 
    {

        private var _aswf:ASwf;


        override protected function getResource(ldr:LoaderInfo)
        {
            return (this._aswf);
        }

        override public function getResourceType():uint
        {
            return (ResourceType.RESOURCE_ASWF);
        }

        override protected function init(ldr:LoaderInfo):void
        {
            this._aswf = new ASwf(ldr.loader.content, ldr.applicationDomain, ldr.width, ldr.height);
            super.init(ldr);
        }


    }
}//package com.ankamagames.jerakine.resources.adapters.impl

