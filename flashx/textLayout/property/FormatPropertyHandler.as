package flashx.textLayout.property
{

    public class FormatPropertyHandler extends PropertyHandler
    {
        private var _converter:Function;

        public function FormatPropertyHandler()
        {
            return;
        }// end function

        public function get converter() : Function
        {
            return this._converter;
        }// end function

        public function set converter(param1:Function) : void
        {
            this._converter = param1;
            return;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            return param1 is String ? (undefined) : (param1);
        }// end function

        override public function setHelper(param1)
        {
            return this._converter(param1);
        }// end function

    }
}
