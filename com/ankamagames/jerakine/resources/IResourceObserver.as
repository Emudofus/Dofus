package com.ankamagames.jerakine.resources
{
    import com.ankamagames.jerakine.types.Uri;

    public interface IResourceObserver 
    {

        function onLoaded(_arg_1:Uri, _arg_2:uint, _arg_3:*):void;
        function onFailed(_arg_1:Uri, _arg_2:String, _arg_3:uint):void;
        function onProgress(_arg_1:Uri, _arg_2:uint, _arg_3:uint):void;

    }
}//package com.ankamagames.jerakine.resources

