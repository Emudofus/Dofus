package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.UIComponent;

    public class InternalComponentAccess 
    {


        public static function getProperty(target:UIComponent, property:String)
        {
            return (target[property]);
        }

        public static function setProperty(target:UIComponent, property:String, value:*):void
        {
            target[property] = value;
        }


    }
}//package com.ankamagames.berilia.types.graphic

