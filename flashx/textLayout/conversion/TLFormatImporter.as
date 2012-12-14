package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;

    public class TLFormatImporter extends Object implements IFormatImporter
    {
        private var _classType:Class;
        private var _description:Object;
        private var _rslt:Object;

        public function TLFormatImporter(param1:Class, param2:Object)
        {
            this._classType = param1;
            this._description = param2;
            return;
        }// end function

        public function get classType() : Class
        {
            return this._classType;
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
            if (this._description.hasOwnProperty(param1))
            {
                if (this._rslt == null)
                {
                    this._rslt = new this._classType();
                }
                this._rslt[param1] = this._description[param1].setHelper(undefined, param2);
                return true;
            }
            return false;
        }// end function

    }
}
