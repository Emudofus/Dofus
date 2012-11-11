package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.*;

    public class ItemCriterionOperator extends Object implements IDataCenter
    {
        private var _operator:String;
        public static const SUPERIOR:String = ">";
        public static const INFERIOR:String = "<";
        public static const EQUAL:String = "=";
        public static const DIFFERENT:String = "!";
        public static const OPERATORS_LIST:Array = [SUPERIOR, INFERIOR, EQUAL, DIFFERENT, "#", "~", "s", "S", "e", "E", "v", "i", "X", "/"];

        public function ItemCriterionOperator(param1:String)
        {
            this._operator = param1;
            return;
        }// end function

        public function get text() : String
        {
            return this._operator;
        }// end function

        public function compare(param1:int, param2:int) : Boolean
        {
            switch(this._operator)
            {
                case SUPERIOR:
                {
                    if (param1 > param2)
                    {
                        return true;
                    }
                    break;
                }
                case INFERIOR:
                {
                    if (param1 < param2)
                    {
                        return true;
                    }
                    break;
                }
                case EQUAL:
                {
                    if (param1 == param2)
                    {
                        return true;
                    }
                    break;
                }
                case DIFFERENT:
                {
                    if (param1 != param2)
                    {
                        return true;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

    }
}
