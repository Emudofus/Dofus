package com.ankamagames.jerakine.utils.display
{
   import flash.utils.ByteArray;
   import flash.events.KeyboardEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class KeyPoll extends Object
   {
      
      public function KeyPoll() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.states = new ByteArray();
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            this.states.writeUnsignedInt(0);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener,false,0,true);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpListener,false,0,true);
            StageShareManager.stage.addEventListener(Event.ACTIVATE,this.activateListener,false,0,true);
            StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.deactivateListener,false,0,true);
            return;
         }
      }
      
      private static var _self:KeyPoll;
      
      public static function getInstance() : KeyPoll {
         if(!_self)
         {
            _self = new KeyPoll();
         }
         return _self;
      }
      
      private var states:ByteArray;
      
      private function keyDownListener(ev:KeyboardEvent) : void {
         this.states[ev.keyCode >>> 3] = this.states[ev.keyCode >>> 3] | 1 << (ev.keyCode & 7);
      }
      
      private function keyUpListener(ev:KeyboardEvent) : void {
         this.states[ev.keyCode >>> 3] = this.states[ev.keyCode >>> 3] & ~(1 << (ev.keyCode & 7));
      }
      
      private function activateListener(ev:Event) : void {
         var i:int = 0;
         while(i < 32)
         {
            this.states[i] = 0;
            i++;
         }
      }
      
      private function deactivateListener(ev:Event) : void {
         var i:int = 0;
         while(i < 32)
         {
            this.states[i] = 0;
            i++;
         }
      }
      
      public function isDown(keyCode:uint) : Boolean {
         return !((this.states[keyCode >>> 3] & 1 << (keyCode & 7)) == 0);
      }
      
      public function isUp(keyCode:uint) : Boolean {
         return (this.states[keyCode >>> 3] & 1 << (keyCode & 7)) == 0;
      }
   }
}
