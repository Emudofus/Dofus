package com.hurlant.util.der
{
    import com.hurlant.util.der.*;

    dynamic public class Set extends Sequence implements IAsn1Type
    {

        public function Set(param1:uint = 49, param2:uint = 0)
        {
            super(param1, param2);
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = null;
            _loc_1 = DER.indent;
            DER.indent = DER.indent + "    ";
            var _loc_2:* = join("\n");
            DER.indent = _loc_1;
            return DER.indent + "Set[" + type + "][" + len + "][\n" + _loc_2 + "\n" + _loc_1 + "]";
        }// end function

    }
}
