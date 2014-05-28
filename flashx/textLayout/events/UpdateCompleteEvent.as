package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.TextFlow;
   
   public class UpdateCompleteEvent extends Event
   {
      
      public function UpdateCompleteEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:TextFlow=null, param5:ContainerController=null) {
         super(param1,param2,param3);
         this.controller = param5;
         this._textFlow = param4;
      }
      
      public static const UPDATE_COMPLETE:String = "updateComplete";
      
      private var _controller:ContainerController;
      
      private var _textFlow:TextFlow;
      
      override public function clone() : Event {
         return new UpdateCompleteEvent(type,bubbles,cancelable,this._textFlow,this._controller);
      }
      
      public function get controller() : ContainerController {
         return this._controller;
      }
      
      public function set controller(param1:ContainerController) : void {
         this._controller = param1;
      }
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function set textFlow(param1:TextFlow) : void {
         this._textFlow = param1;
      }
   }
}
