package com.ankamagames.jerakine.utils.files
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.cache.ICachable;
   import nochump.util.zip.ZipFile;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLLoaderDataFormat;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipEntry;
   
   public class ZipLoader extends EventDispatcher implements ICachable
   {
      
      public function ZipLoader(param1:URLRequest=null, param2:*=null) {
         super();
         if(param1)
         {
            this._name = "ZIP_" + param1.url;
         }
         this._oExtraData = param2;
         if(param1 != null)
         {
            this.load(param1);
         }
      }
      
      private var _zipFile:ZipFile;
      
      private var _files:Array;
      
      private var _filesNames:Array;
      
      private var _oExtraData;
      
      private var _inUse:Boolean;
      
      private var _name:String;
      
      private var _loader:URLLoader;
      
      public var url:String;
      
      public var loaded:Boolean;
      
      public function get inUse() : Boolean {
         return this._inUse;
      }
      
      public function set inUse(param1:Boolean) : void {
         this._inUse = param1;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function set name(param1:String) : void {
         this._name = param1;
      }
      
      public function get extraData() : * {
         return this._oExtraData;
      }
      
      public function load(param1:URLRequest) : void {
         this.loaded = false;
         this._files = new Array();
         this._filesNames = new Array();
         this._name = "ZIP_" + param1.url;
         this._zipFile = null;
         this._loader = new URLLoader();
         this._loader.dataFormat = URLLoaderDataFormat.BINARY;
         this._loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.addEventListener(Event.OPEN,this.onOpen);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.load(param1);
         this.url = param1.url;
      }
      
      public function getFilesList() : Array {
         return this._filesNames;
      }
      
      public function getFileDatas(param1:String) : ByteArray {
         return this._zipFile.getInput(this._files[param1]);
      }
      
      public function fileExists(param1:String) : Boolean {
         var _loc2_:uint = 0;
         while(_loc2_ < this._filesNames.length)
         {
            if(this._filesNames[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function destroy() : void {
         try
         {
            if(this._loader)
            {
               this._loader.close();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onLoadComplete(param1:Event) : void {
         var _loc4_:ZipEntry = null;
         var _loc2_:ByteArray = ByteArray(URLLoader(param1.target).data);
         this._zipFile = new ZipFile(_loc2_);
         var _loc3_:uint = 0;
         while(_loc3_ < this._zipFile.entries.length)
         {
            _loc4_ = this._zipFile.entries[_loc3_];
            this._files[_loc4_.name] = _loc4_;
            this._filesNames.push(_loc4_.name);
            _loc3_++;
         }
         dispatchEvent(param1);
      }
      
      private function onHttpStatus(param1:HTTPStatusEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onOpen(param1:Event) : void {
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onProgress(param1:ProgressEvent) : void {
         dispatchEvent(param1);
      }
   }
}
