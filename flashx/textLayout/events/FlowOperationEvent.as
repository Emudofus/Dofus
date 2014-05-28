package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.operations.FlowOperation;
   
   public class FlowOperationEvent extends Event
   {
      
      public function FlowOperationEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:FlowOperation=null, param5:int=0, param6:Error=null) {
         this._op = param4;
         this._e = param6;
         this._level = param5;
         super(param1,param2,param3);
      }
      
      public static const FLOW_OPERATION_BEGIN:String = "flowOperationBegin";
      
      public static const FLOW_OPERATION_END:String = "flowOperationEnd";
      
      public static const FLOW_OPERATION_COMPLETE:String = "flowOperationComplete";
      
      private var _op:FlowOperation;
      
      private var _e:Error;
      
      private var _level:int;
      
      public function get operation() : FlowOperation {
         return this._op;
      }
      
      public function set operation(param1:FlowOperation) : void {
         this._op = param1;
      }
      
      public function get error() : Error {
         return this._e;
      }
      
      public function set error(param1:Error) : void {
         this._e = param1;
      }
      
      public function get level() : int {
         return this._level;
      }
      
      public function set level(param1:int) : void {
         this._level = param1;
      }
      
      override public function clone() : Event {
         return new FlowOperationEvent(type,bubbles,cancelable,this._op,this._level,this._e);
      }
   }
}
