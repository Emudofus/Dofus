package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.utils.crypto.SignatureKey;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.ResourceObserverWrapper;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.adapters.AdapterFactory;
   import flash.net.URLLoaderDataFormat;
   
   public class SignedFileAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function SignedFileAdapter(param1:SignatureKey = null, param2:Boolean = false)
      {
         super();
         this._rawContent = param2;
         if(param1)
         {
            this._signatureKey = param1;
         }
         else
         {
            this._signatureKey = _defaultSignatureKey;
         }
         if(!this._signatureKey)
         {
            throw new ArgumentError("A signature key must be defined (you can also set defaultSignatureKey)");
         }
         else
         {
            return;
         }
      }
      
      private static var _defaultSignatureKey:SignatureKey;
      
      public static function set defaultSignatureKey(param1:SignatureKey) : void
      {
         _defaultSignatureKey = param1;
      }
      
      public static function get defaultSignatureKey() : SignatureKey
      {
         return _defaultSignatureKey;
      }
      
      private var _signatureKey:SignatureKey;
      
      private var _uri:Uri;
      
      private var _resourceObserverWrapper:ResourceObserverWrapper;
      
      private var _resource;
      
      private var _rawContent:Boolean;
      
      override public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
      {
         this._uri = param1;
         super.loadDirectly(param1,param2,param3,param4);
      }
      
      override public function loadFromData(param1:Uri, param2:ByteArray, param3:IResourceObserver, param4:Boolean) : void
      {
         this._uri = param1;
         super.loadFromData(param1,param2,param3,param4);
      }
      
      override public function free() : void
      {
         this._resource = null;
         this._resourceObserverWrapper = null;
         this._uri = null;
         super.free();
      }
      
      override protected function getResource(param1:String, param2:*) : *
      {
         return this._resource;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_SIGNED_FILE;
      }
      
      override protected function process(param1:String, param2:*) : void
      {
         var dataFormat:String = param1;
         var data:* = param2;
         var sig:Signature = new Signature(this._signatureKey);
         var content:ByteArray = new ByteArray();
         try
         {
            if(!sig.verify(data,content))
            {
               dispatchFailure("Invalid signature",ResourceErrorCode.INVALID_SIGNATURE);
               return;
            }
         }
         catch(e:Error)
         {
            dispatchFailure("Invalid signature : " + e.message,ResourceErrorCode.INVALID_SIGNATURE);
         }
         var contentUri:Uri = new Uri(this._uri.path.substr(0,this._uri.path.length - 1));
         var contentAdapter:IAdapter = AdapterFactory.getAdapter(contentUri);
         if(!contentAdapter)
         {
            dispatchFailure("Cannot found any adapted adpter for file content",ResourceErrorCode.INCOMPATIBLE_ADAPTER);
            return;
         }
         if(!this._rawContent)
         {
            if(!this._resourceObserverWrapper)
            {
               this._resourceObserverWrapper = new ResourceObserverWrapper(this.onContentLoad,this.onContentLoadFailed);
            }
            contentAdapter.loadFromData(this._uri,content,this._resourceObserverWrapper,false);
         }
         else
         {
            this.onContentLoad(this._uri,ResourceType.RESOURCE_BINARY,content);
         }
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
      
      private function onContentLoad(param1:Uri, param2:uint, param3:*) : void
      {
         var _loc4_:* = false;
         var _loc5_:* = true;
         if(_loc5_)
         {
            this._resource = param3;
            if(_loc5_)
            {
            }
            return;
         }
         dispatchSuccess(ResourceType.getName(param2),param3);
      }
      
      private function onContentLoadFailed(param1:Uri, param2:String, param3:uint) : void
      {
         var _loc4_:* = true;
         var _loc5_:* = false;
         if(!_loc5_)
         {
            dispatchFailure(param2,param3);
         }
      }
   }
}
