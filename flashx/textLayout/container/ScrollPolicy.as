package flashx.textLayout.container
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.property.Property;
   
   use namespace tlf_internal;
   
   public final class ScrollPolicy extends Object
   {
      
      public function ScrollPolicy() {
         super();
      }
      
      public static const AUTO:String = "auto";
      
      public static const OFF:String = "off";
      
      public static const ON:String = "on";
      
      tlf_internal  static const scrollPolicyPropertyDefinition:Property = Property.NewEnumStringProperty("scrollPolicy",ScrollPolicy.AUTO,false,null,ScrollPolicy.AUTO,ScrollPolicy.OFF,ScrollPolicy.ON);
   }
}
