package flashx.textLayout.edit
{
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.TextFlow;
   
   use namespace tlf_internal;
   
   public class SelectionState extends TextRange
   {
      
      public function SelectionState(param1:TextFlow, param2:int, param3:int, param4:ITextLayoutFormat=null) {
         super(param1,param2,param3);
         if(param4)
         {
            this._pointFormat = param4;
         }
      }
      
      private var _pointFormat:ITextLayoutFormat;
      
      private var _selectionManagerOperationState:Boolean;
      
      override public function updateRange(param1:int, param2:int) : Boolean {
         if(super.updateRange(param1,param2))
         {
            this._pointFormat = null;
            return true;
         }
         return false;
      }
      
      public function get pointFormat() : ITextLayoutFormat {
         return this._pointFormat;
      }
      
      public function set pointFormat(param1:ITextLayoutFormat) : void {
         this._pointFormat = param1;
      }
      
      tlf_internal function get selectionManagerOperationState() : Boolean {
         return this._selectionManagerOperationState;
      }
      
      tlf_internal function set selectionManagerOperationState(param1:Boolean) : void {
         this._selectionManagerOperationState = param1;
      }
      
      tlf_internal function clone() : SelectionState {
         return new SelectionState(textFlow,anchorPosition,activePosition,this.pointFormat);
      }
   }
}
