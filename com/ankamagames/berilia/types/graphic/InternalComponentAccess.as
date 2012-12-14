package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;

    public class InternalComponentAccess extends Object
    {

        public function InternalComponentAccess()
        {
            return;
        }// end function

        public static function getProperty(param1:UIComponent, param2:String)
        {
            return param1[param2];
        }// end function

        public static function setProperty(param1:UIComponent, param2:String, param3) : void
        {
            param1[param2] = param3;
            return;
        }// end function

    }
}
