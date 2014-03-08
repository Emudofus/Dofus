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
      
      public function ZipLoader(fileRequest:URLRequest=null, oExtraData:*=null) {
         super();
         if(fileRequest)
         {
            this._name = "ZIP_" + fileRequest.url;
         }
         this._oExtraData = oExtraData;
         if(fileRequest != null)
         {
            this.load(fileRequest);
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
      
      public function set inUse(value:Boolean) : void {
         this._inUse = value;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function set name(value:String) : void {
         this._name = value;
      }
      
      public function get extraData() : * {
         return this._oExtraData;
      }
      
      public function load(request:URLRequest) : void {
         this.loaded = false;
         this._files = new Array();
         this._filesNames = new Array();
         this._name = "ZIP_" + request.url;
         this._zipFile = null;
         this._loader = new URLLoader();
         this._loader.dataFormat = URLLoaderDataFormat.BINARY;
         this._loader.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHttpStatus);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._loader.addEventListener(Event.OPEN,this.onOpen);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._loader.load(request);
         this.url = request.url;
      }
      
      public function getFilesList() : Array {
         return this._filesNames;
      }
      
      public function getFileDatas(fileName:String) : ByteArray {
         return this._zipFile.getInput(this._files[fileName]);
      }
      
      public function fileExists(fileName:String) : Boolean {
         var i:uint = 0;
         while(i < this._filesNames.length)
         {
            if(this._filesNames[i] == fileName)
            {
               return true;
            }
            i++;
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
      
      private function onLoadComplete(e:Event) : void {
         var entry:ZipEntry = null;
         var zipData:ByteArray = ByteArray(URLLoader(e.target).data);
         this._zipFile = new ZipFile(zipData);
         var i:uint = 0;
         while(i < this._zipFile.entries.length)
         {
            entry = this._zipFile.entries[i];
            this._files[entry.name] = entry;
            this._filesNames.push(entry.name);
            i++;
         }
         dispatchEvent(e);
      }
      
      private function onHttpStatus(httpse:HTTPStatusEvent) : void {
         dispatchEvent(httpse);
      }
      
      private function onIOError(ioe:IOErrorEvent) : void {
         dispatchEvent(ioe);
      }
      
      private function onOpen(e:Event) : void {
         dispatchEvent(e);
      }
      
      private function onSecurityError(se:SecurityErrorEvent) : void {
         dispatchEvent(se);
      }
      
      private function onProgress(pe:ProgressEvent) : void {
         dispatchEvent(pe);
      }
   }
}
