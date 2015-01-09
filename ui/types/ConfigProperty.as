package types
{
    public class ConfigProperty 
    {

        public var associatedComponent:Object;
        public var associatedProperty:String;
        public var associatedConfigModule:String;

        public function ConfigProperty(associatedComponent:String, associatedProperty:String, associatedConfigModule:String)
        {
            this.associatedComponent = associatedComponent;
            this.associatedConfigModule = associatedConfigModule;
            this.associatedProperty = associatedProperty;
        }

    }
}//package types

