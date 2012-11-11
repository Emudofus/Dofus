package com.ankamagames.dofus.network.enums
{

    public class ListAddFailureEnum extends Object
    {
        public static const LIST_ADD_FAILURE_UNKNOWN:uint = 0;
        public static const LIST_ADD_FAILURE_OVER_QUOTA:uint = 1;
        public static const LIST_ADD_FAILURE_NOT_FOUND:uint = 2;
        public static const LIST_ADD_FAILURE_EGOCENTRIC:uint = 3;
        public static const LIST_ADD_FAILURE_IS_DOUBLE:uint = 4;

        public function ListAddFailureEnum()
        {
            return;
        }// end function

    }
}
