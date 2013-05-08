package flashx.textLayout.edit
{
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.TextFlow;

   use namespace tlf_internal;

   public class SelectionState extends TextRange
   {
         

      public function SelectionState(root:TextFlow, anchorPosition:int, activePosition:int, format:ITextLayoutFormat=null) {
         super(root,anchorPosition,activePosition);
         if(format)
         {
            this._pointFormat=format;
         }
      }



      private var _pointFormat:ITextLayoutFormat;

      private var _selectionManagerOperationState:Boolean;

      override public function updateRange(newAnchorPosition:int, newActivePosition:int) : Boolean {
         if(super.updateRange(newAnchorPosition,newActivePosition))
         {
            this._pointFormat=null;
            return true;
         }
         return false;
      }

      public function get pointFormat() : ITextLayoutFormat {
         return this._pointFormat;
      }

      public function set pointFormat(format:ITextLayoutFormat) : void {
         this._pointFormat=format;
      }

      tlf_internal function get selectionManagerOperationState() : Boolean {
         return this._selectionManagerOperationState;
      }

      tlf_internal function set selectionManagerOperationState(val:Boolean) : void {
         this._selectionManagerOperationState=val;
      }

      tlf_internal function clone() : SelectionState {
         return new SelectionState(textFlow,anchorPosition,activePosition,this.pointFormat);
      }
   }

}