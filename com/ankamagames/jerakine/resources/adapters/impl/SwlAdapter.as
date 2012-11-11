package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class SwlAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {
        private var _ldr:PoolableLoader;
        private var _onInit:Function;
        private var _swl:Swl;

        public function SwlAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return this._swl;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_SWL;
        }// end function

        override protected function process(param1:String, param2) : void
        {
            var file:uint;
            var version:uint;
            var frameRate:uint;
            var classesCount:uint;
            var classesList:Array;
            var i:uint;
            var swfData:ByteArray;
            var dataFormat:* = param1;
            var data:* = param2;
            try
            {
                file = (data as ByteArray).readByte();
                if (file != 76)
                {
                    dispatchFailure("Malformated library file (wrong header).", ResourceErrorCode.SWL_MALFORMED_LIBRARY);
                    return;
                }
                version = (data as ByteArray).readByte();
                frameRate = (data as ByteArray).readUnsignedInt();
                classesCount = (data as ByteArray).readInt();
                classesList = new Array();
                i;
                while (i < classesCount)
                {
                    
                    classesList.push((data as ByteArray).readUTF());
                    i = (i + 1);
                }
                swfData = new ByteArray();
                (data as ByteArray).readBytes(swfData);
            }
            catch (eof:EOFError)
            {
                dispatchFailure("Malformated library file (end of file).", ResourceErrorCode.SWL_MALFORMED_LIBRARY);
                return;
            }
            this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
            var _loc_4:* = this.onLibraryInit(frameRate, classesList);
            this._onInit = this.onLibraryInit(frameRate, classesList);
            this._ldr.contentLoaderInfo.addEventListener(Event.INIT, _loc_4);
            this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLibraryError);
            var loaderContext:* = getUri().loaderContext;
            if (!loaderContext)
            {
                loaderContext = new LoaderContext();
            }
            AirScanner.allowByteCodeExecution(loaderContext, true);
            this._ldr.loadBytes(swfData, loaderContext);
            return;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

        private function createResource(param1:uint, param2:Array, param3:ApplicationDomain) : void
        {
            this._swl = new Swl(param1, param2, param3);
            dispatchSuccess(null, null);
            return;
        }// end function

        private function releaseLoader() : void
        {
            this._ldr.contentLoaderInfo.removeEventListener(Event.INIT, this._onInit);
            this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLibraryError);
            PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
            this._ldr = null;
            this._onInit = null;
            return;
        }// end function

        private function onLibraryInit(param1:uint, param2:Array) : Function
        {
            var frameRate:* = param1;
            var classesList:* = param2;
            return function (event:Event) : void
            {
                var _loc_5:* = undefined;
                var _loc_6:* = undefined;
                var _loc_2:* = event.target as LoaderInfo;
                var _loc_3:* = _loc_2.applicationDomain;
                var _loc_4:* = _loc_2.content as MovieClip;
                if (_loc_2.content as MovieClip)
                {
                    _loc_5 = _loc_4.numChildren;
                    _loc_6 = -1;
                    while (++_loc_6 < _loc_5)
                    {
                        
                        _loc_4.removeChildAt(0);
                    }
                }
                createResource(frameRate, classesList, _loc_3);
                releaseLoader();
                return;
            }// end function
            ;
        }// end function

        private function onLibraryError(event:ErrorEvent) : void
        {
            dispatchFailure("Library loading from binaries failed: " + event.text, ResourceErrorCode.SWL_MALFORMED_BINARY);
            this.releaseLoader();
            return;
        }// end function

    }
}
