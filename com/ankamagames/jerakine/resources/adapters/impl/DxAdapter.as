package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class DxAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {
        private var _scriptClass:Class;

        public function DxAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return this._scriptClass;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_DX;
        }// end function

        override protected function process(param1:String, param2) : void
        {
            var file:uint;
            var version:uint;
            var keyLen:int;
            var key:ByteArray;
            var swfData:ByteArray;
            var dataFormat:* = param1;
            var data:* = param2;
            try
            {
                file = data.readByte();
                if (file != 83)
                {
                    dispatchFailure("Malformated script file (wrong header).", ResourceErrorCode.DX_MALFORMED_SCRIPT);
                    return;
                }
                version = data.readByte();
                keyLen = data.readShort();
                key = new ByteArray();
                data.readBytes(key, 0, keyLen);
                swfData = new ByteArray();
                data.readBytes(swfData);
            }
            catch (eof:EOFError)
            {
                dispatchFailure("Malformated script file (end of file).", ResourceErrorCode.DX_MALFORMED_SCRIPT);
                return;
            }
            var swf:* = new ByteArray();
            decipherSwf(swf, swfData, key);
            var loaderContext:* = getUri().loaderContext;
            if (!loaderContext)
            {
                loaderContext = new LoaderContext();
            }
            AirScanner.allowByteCodeExecution(loaderContext, true);
            loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomainShareManager.currentApplicationDomain);
            var ldr:* = new Loader();
            ldr.contentLoaderInfo.addEventListener(Event.INIT, this.onScriptInit);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onScriptError);
            ldr.loadBytes(swf, loaderContext);
            return;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

        private function onScriptInit(event:Event) : void
        {
            var _loc_2:* = (event.target as LoaderInfo).applicationDomain;
            if (_loc_2.hasDefinition("Script"))
            {
                this._scriptClass = _loc_2.getDefinition("Script") as Class;
                dispatchSuccess(null, null);
            }
            else
            {
                dispatchFailure("There wasn\'t any script class inside of the script binaries.", ResourceErrorCode.DX_NO_SCRIPT_INSIDE);
            }
            return;
        }// end function

        private function onScriptError(event:ErrorEvent) : void
        {
            var _loc_2:* = ResourceErrorCode.UNKNOWN_ERROR;
            if (event is IOErrorEvent)
            {
                _loc_2 = ResourceErrorCode.DX_MALFORMED_BINARY;
            }
            else if (event is SecurityErrorEvent)
            {
                _loc_2 = ResourceErrorCode.DX_SECURITY_ERROR;
            }
            dispatchFailure("Script loading from binaries failed: " + event.text, _loc_2);
            return;
        }// end function

        private static function decipherSwf(param1:ByteArray, param2:ByteArray, param3:ByteArray) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_4:* = 0;
            while (param2.bytesAvailable > 0)
            {
                
                _loc_5 = param2.readByte();
                _loc_6 = _loc_5 ^ param3[_loc_4 % param3.length];
                param1.writeByte(_loc_6);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

    }
}
