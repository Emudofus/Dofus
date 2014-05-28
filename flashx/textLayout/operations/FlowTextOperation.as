package flashx.textLayout.operations
{
   import flashx.textLayout.edit.SelectionState;
   
   public class FlowTextOperation extends FlowOperation
   {
      
      public function FlowTextOperation(param1:SelectionState) {
         super(param1.textFlow);
         this._absoluteStart = param1.absoluteStart;
         this._absoluteEnd = param1.absoluteEnd;
         this._originalSelectionState = param1;
      }
      
      private var _originalSelectionState:SelectionState;
      
      private var _absoluteStart:int;
      
      private var _absoluteEnd:int;
      
      public function get absoluteStart() : int {
         return this._absoluteStart;
      }
      
      public function set absoluteStart(param1:int) : void {
         this._absoluteStart = param1;
      }
      
      public function get absoluteEnd() : int {
         return this._absoluteEnd;
      }
      
      public function set absoluteEnd(param1:int) : void {
         this._absoluteEnd = param1;
      }
      
      public function get originalSelectionState() : SelectionState {
         return this._originalSelectionState;
      }
      
      public function set originalSelectionState(param1:SelectionState) : void {
         this._originalSelectionState = param1;
      }
      
      override public function redo() : SelectionState {
         doOperation();
         return this._originalSelectionState;
      }
   }
}
