package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
    import com.ankamagames.jerakine.resources.adapters.IAdapter;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.resources.ResourceType;
    import com.ankamagames.jerakine.resources.ResourceErrorCode;
    import flash.errors.EOFError;
    import flash.system.LoaderContext;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.system.ApplicationDomain;
    import com.ankamagames.jerakine.utils.misc.ApplicationDomainShareManager;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoaderDataFormat;
    import flash.display.LoaderInfo;
    import flash.events.SecurityErrorEvent;
    import flash.events.ErrorEvent;

    public class DxAdapter extends AbstractUrlLoaderAdapter implements IAdapter 
    {

        private var _scriptClass:Class;


        private static function decipherSwf(output:ByteArray, input:ByteArray, key:ByteArray):void
        {
            var b:int;
            var d:int;
            var i:uint;
            while (input.bytesAvailable > 0)
            {
                b = input.readByte();
                d = (b ^ key[(i % key.length)]);
                output.writeByte(d);
                i++;
            };
        }


        override protected function getResource(dataFormat:String, data:*)
        {
            return (this._scriptClass);
        }

        override public function getResourceType():uint
        {
            return (ResourceType.RESOURCE_DX);
        }

        override protected function process(dataFormat:String, data:*):void
        {
            var file:uint;
            var version:uint;
            var keyLen:int;
            var key:ByteArray;
            var swfData:ByteArray;
            try
            {
                file = data.readByte();
                if (file != 83)
                {
                    dispatchFailure("Malformated script file (wrong header).", ResourceErrorCode.DX_MALFORMED_SCRIPT);
                    return;
                };
                version = data.readByte();
                keyLen = data.readShort();
                key = new ByteArray();
                data.readBytes(key, 0, keyLen);
                swfData = new ByteArray();
                data.readBytes(swfData);
            }
            catch(eof:EOFError)
            {
                dispatchFailure("Malformated script file (end of file).", ResourceErrorCode.DX_MALFORMED_SCRIPT);
                return;
            };
            var swf:ByteArray = new ByteArray();
            decipherSwf(swf, swfData, key);
            var loaderContext:LoaderContext = getUri().loaderContext;
            if (!(loaderContext))
            {
                loaderContext = new LoaderContext();
            };
            AirScanner.allowByteCodeExecution(loaderContext, true);
            loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomainShareManager.currentApplicationDomain);
            var ldr:Loader = new Loader();
            ldr.contentLoaderInfo.addEventListener(Event.INIT, this.onScriptInit);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onScriptError);
            ldr.loadBytes(swf, loaderContext);
        }

        override protected function getDataFormat():String
        {
            return (URLLoaderDataFormat.BINARY);
        }

        private function onScriptInit(e:Event):void
        {
            var ap:ApplicationDomain = (e.target as LoaderInfo).applicationDomain;
            if (ap.hasDefinition("Script"))
            {
                this._scriptClass = (ap.getDefinition("Script") as Class);
                dispatchSuccess(null, null);
            }
            else
            {
                dispatchFailure("There wasn't any script class inside of the script binaries.", ResourceErrorCode.DX_NO_SCRIPT_INSIDE);
            };
        }

        private function onScriptError(ee:ErrorEvent):void
        {
            var errCode:uint = ResourceErrorCode.UNKNOWN_ERROR;
            if ((ee is IOErrorEvent))
            {
                errCode = ResourceErrorCode.DX_MALFORMED_BINARY;
            }
            else
            {
                if ((ee is SecurityErrorEvent))
                {
                    errCode = ResourceErrorCode.DX_SECURITY_ERROR;
                };
            };
            dispatchFailure(("Script loading from binaries failed: " + ee.text), errCode);
        }


    }
}//package com.ankamagames.jerakine.resources.adapters.impl

