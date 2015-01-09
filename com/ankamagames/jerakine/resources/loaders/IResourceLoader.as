package com.ankamagames.jerakine.resources.loaders
{
    import flash.events.IEventDispatcher;
    import com.ankamagames.jerakine.newCache.ICache;
    import com.ankamagames.jerakine.types.Uri;

    public interface IResourceLoader extends IEventDispatcher 
    {

        function load(_arg_1:*, _arg_2:ICache=null, _arg_3:Class=null, _arg_4:Boolean=false):void;
        function cancel():void;
        function isInCache(_arg_1:Uri):Boolean;

    }
}//package com.ankamagames.jerakine.resources.loaders

