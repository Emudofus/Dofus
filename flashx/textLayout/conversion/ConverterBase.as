package flashx.textLayout.conversion
{
    import __AS3__.vec.*;

    public class ConverterBase extends Object
    {
        private var _errors:Vector.<String> = null;
        private var _throwOnError:Boolean = false;
        private var _useClipboardAnnotations:Boolean = false;
        public static const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";

        public function ConverterBase()
        {
            return;
        }// end function

        public function get errors() : Vector.<String>
        {
            return this._errors;
        }// end function

        public function get throwOnError() : Boolean
        {
            return this._throwOnError;
        }// end function

        public function set throwOnError(param1:Boolean) : void
        {
            this._throwOnError = param1;
            return;
        }// end function

        function clear() : void
        {
            this._errors = null;
            return;
        }// end function

        function reportError(param1:String) : void
        {
            if (this._throwOnError)
            {
                throw new Error(param1);
            }
            if (!this._errors)
            {
                this._errors = new Vector.<String>;
            }
            this._errors.push(param1);
            return;
        }// end function

        public function get useClipboardAnnotations() : Boolean
        {
            return this._useClipboardAnnotations;
        }// end function

        public function set useClipboardAnnotations(param1:Boolean) : void
        {
            this._useClipboardAnnotations = param1;
            return;
        }// end function

    }
}
