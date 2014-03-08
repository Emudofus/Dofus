package flashx.textLayout.conversion
{
   import __AS3__.vec.Vector;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ConverterBase extends Object
   {
      
      public function ConverterBase() {
         super();
      }
      
      public static const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";
      
      private var _errors:Vector.<String> = null;
      
      private var _throwOnError:Boolean = false;
      
      private var _useClipboardAnnotations:Boolean = false;
      
      public function get errors() : Vector.<String> {
         return this._errors;
      }
      
      public function get throwOnError() : Boolean {
         return this._throwOnError;
      }
      
      public function set throwOnError(param1:Boolean) : void {
         this._throwOnError = param1;
      }
      
      tlf_internal function clear() : void {
         this._errors = null;
      }
      
      tlf_internal function reportError(param1:String) : void {
         if(this._throwOnError)
         {
            throw new Error(param1);
         }
         else
         {
            if(!this._errors)
            {
               this._errors = new Vector.<String>();
            }
            this._errors.push(param1);
            return;
         }
      }
      
      public function get useClipboardAnnotations() : Boolean {
         return this._useClipboardAnnotations;
      }
      
      public function set useClipboardAnnotations(param1:Boolean) : void {
         this._useClipboardAnnotations = param1;
      }
   }
}
