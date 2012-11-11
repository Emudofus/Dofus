package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import flash.net.*;
    import flash.utils.*;

    public class SignedFileAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {
        private var _signatureKey:SignatureKey;
        private var _uri:Uri;
        private var _resourceObserverWrapper:ResourceObserverWrapper;
        private var _resource:Object;
        private var _rawContent:Boolean;
        private static var _defaultSignatureKey:SignatureKey;

        public function SignedFileAdapter(param1:SignatureKey = null, param2:Boolean = false)
        {
            this._rawContent = param2;
            if (param1)
            {
                this._signatureKey = param1;
            }
            else
            {
                this._signatureKey = _defaultSignatureKey;
            }
            if (!this._signatureKey)
            {
                throw new ArgumentError("A signature key must be defined (you can also set defaultSignatureKey)");
            }
            return;
        }// end function

        override public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
        {
            this._uri = param1;
            super.loadDirectly(param1, param2, param3, param4);
            return;
        }// end function

        override public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
        {
            this._uri = param1;
            super.loadFromData(param1, param2, param3, param4);
            return;
        }// end function

        override public function free() : void
        {
            this._resource = null;
            this._resourceObserverWrapper = null;
            this._uri = null;
            super.free();
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return this._resource;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_SIGNED_FILE;
        }// end function

        override protected function process(param1:String, param2) : void
        {
            var dataFormat:* = param1;
            var data:* = param2;
            var sig:* = new Signature(this._signatureKey);
            var content:* = new ByteArray();
            try
            {
                if (!sig.verify(data, content))
                {
                    dispatchFailure("Invalid signature", ResourceErrorCode.INVALID_SIGNATURE);
                    return;
                }
            }
            catch (e:Error)
            {
                dispatchFailure("Invalid signature : " + e.message, ResourceErrorCode.INVALID_SIGNATURE);
            }
            var contentUri:* = new Uri(this._uri.path.substr(0, (this._uri.path.length - 1)));
            var contentAdapter:* = AdapterFactory.getAdapter(contentUri);
            if (!contentAdapter)
            {
                dispatchFailure("Cannot found any adapted adpter for file content", ResourceErrorCode.INCOMPATIBLE_ADAPTER);
                return;
            }
            if (!this._rawContent)
            {
                if (!this._resourceObserverWrapper)
                {
                    this._resourceObserverWrapper = new ResourceObserverWrapper(this.onContentLoad, this.onContentLoadFailed);
                }
                contentAdapter.loadFromData(this._uri, content, this._resourceObserverWrapper, false);
            }
            else
            {
                this.onContentLoad(this._uri, ResourceType.RESOURCE_BINARY, content);
            }
            return;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

        private function onContentLoad(param1:Uri, param2:uint, param3) : void
        {
            this._resource = param3;
            dispatchSuccess(ResourceType.getName(param2), param3);
            return;
        }// end function

        private function onContentLoadFailed(param1:Uri, param2:String, param3:uint) : void
        {
            dispatchFailure(param2, param3);
            return;
        }// end function

        public static function set defaultSignatureKey(param1:SignatureKey) : void
        {
            _defaultSignatureKey = param1;
            return;
        }// end function

        public static function get defaultSignatureKey() : SignatureKey
        {
            return _defaultSignatureKey;
        }// end function

    }
}
