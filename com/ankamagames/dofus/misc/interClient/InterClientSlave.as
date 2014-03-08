package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.LocalConnection;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.events.AsyncErrorEvent;
   import flash.events.StatusEvent;
   import flash.events.Event;
   import flash.events.SecurityErrorEvent;
   
   public class InterClientSlave extends Object
   {
      
      public function InterClientSlave() {
         this._waitingFocusMessage = new Array();
         super();
         this._receiving_lc = new LocalConnection();
         this._sending_lc = new LocalConnection();
         this._sending_lc.allowDomain("*");
         this._sending_lc.allowInsecureDomain("*");
         this._sending_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._sending_lc.addEventListener(StatusEvent.STATUS,this.onStatusEvent);
         this._receiving_lc.allowDomain("*");
         this._receiving_lc.allowInsecureDomain("*");
         this._receiving_lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         this._receiving_lc.addEventListener(StatusEvent.STATUS,this.onStatusEvent);
         var idIsFree:Boolean = false;
         while(!idIsFree)
         {
            this.connId = "_dofus" + Math.floor(Math.random() * 100000000);
            try
            {
               this._receiving_lc.connect(this.connId);
               idIsFree = true;
            }
            catch(e:Error)
            {
               continue;
            }
         }
         this._sending_lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._sending_lc.addEventListener(StatusEvent.STATUS,this.onStatusChange);
         this._receiving_lc.client = new Object();
         this._receiving_lc.client.setUId = this.setUId;
         this._receiving_lc.client.pong = this.pong;
         this._receiving_lc.client.updateFocusMessage = this.updateFocusMessage;
         this._statusTimer = new Timer(10000);
         this._statusTimer.addEventListener(TimerEvent.TIMER,this.onTick);
         this._statusTimer.start();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientSlave));
      
      private var _receiving_lc:LocalConnection;
      
      private var _sending_lc:LocalConnection;
      
      private var _statusTimer:Timer;
      
      private var _waitingFocusMessage:Array;
      
      public var connId:String;
      
      public function destroy() : void {
         this._receiving_lc.close();
         this._statusTimer.removeEventListener(TimerEvent.TIMER,this.onTick);
      }
      
      public function gainFocus(time:Number) : void {
         var message:String = null;
         message = this.connId + "," + time;
         try
         {
            this._sending_lc.send("_dofus","clientGainFocus",message);
         }
         catch(e:Error)
         {
            _waitingFocusMessage.push(message);
         }
      }
      
      public function retreiveUid() : void {
         this._sending_lc.send("_dofus","getUid",this.connId);
      }
      
      public function updateFocusMessage(focusList:String) : void {
         _log.info("Client : " + focusList);
         InterClientManager.getInstance().clientListInfo = focusList.split(",");
         InterClientManager.getInstance().updateFocusList();
      }
      
      private function setUId(uid:String) : void {
         var so:CustomSharedObject = CustomSharedObject.getLocal("uid");
         InterClientManager.getInstance().flashKey = uid;
         so.data["identity"] = uid;
         so.flush();
         so.close();
      }
      
      private function pong() : void {
      }
      
      private function onError(e:AsyncErrorEvent) : void {
         _log.debug(e.error.getStackTrace());
      }
      
      private function onStatusEvent(e:StatusEvent) : void {
      }
      
      private function onTick(e:Event) : void {
         this._sending_lc.send("_dofus","ping",this.connId);
      }
      
      private function onStatusChange(e:StatusEvent) : void {
         if(e.level == "error")
         {
            InterClientManager.getInstance().update();
            while(this._waitingFocusMessage.length)
            {
               this._sending_lc.send("_dofus","clientGainFocus",this._waitingFocusMessage.shift());
            }
         }
      }
      
      private function onSecurityError(e:Error) : void {
      }
   }
}
