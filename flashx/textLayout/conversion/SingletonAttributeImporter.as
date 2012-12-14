package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;

    class SingletonAttributeImporter extends Object implements IFormatImporter
    {
        private var _keyToMatch:String;
        private var _rslt:String = null;

        function SingletonAttributeImporter(param1:String)
        {
            this._keyToMatch = param1;
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
            if (param1 == this._keyToMatch)
            {
                this._rslt = param2;
                return true;
            }
            return false;
        }// end function

    }
}
