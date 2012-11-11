package flashx.textLayout.property
{

    public class UndefinedPropertyHandler extends PropertyHandler
    {

        public function UndefinedPropertyHandler()
        {
            return;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            return param1 === null || param1 === undefined ? (true) : (undefined);
        }// end function

        override public function setHelper(param1)
        {
            return undefined;
        }// end function

    }
}
