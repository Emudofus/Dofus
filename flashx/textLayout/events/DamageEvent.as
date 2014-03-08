package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.elements.TextFlow;
   
   public class DamageEvent extends Event
   {
      
      public function DamageEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:TextFlow=null, param5:int=0, param6:int=0) {
         this._textFlow = param4;
         this._damageAbsoluteStart = param5;
         this._damageLength = param6;
         super(param1,param2,param3);
      }
      
      public static const DAMAGE:String = "damage";
      
      private var _textFlow:TextFlow;
      
      private var _damageAbsoluteStart:int;
      
      private var _damageLength:int;
      
      override public function clone() : Event {
         return new DamageEvent(type,bubbles,cancelable,this._textFlow,this._damageAbsoluteStart,this._damageLength);
      }
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function get damageAbsoluteStart() : int {
         return this._damageAbsoluteStart;
      }
      
      public function get damageLength() : int {
         return this._damageLength;
      }
   }
}
