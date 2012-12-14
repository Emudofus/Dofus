package flashx.textLayout.conversion
{
    import flash.utils.*;
    import flashx.textLayout.conversion.*;

    class CustomFormatImporter extends Object implements IFormatImporter
    {
        private var _rslt:Dictionary = null;

        function CustomFormatImporter()
        {
            return;
        }// end function

        public function reset() : void
        {
            this._rslt = null;
            return;
        }// end function

        public function get result() : Object
        {
            return this._rslt;
        }// end function

        public function importOneFormat(param1:String, param2:String) : Boolean
        {
            if (this._rslt == null)
            {
                this._rslt = new Dictionary();
            }
            this._rslt[param1] = param2;
            return true;
        }// end function

    }
}
