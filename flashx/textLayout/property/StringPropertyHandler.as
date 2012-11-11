package flashx.textLayout.property
{

    public class StringPropertyHandler extends PropertyHandler
    {

        public function StringPropertyHandler()
        {
            return;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            return param1 is String ? (param1) : (undefined);
        }// end function

    }
}
