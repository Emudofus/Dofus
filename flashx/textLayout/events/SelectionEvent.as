package flashx.textLayout.events
{
   import flash.events.Event;
   import flashx.textLayout.edit.SelectionState;
   
   public class SelectionEvent extends Event
   {
      
      public function SelectionEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:SelectionState=null) {
         this._selectionState = param4;
         super(param1,param2,param3);
      }
      
      public static const SELECTION_CHANGE:String = "selectionChange";
      
      private var _selectionState:SelectionState;
      
      public function get selectionState() : SelectionState {
         return this._selectionState;
      }
      
      public function set selectionState(param1:SelectionState) : void {
         this._selectionState = param1;
      }
      
      override public function clone() : Event {
         return new SelectionEvent(type,bubbles,cancelable,this._selectionState);
      }
   }
}
