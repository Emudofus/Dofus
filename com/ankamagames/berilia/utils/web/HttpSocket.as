package com.ankamagames.berilia.utils.web
{
   import flash.events.EventDispatcher;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.events.ProgressEvent;
   import flash.events.Event;
   
   public class HttpSocket extends EventDispatcher
   {
      
      public function HttpSocket(param1:Socket, param2:String) {
         super();
         this.requestSocket = param1;
         this.requestBuffer = new ByteArray();
         this.requestSocket.addEventListener(ProgressEvent.SOCKET_DATA,this.onRequestSocketData);
         this.requestSocket.addEventListener(Event.CLOSE,this.onRequestSocketClose);
         this._rootPath = param2;
      }
      
      private static const SEPERATOR:RegExp = new RegExp(new RegExp("\\r?\\n\\r?\\n"));
      
      private static const NL:RegExp = new RegExp(new RegExp("\\r?\\n"));
      
      private var requestSocket:Socket;
      
      private var requestBuffer:ByteArray;
      
      private var _rootPath:String;
      
      public function get rootPath() : String {
         return this._rootPath;
      }
      
      private function onRequestSocketData(param1:ProgressEvent) : void {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:HttpResponder = null;
         this.requestSocket.readBytes(this.requestBuffer,this.requestBuffer.length,this.requestSocket.bytesAvailable);
         var _loc2_:String = this.requestBuffer.toString();
         var _loc3_:Number = _loc2_.search(SEPERATOR);
         if(_loc3_ != -1)
         {
            _loc4_ = _loc2_.substring(0,_loc3_);
            _loc5_ = _loc4_.substring(0,_loc4_.search(NL));
            _loc6_ = _loc5_.split(" ");
            _loc7_ = _loc6_[0];
            _loc8_ = _loc6_[1];
            _loc8_ = _loc8_.replace(new RegExp("^http(s)?:\\/\\/"),"");
            _loc9_ = _loc8_.substring(_loc8_.indexOf("/"),_loc8_.length);
            _loc10_ = new HttpResponder(this.requestSocket,_loc7_,_loc9_,this._rootPath);
         }
         if(_loc3_ != -1)
         {
            return;
         }
      }
      
      private function onRequestSocketClose(param1:Event) : void {
         this.done();
      }
      
      private function done() : void {
         this.tearDown();
         var _loc1_:Event = new Event(Event.COMPLETE);
         this.dispatchEvent(_loc1_);
      }
      
      private function testSocket(param1:Socket) : Boolean {
         if(!param1.connected)
         {
            this.done();
            return false;
         }
         return true;
      }
      
      public function tearDown() : void {
         if(!(this.requestSocket == null) && (this.requestSocket.connected))
         {
            this.requestSocket.flush();
            this.requestSocket.close();
         }
      }
   }
}
