package flashx.textLayout.container
{
    import flashx.textLayout.property.*;

    final public class ScrollPolicy extends Object
    {
        public static const AUTO:String = "auto";
        public static const OFF:String = "off";
        public static const ON:String = "on";
        static const scrollPolicyPropertyDefinition:Property = Property.NewEnumStringProperty("scrollPolicy", ScrollPolicy.AUTO, false, null, ScrollPolicy.AUTO, ScrollPolicy.OFF, ScrollPolicy.ON);

        public function ScrollPolicy()
        {
            return;
        }// end function

    }
}
