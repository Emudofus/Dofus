package flashx.textLayout.property
{

    public class EnumPropertyHandler extends PropertyHandler
    {
        private var _range:Object;

        public function EnumPropertyHandler(param1:Array)
        {
            this._range = PropertyHandler.createRange(param1);
            return;
        }// end function

        public function get range() : Object
        {
            return Property.shallowCopy(this._range);
        }// end function

        override public function owningHandlerCheck(param1)
        {
            return this._range.hasOwnProperty(param1) ? (param1) : (undefined);
        }// end function

    }
}
