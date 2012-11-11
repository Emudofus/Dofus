package flashx.textLayout.property
{

    public class BooleanPropertyHandler extends PropertyHandler
    {

        public function BooleanPropertyHandler()
        {
            return;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            if (param1 is Boolean)
            {
                return param1;
            }
            if (param1 == "true" || param1 == "false")
            {
                return param1 == "true";
            }
            return undefined;
        }// end function

    }
}
