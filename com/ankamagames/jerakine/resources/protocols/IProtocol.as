package com.ankamagames.jerakine.resources.protocols
{
    import com.ankamagames.jerakine.pools.Poolable;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.IResourceObserver;
    import com.ankamagames.jerakine.newCache.ICache;

    public interface IProtocol extends Poolable 
    {

        function load(_arg_1:Uri, _arg_2:IResourceObserver, _arg_3:Boolean, _arg_4:ICache, _arg_5:Class, _arg_6:Boolean):void;
        function cancel():void;

    }
}//package com.ankamagames.jerakine.resources.protocols

