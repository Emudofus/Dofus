package types
{
   public class ConfigProperty extends Object
   {
      
      public function ConfigProperty(associatedComponent:String, associatedProperty:String, associatedConfigModule:String) {
         super();
         this.associatedComponent = associatedComponent;
         this.associatedConfigModule = associatedConfigModule;
         this.associatedProperty = associatedProperty;
      }
      
      public var associatedComponent:Object;
      
      public var associatedProperty:String;
      
      public var associatedConfigModule:String;
   }
}
