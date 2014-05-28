package flashx.textLayout.operations
{
   import flashx.undo.IOperation;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.edit.SelectionState;
   import flashx.textLayout.edit.IEditManager;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class FlowOperation extends Object implements IOperation
   {
      
      public function FlowOperation(param1:TextFlow) {
         super();
         this._textFlow = param1;
      }
      
      public var userData;
      
      private var _beginGeneration:uint;
      
      private var _endGeneration:uint;
      
      private var _textFlow:TextFlow;
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function set textFlow(param1:TextFlow) : void {
         this._textFlow = param1;
      }
      
      public function doOperation() : Boolean {
         return false;
      }
      
      public function undo() : SelectionState {
         return null;
      }
      
      public function canUndo() : Boolean {
         return true;
      }
      
      public function redo() : SelectionState {
         return null;
      }
      
      public function get beginGeneration() : uint {
         return this._beginGeneration;
      }
      
      public function get endGeneration() : uint {
         return this._endGeneration;
      }
      
      public function performUndo() : void {
         var _loc1_:IEditManager = this.textFlow?this.textFlow.interactionManager as IEditManager:null;
         if(_loc1_ != null)
         {
            _loc1_.performUndo(this);
         }
      }
      
      public function performRedo() : void {
         var _loc1_:IEditManager = this.textFlow?this.textFlow.interactionManager as IEditManager:null;
         if(_loc1_ != null)
         {
            _loc1_.performRedo(this);
         }
      }
      
      tlf_internal function setGenerations(param1:uint, param2:uint) : void {
         this._beginGeneration = param1;
         this._endGeneration = param2;
      }
      
      tlf_internal function merge(param1:FlowOperation) : FlowOperation {
         return null;
      }
   }
}
