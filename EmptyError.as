package 
{

    class EmptyError extends Error
    {

        function EmptyError()
        {
            return;
        }// end function

        override public function getStackTrace() : String
        {
            return "";
        }// end function

    }
}
